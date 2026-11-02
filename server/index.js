/**
 * War of the States — multiplayer lobby + relay
 *
 * Authority model: HOST-AUTHORITATIVE
 * - The officer who creates a room runs the full simulation in their browser
 *   (AI, hits, health, morale, formation).
 * - This Node process only: serves static files, creates/joins rooms, and
 *   relays messages between peers. It does not simulate combat.
 *
 * Run: npm install && npm start
 * Default: http://0.0.0.0:8787  (set PORT to override)
 */
"use strict";

const http = require("http");
const fs = require("fs");
const path = require("path");
const os = require("os");
const { WebSocketServer } = require("ws");

const PORT = Number(process.env.PORT || 8787);
const ROOT = path.resolve(process.env.ROOT || path.join(__dirname, "../prototype"));

const MIME = {
  ".html": "text/html; charset=utf-8",
  ".js": "text/javascript; charset=utf-8",
  ".css": "text/css; charset=utf-8",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".svg": "image/svg+xml",
  ".json": "application/json",
  ".md": "text/markdown; charset=utf-8",
  ".ico": "image/x-icon"
};

function lanIPs() {
  const out = [];
  const ifs = os.networkInterfaces();
  Object.keys(ifs).forEach((name) => {
    (ifs[name] || []).forEach((addr) => {
      if (addr.family === "IPv4" && !addr.internal) out.push(addr.address);
    });
  });
  return out;
}

function sendJson(res, code, obj) {
  const body = JSON.stringify(obj);
  res.writeHead(code, {
    "Content-Type": "application/json; charset=utf-8",
    "Content-Length": Buffer.byteLength(body),
    "Access-Control-Allow-Origin": "*"
  });
  res.end(body);
}

function serveStatic(req, res) {
  let urlPath = decodeURIComponent((req.url || "/").split("?")[0]);
  if (urlPath === "/api/info") {
    return sendJson(res, 200, {
      port: PORT,
      lan: lanIPs(),
      authority: "host",
      note: "Host browser is authoritative; this server relays only."
    });
  }
  if (urlPath === "/") urlPath = "/index.html";
  // Prevent path escape
  const filePath = path.normalize(path.join(ROOT, urlPath));
  if (!filePath.startsWith(ROOT)) {
    res.writeHead(403); res.end("Forbidden"); return;
  }
  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404, { "Content-Type": "text/plain" });
      res.end("Not found: " + urlPath);
      return;
    }
    const ext = path.extname(filePath).toLowerCase();
    res.writeHead(200, { "Content-Type": MIME[ext] || "application/octet-stream" });
    res.end(data);
  });
}

const server = http.createServer(serveStatic);
const wss = new WebSocketServer({ server });

/** @type {Map<string, {code:string, hostId:string|null, clients:Map<string,any>}>} */
const rooms = new Map();
let nextId = 1;

function roomCode() {
  const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
  let s = "";
  for (let i = 0; i < 5; i++) s += alphabet[(Math.random() * alphabet.length) | 0];
  return s;
}

function send(ws, obj) {
  if (ws.readyState === 1) ws.send(JSON.stringify(obj));
}

function broadcast(room, obj, exceptId) {
  const msg = JSON.stringify(obj);
  room.clients.forEach((c) => {
    if (exceptId && c.id === exceptId) return;
    if (c.ws.readyState === 1) c.ws.send(msg);
  });
}

function roster(room) {
  const list = [];
  room.clients.forEach((c) => {
    list.push({ id: c.id, role: c.role, side: c.side, name: c.name });
  });
  return list;
}

wss.on("connection", (ws) => {
  const client = {
    id: "p" + (nextId++),
    ws,
    room: null,
    role: null,
    side: null,
    name: "Soldier"
  };

  send(ws, {
    t: "hello",
    id: client.id,
    lan: lanIPs(),
    port: PORT,
    authority: "host"
  });

  ws.on("message", (raw) => {
    let msg;
    try { msg = JSON.parse(String(raw)); } catch (e) { return; }
    if (!msg || !msg.t) return;

    if (msg.t === "create") {
      if (client.room) return;
      let code = roomCode();
      while (rooms.has(code)) code = roomCode();
      const room = { code, hostId: client.id, clients: new Map() };
      rooms.set(code, room);
      client.room = code;
      client.role = "officer";
      client.side = "union";
      client.name = msg.name || "Officer";
      room.clients.set(client.id, client);
      send(ws, {
        t: "created",
        room: code,
        id: client.id,
        role: "officer",
        side: "union",
        host: true,
        lan: lanIPs(),
        port: PORT,
        roster: roster(room)
      });
      return;
    }

    if (msg.t === "join") {
      if (client.room) return;
      const code = String(msg.room || "").toUpperCase().trim();
      const room = rooms.get(code);
      if (!room) {
        send(ws, { t: "error", error: "Room not found" });
        return;
      }
      const side = msg.side === "csa" ? "csa" : "union";
      // Exactly one officer — host only. Joiners are privates.
      if (msg.role === "officer") {
        send(ws, { t: "error", error: "Officer slot taken — join as Private" });
        return;
      }
      client.room = code;
      client.role = "private";
      client.side = side;
      client.name = msg.name || "Private";
      room.clients.set(client.id, client);
      send(ws, {
        t: "joined",
        room: code,
        id: client.id,
        role: "private",
        side,
        host: false,
        hostId: room.hostId,
        roster: roster(room)
      });
      broadcast(room, {
        t: "peer_join",
        id: client.id,
        role: client.role,
        side: client.side,
        name: client.name,
        roster: roster(room)
      }, client.id);
      return;
    }

    if (msg.t === "list") {
      const codes = [];
      rooms.forEach((r) => codes.push({ code: r.code, players: r.clients.size, hostId: r.hostId }));
      send(ws, { t: "rooms", rooms: codes });
      return;
    }

    // Relay within room
    if (!client.room) return;
    const room = rooms.get(client.room);
    if (!room) return;

    // Tag sender
    msg.from = client.id;
    msg.role = client.role;

    // Host-only simulation traffic: snap, hit_apply, ai_state, cmd (commands also from officer)
    if (msg.t === "snap" || msg.t === "hit_apply" || msg.t === "ai_full") {
      if (client.id !== room.hostId) return; // only host broadcasts world
      broadcast(room, msg, null);
      return;
    }

    if (msg.t === "cmd") {
      if (client.role !== "officer") return;
      broadcast(room, msg, null);
      return;
    }

    if (msg.t === "gb_choice") {
      // Officer battlefield order — relay to peers (role check: officer only)
      if (client.role !== "officer") return;
      broadcast(room, msg, null);
      return;
    }

    // Client -> host inputs / events
    if (msg.t === "input" || msg.t === "fire" || msg.t === "reload" || msg.t === "bandage" || msg.t === "chat") {
      // Send to host (and optionally others for FX)
      room.clients.forEach((c) => {
        if (c.id === client.id) return;
        // Prefer host for sim; others may listen for FX if needed
        if (c.id === room.hostId || msg.t === "fire" || msg.t === "chat") {
          send(c.ws, msg);
        }
      });
      return;
    }

    // Generic relay (pose, line draw preview, etc.)
    if (msg.t === "pose" || msg.t === "line" || msg.t === "ping" || msg.t === "pong") {
      broadcast(room, msg, client.id);
      return;
    }
  });

  ws.on("close", () => {
    if (!client.room) return;
    const room = rooms.get(client.room);
    if (!room) return;
    room.clients.delete(client.id);
    broadcast(room, {
      t: "peer_leave",
      id: client.id,
      roster: roster(room)
    });
    if (client.id === room.hostId) {
      // Host left — close room
      room.clients.forEach((c) => {
        send(c.ws, { t: "error", error: "Host disconnected — room closed" });
        try { c.ws.close(); } catch (e) {}
      });
      rooms.delete(room.code);
    } else if (room.clients.size === 0) {
      rooms.delete(room.code);
    }
  });
});

server.listen(PORT, "0.0.0.0", () => {
  const lans = lanIPs();
  console.log("War of the States MP server");
  console.log("  Authority: HOST browser (relay only here)");
  console.log("  Local:  http://127.0.0.1:" + PORT);
  lans.forEach((ip) => console.log("  LAN:    http://" + ip + ":" + PORT));
  console.log("  Static: " + ROOT);
});
