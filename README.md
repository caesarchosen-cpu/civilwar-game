# War of the States — browser Civil War prototype + multiplayer

**Pure browser game.** Anyone opens a link and plays — no install, no Steam client.  
Built with **Three.js** (vendored locally) and **WebSockets**.

## Authority model

**The officer host’s browser is authoritative.** That tab runs AI, hits, health, morale, and formation.  
The Node process is only a **thin relay + static file host**:

- serves `prototype/` (HTML/JS + `vendor/three.min.js`)
- creates/joins rooms
- relays snapshots, inputs, fire/hit/cmd messages

Deploy the Node relay once to any free host; every player just uses a browser.

Roles:

- **Host = Officer (Union)** — creates a room, issues company orders  
- **Joiners = Privates (Union)** — spawn under that officer (60‑yard earshot on HUD)  
- Second officer join is **rejected**  
- Empty slots filled by **AI**; Confederates are AI (future: human CSA)

## Quick start (local)

```bash
cd server
npm install
npm start
```

Open `http://127.0.0.1:8787` (or the LAN IP printed in the console).

1. **Host as Officer** — note the room code and **Share link** (`/?room=ABCDE`)  
2. Send the share link to a friend — they land as Union Private automatically  
3. Or **Join** manually with server address + room code  

Default port: `8787` (`PORT=9000 npm start` to change).

Solo Private / Solo Officer still work offline (same page, no room needed).

## Share links

After hosting, the start panel shows:

`https://YOUR_HOST/?room=ABCDE`

Opening that URL auto-joins the Union side as a Private. You can also use `?code=ABCDE`.

## Deploy (free hosts)

Players still only need the URL. You run the relay once:

### Render

- New **Web Service**, root directory `server`, build `npm install`, start `npm start`  
- Or use the included `render.yaml` Blueprint  
- Ensure the service can read `../prototype` (same repo checkout — Render’s `rootDir: server` keeps the parent tree)

### Railway / Glitch

- Set start command to `cd server && npm start` (or root Dockerfile)  
- Expose the assigned `PORT` (the server already reads `process.env.PORT`)

### Fly.io / Docker

```bash
# from repo root (civilwar_game/)
docker build -t wots .
docker run --rm -p 8787:8787 wots
# or: fly launch --dockerfile Dockerfile
```

See `Dockerfile` and `fly.toml`.

### Internet without a cloud host

On the machine running `npm start`:

1. **Port forward** TCP `8787`, share `http://PUBLIC_IP:8787/?room=CODE`, or  
2. **Tunnel**: `npx localtunnel --port 8787` or `cloudflared tunnel --url http://localhost:8787`

Share the resulting HTTPS origin; joiners open `https://YOUR_TUNNEL/?room=CODE` (WebSocket upgrades on the same host). Temporary quick tunnels are for demos only — prefer Render/Railway/Fly for anything lasting.

## Controls (unchanged)

- WASD · Shift sprint · C crouch · Z prone · Space jump · G rejoin line  
- Private: RMB aim · LMB fire · R reload · B bandage  
- Officer: 1–8 orders (≤60 yd shout) · F/MMB draw line · LMB revolver  

## Layout

```
civilwar_game/
  prototype/          # browser client (Three.js game)
    index.html
    vendor/three.min.js
  server/             # static + ws relay
    index.js
    package.json
  Dockerfile
  render.yaml
  fly.toml
  README.md
```

## Verify

```bash
cd server && npm run check
# Puppeteer two-client smoke (optional): node /tmp/mp_test.js while server runs
```
