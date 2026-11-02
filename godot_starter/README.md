# War of the States — Godot 4 Starter

Minimal Godot **4.2+** project scaffolding for a Civil War milsim FPS (War of Rights–style muskets and line formations).

## Requirements

- [Godot 4.2 or newer](https://godotengine.org/download) (Standard build is fine)
- No extra addons required for this starter

## Open & Run

1. Install Godot 4.
2. Launch Godot → **Import** → select `project.godot` in this folder.
3. Open `scenes/main.tscn` (set as main scene in Project Settings if needed).
4. Press **F5** (or Play).

> Note: The main scene is a lightweight stub that instances the scripts’ concepts. Expand meshes, animations, and AI behavior as you learn. The browser prototype in `../prototype/` shows the intended combat feel immediately.

## Scripts

| File | Role |
|------|------|
| `scripts/player.gd` | First-person controller (WASD, mouse look, gravity) |
| `scripts/musket.gd` | Fire, aim-settle spread, hitscan, ~15 s reload |
| `scripts/soldier_ai.gd` | Basic AI soldier: idle in line, face enemy, fire/reload |
| `scripts/line_formation.gd` | Places soldiers in a 2-rank company line |

## Suggested Input (already mapped in `project.godot`)

- **WASD** — move  
- **Mouse** — look  
- **RMB** — aim  
- **LMB** — fire  
- **R** — reload  

## Next Steps

1. Build a graybox field (CSGBox floor + fences).
2. Attach `musket.gd` to a weapon Node3D under the camera.
3. Spawn two `line_formation` nodes (Union / CSA) facing each other.
4. Add a simple morale autoload when you are ready.

Pair with `../design_doc.md` and `../ue5_roadmap.md` for the long-term plan. If you later move to Unreal, keep this Godot build as a design sandbox.
