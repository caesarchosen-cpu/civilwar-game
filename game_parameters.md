# War of the States — Game Parameters (from code)

Source of truth: `prototype/index.html`, `design_doc.md`. Generated to match the running build.

## Modes
| Mode | Role | Notes |
|------|------|-------|
| Solo Officer | Officer only | Single-player always starts as the officer (no private choice) |
| Gettysburg Day One | Officer | Continuous field, Points 1→2→3 |
| Host as Officer | Officer (net host) | Creates room; authoritative sim in browser |
| Join | Union Private | Multiplayer joiners only |

## Ranks / roles on the field
- **Officer** (player in solo / host): revolver, company orders 1–8, draw formation line (F / MMB)
- **Private** (MP joiners / AI rankers): Springfield rifle-musket, 9-step reload, bandage
- **Color bearer** (1 per regiment): carries national + regimental (Union) or ANV battle flag (CSA); does **not** play music; does not fire; if downed, nearest combatant takes the colors
- **Drummer** (1 per regiment): behind the line; WebAudio drum; playing animation; does not fire
- **Fifer** (1 per regiment): behind the line; WebAudio fife; playing animation; does not fire

## Controls (desktop)
| Input | Action |
|-------|--------|
| WASD | Move |
| Shift | Sprint (stamina) |
| C | Crouch toggle |
| Z | Prone |
| Space | Jump / vault |
| G | Rejoin line |
| R | Reload (private) |
| B | Bandage |
| RMB | Aim / settle sights |
| LMB | Fire |
| F / MMB | Draw formation line (officer); double-tap F flips facing |
| 1 | Make ready |
| 2 | Commence firing (weapons free — independent fire) |
| 3 | Cease firing |
| 4 | Load |
| 5 | Advance toggle |
| 6 | Halt |
| 7 | Charge |
| 8 | Fall back |

## Controls (touch / phone)
Shown when `(pointer: coarse)` or small touch screen. Left virtual joystick = move; right drag = look; buttons for FIRE, AIM, RELOAD, SPRINT, CROUCH, BANDAGE; officer order strip (1–8 equivalents); DRAW LINE / FLIP FACE. Pointer lock fails soft-fallback to touch look. Opening menu buttons are full-width tappable.

## Combat — independent fire (no volleys)
Every soldier fires on his own clock from reload finish, personal aim settle, target range/visibility, morale, suppression, and random jitter. There is **no** massed volley sync and **no** volley toggle. Officer **Commence / Cease** only authorizes or holds Union fire (`state.weaponsFree`). CSA remains authorized.

## Weapon sway
Continuous smooth figure-eight / harmonic drift per soldier (`updateWeaponSway`). Amplitude grows with low stamina, post-sprint, bleeding/wounds, suppression, low morale; shrinks when prone/crouched, aiming settle, standing still, veterans. AI: applied to shot direction in `aiShoot`. Player: visible FP gun/sight drift in `updateViewmodel`.

## Morale
Bar states: **Steady** / **Wavering** / **Broken** / **Rallying** (`moraleStateLabel`).

**Retreat restore (once per retreat to next point or rally):**  
`new = current + 0.25 * (100 - current)` via `restoreMoraleOnRetreat`. HUD shows `+X% morale`. **No soldiers respawn.**

**Rallying:** survivors form on colors; drummer beats assembly; morale climbs toward ~48% cap (faster if officer near, no enemies close). Casualties stay dead.

## Gettysburg Day One — three Points (continuous field)
| Point | Player regiment | Brigade | Foe | Decision rule |
|-------|-----------------|---------|-----|---------------|
| 1 McPherson / Herbst | 24th Michigan | Iron Brigade (Meredith) | Archer (woods); Davis at cut | Form on ground (F line) |
| 2 Seminary fighting withdrawal | 24th Michigan remnant | Iron Brigade remnant | Pettigrew / Pender | Bounds: fire independently, peel to town |
| 3 Town → Cemetery Hill | 154th New York | Coster | Early / Rodes pursuit | Brickyard rear-guard / cut-offs / rally on hill |

Officer is never called “host” in scenario text. No checkbox missions — commitment is where the company is led/formed.

## Day Two Points (design; southern field)
1 Devil’s Den / Houck’s Ridge (124th NY / Ward vs Hood elements) · 2 Wheatfield · 3 Little Round Top (20th Maine / Vincent vs 15th & 47th Alabama / Oates).

## Core numbers (code)
| Param | Value |
|-------|-------|
| Map half-extent | 200 yd (`MAP_HALF`) |
| Shout / order range | 60 yd (`SHOUT_RANGE`) |
| Starting ammo (private) | 40 |
| Officer revolver | 6 |
| Reload steps | 9 (`RELOAD_STEPS`, ~15.6 s total) |
| Bandage | 4.0 s |
| Point 1 hold limit | 420 s, 3 waves |
| Brickyard rear-guard bonus | 90 s hold → +10 cohesion/morale |
| Cemetery win | ≥60% effectives on hill |
| World unit | 1 ≈ 1 yard |

## Stack
Three.js r160 (vendored), single `index.html`, Node `ws` relay + static (`server/`, port 8787). Host-authoritative multiplayer.


## Background battle music
- File: `prototype/audio/battle_cry_of_freedom_1914.mp3` (LOC National Jukebox, Victor 1914; public domain pre-1923). Credits: `prototype/audio/CREDITS.md`.
- HTMLAudio element (`audio.ensureBattle`), looped at ~0.28 volume.
- **Trigger:** first click/tap/key unlocks autoplay; music **starts when a Gettysburg Point begins** (`setGbPoint` → `audio.startBattleMusic`).
- **Toggle:** `M` key or touch **MUSIC** button (`audio.toggleBattleMusic`).
- **Duck:** gunfire calls `audio.duckBattle`; `tickBattleDuck` restores volume.
- Supplements procedural fife/drum; does not replace them.
