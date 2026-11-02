# Unreal Engine 5 Roadmap — War of the States

Practical path for a **solo beginner** building a War of Rights–style Civil War FPS in UE5. Times assume evenings/weekends (~10–15 hrs/week). Adjust if you go full-time.

---

## 1. Template Choice

**Start with:** First Person template (C++ or Blueprint — see below).

Why not Third Person or Lyra?
- You want musket ADS, first-person arms, and authentic sight picture from day one.
- Lyra is powerful but heavy for a beginner; adopt pieces later (GAS, CommonUI) once the musket loop works.

**Project settings early**
- Enable **Online Subsystem Steam** (or Null for LAN tests)
- Target **UE 5.4+** (or current LTS you install)
- Use **Nanite** for environment meshes; keep characters non-Nanite at first for animation simplicity
- **Lumen** OK for small maps; bake lightmaps if you need 64+ player performance later

---

## 2. Blueprint vs C++

| Phase | Recommendation |
|-------|----------------|
| Weeks 1–8 (prototype) | **Blueprint-first** for movement, musket, AI, UI |
| When you need replication edge cases / perf | Add **C++** for `AMusketWeapon`, `ACompanyOfficer`, projectile/hitscan helpers |
| Long-term | Hybrid: C++ gameplay framework + Blueprint designers for tuning |

**Rule of thumb:** If you’re learning UE and Civil War design at once, stay Blueprint until the vertical slice is fun. Convert hot paths later.

---

## 3. Musket System (Priority #1)

Implement as a **Weapon Actor** attached to the camera/mesh.

### Components
1. **State machine:** Idle → Aiming → Settling → Ready → Firing → Reloading → (interrupt)
2. **Aim settle:** Curve on spread (e.g. 8° → 0.5° over 2 s while RMB held and mostly still)
3. **Fire:** Line trace (hitscan) from camera; apply spread; spawn FX/smoke; play sound; empty chamber
4. **Reload:** Timed montage (~15 s) with optional step notifies (powder, ball, ram, cap); progress UI
5. **Bayonet (later):** Separate melee trace

### Tuning knobs (expose as UPROPERTY)
- SettleDuration, MinSpread, MaxSpread
- ReloadDuration, InterruptPolicy
- MaxRange, Damage, HeadshotMultiplier
- SmokeLifetime / visibility radius

### Animation
- Aim offset / FABRIK for rifle present
- Reload montage with root motion **off** (player can shuffle slowly or locked — pick one for authenticity)

---

## 4. Animation Plan

**MVP**
- Marketplace or Mixamo: walk/run/idle, rifle aim, fire recoil, death
- One reload montage (can be blocked-in with poses)

**Next**
- Kneeling fire, prone (optional), hit reactions, officer point/shout gestures
- Formation “dress” idle variants

**Tips**
- Use **Control Rig** or simple Aim Offset for looking around while in line
- Keep FPS arms as a separate mesh parented to camera; full body for third-person / other players

---

## 5. Multiplayer Replication

### What to replicate
| Concept | Approach |
|---------|----------|
| Movement | Character Movement Component (built-in) |
| Aim pitch/yaw | Replicated view for other clients (compact) |
| Fire event | Server RPC → multicast FX + server-authoritative hit |
| Reload progress | Server owns timer; clients play montage + UI |
| Orders (volley) | Server RPC from officer → multicast order enum to company |
| Morale | Server-only sim; replicate company morale float |

### Rules
- **Never** trust client for hits — server line trace (or validate client shot with timestamp / rewind later)
- Use **NetMulticast** for cosmetic smoke/sound
- Company membership as a replicated `CompanyId` on the pawn

### Listen vs dedicated
- Prototype: listen server (host plays)
- Before public tests: **dedicated server** build (see next section)

---

## 6. Dedicated Server

1. Package **Linux** (cheap VPS) or Windows dedicated target
2. Command-line: `WarOfTheStatesServer -log -port=7777`
3. Use **Steam sockets** or Epic OSS for travel
4. Map travel with `ServerTravel`
5. Add simple admin cheats: kick, end match, force objective

Budget VPS: 4 vCPU / 8 GB for 32 players as a starting guess; profile before 64+.

---

## 7. Recommended Marketplace / Free Assets (ideas)

Search Fab / Marketplace for:
- **Military / historical FPS** rifle packs (repurpose as muskets if Civil War packs are scarce)
- **Modular barracks / farm / fence** kits for Antietam fields
- **Landscape** grass / corn / dirt materials
- **Military UI** (minimal crosshair, compass)
- **Sound:** musket cracks, cannon, shouts (or CC0 packs + your own VO)

**Free / official**
- Epic’s FPS template content
- Quixel Megascans fences, rocks, trees (Nanite)

**Avoid** buying huge city packs — your maps are rural battlefields.

Legal note: do **not** copy War of Rights assets/audio; use originals or licensed packs.

---

## 8. Milestones & Time Estimates (Solo Beginner)

| # | Milestone | Deliverable | Est. time |
|---|-----------|-------------|-----------|
| 0 | Install & hello | FPS template runs; git repo | 1–3 days |
| 1 | Musket vertical | Aim settle, fire, 15 s reload, damage dummy | **2–4 weeks** |
| 2 | Graybox map | Fence, trees, two spawns, simple objective volume | 1–2 weeks |
| 3 | AI company | Line formation, face enemy, volley on timer / officer pawn | **3–5 weeks** |
| 4 | Morale | Casualty → rout; rally radius | 1–2 weeks |
| 5 | Listen MP | 2–8 players, replicated shots & death | **3–6 weeks** |
| 6 | UI / polish | Orders text, reload bar, win/lose, basic HUD | 1–2 weeks |
| 7 | Dedicated + Steam | Server build, Steam page private | 2–4 weeks |
| 8 | Closed playtest | 16–32 friends / regiment mates | ongoing |

**Rough total to “fun private line battle”:** **4–8 months** part-time.

Parallel tracks once Milestone 1 works: art graybox, audio, and regiment Discord tools (out of engine).

---

## 9. Suggested Week-1 Checklist

- [ ] Create project from First Person template
- [ ] Replace default gun fire with long reload + settle spread
- [ ] Add a progress bar widget bound to reload percent
- [ ] Place a target dummy that prints damage
- [ ] Commit to Git (or Perforce) every day you touch it

---

## 10. Learning Resources

- Official UE5 FPS / multiplayer docs
- Stephen Ulibarri / other UE multiplayer courses (replication fundamentals)
- Community musket/milsim Discord design threads (design only — don’t lift code/assets)
- Your own War of Rights notes: what feels good vs frustrating

---

## 11. Scope Guardrails

Say **no** until MVP ships:
- Cavalry
- Full Gettysburg
- Vehicle limbers
- Skill trees / pay cosmetics
- Mobile

Ship a **16-player cornfield skirmish** first. Expand like War of Rights did: community + events + more maps.

---

*Roadmap v0.1 — pair with `design_doc.md` and the Godot / browser prototypes for design validation before heavy UE investment.*
