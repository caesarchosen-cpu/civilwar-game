# War of the States — Game Design Document

**Working title:** War of the States  
**Genre:** First-person American Civil War milsim / multiplayer FPS  
**Inspiration:** War of Rights (unit-based line combat, period authenticity, regiment social layer)  
**Audience:** Civil War enthusiasts, milsim players, War of Rights veterans who want a modern, approachable alternative  
**Target platforms (long-term):** PC (Windows first), Steam  

---

## 1. Concept

You play as a soldier in a Union or Confederate regiment. Combat is not twitch deathmatch — it is about staying in line, obeying officer commands, timing volleys, and holding morale under fire. Matches recreate historical or fictional engagements on Antietam-scale fields. Between battles, players join persistent regiments, drill, and schedule events (mirroring War of Rights community life).

**Fantasy promise:** Feel what it meant to stand in a firing line under smoke and artillery, then celebrate (or mourn) with your company afterward.

---

## 2. Core Loop

1. **Muster** — Join a regiment / pick company and rank (Private → Corporal → Sergeant → Officer).
2. **Deploy** — Spawn into a map objective (hold the fence line, take the sunken road, capture the church).
3. **Form & Fight** — Form ranks; fire / reload muskets on command or individually; advance, kneel, or fall back as NCOs call.
4. **Morale Swing** — Take casualties → suppression → possible rout; rally if officers hold the line.
5. **Objective Resolve** — Capture / hold points until ticket bleed or timer ends.
6. **After-Action** — Scoreboard with kills, accuracy, volleys obeyed, and regiment XP.

Casual / event nights can skip matchmaking and run custom battles hosted by regiment officers.

---

## 3. Musket & Reload Mechanics

Primary weapons: Springfield / Enfield rifled muskets (MVP), later carbines and smoothbores.

| Phase | Duration (MVP target) | Player feedback |
|-------|------------------------|-----------------|
| Aim settle | ~1.5–2.5 s after raising weapon | Crosshair tightens; sway decreases |
| Fire | Instant | Muzzle flash, smoke puff, loud crack; hitscan + cone of fire |
| Reload | ~12–18 s (skill / stance modifiers) | Progress steps: powder → ball → ram → cap |
| Bayonet | Melee only when empty or toggled | Short lunge; high risk |

**Design rules**
- No hip-fire accuracy; must ADS / present arms to hit beyond a few meters.
- Spread is large until aim settles (punishes snap-firing).
- Smoke from your own volley briefly reduces local visibility.
- Reloading is interruptible by movement / stagger / death; partial progress can be kept (tunable).

---

## 4. Line Formations & Officer / NCO Roles

### Formations
- **Company line** (default): 2-rank firing line facing the enemy.
- **Column** for road movement / reserve.
- **Skirmish screen** (later): looser spacing, more individual fire.

Soft magnets / ghost markers help players stay dressed on the line without hard locks (authentic feel, modern usability).

### Roles
| Rank | Powers |
|------|--------|
| Private | Fire when ordered or “fire at will”; stay dressed |
| Corporal / Sergeant | Local “dress the line,” kneel/stand, limited rally |
| Officer (Lt / Capt) | Company volley commands, advance / retreat, objective markers |
| Higher officers (later) | Battalion / brigade markers, artillery attachment |

**Volley system:** Officer holds “Make ready → Aim → Fire.” AI and disciplined players sync; “fire at will” unlocks freestyle shooting. Friendly fire is on in authentic modes.

---

## 5. Morale & Suppression

Each company (or AI squad) has a **morale meter** (0–100).

**Drain causes**
- Casualties (especially officers)
- Incoming artillery / flanking fire
- Being fired on while reloading
- Seeing nearby friendlies rout

**Recover causes**
- Officer nearby + rally shout
- Winning a firefight (enemy falling back)
- Holding cover / behind a fence / stone wall

**Break thresholds**
- **Shaken** (< 60): accuracy and reload penalties
- **Wavering** (< 40): some AI peel back; players get UI panic cues
- **Rout** (< 20): AI flees; players lose spawn on that company until rallied

Suppression is separate short-term: bullets near the player increase sway and slow aim settle.

---

## 6. Artillery

MVP: static or slowly relocatable guns (Napoleon 12-lb, 3-inch Ordnance later).

- Crew of 2–4 players (or AI filler)
- Load → aim → fire cycle (~20–40 s)
- Direct fire + simple spherical case / canister at short range
- Counter-battery and infantry targets both valid
- Friendly fire risk is high — officers must clear lanes

Later: limber/unlimber, horse teams, mortar for sieges.

---

## 7. Maps (Antietam-style and beyond)

**MVP map: “Miller’s Cornfield” (Antietam-inspired)**
- Size: ~400–800 m playable axis
- Features: corn / wheat fields (concealment), wood fences, dirt lanes, a woodlot, slight ridges
- Objectives: Hold the fence, clear the corn, take the woodlot edge
- Atmosphere: morning fog option, bird calls, distant guns

**Later maps:** Bloody Lane, Burnside Bridge, Gettysburg ridge / peach orchard, fictional drill fields for training.

Maps prioritize **sightlines for volleys** and **cover that breaks lines** (fences, walls, ditches) over arena clutter.

---

## 8. Multiplayer & Regiment Features

### Match modes (MVP)
- **Skirmish** (16–64 players): two companies + light artillery
- **Line Battle** (64–200): multi-company, officer slots reserved

### Regiment / social layer
- Persistent regiment with ranks, roster, Discord/Steam group link
- Event calendar (drill night, Saturday battle)
- Custom server / private battle browser
- Cosmetics: company letters, hat brass, limited uniform variants (not pay-to-win)

Auth / progression: Steam + optional regiment officer tools (kick, promote, event host).

---

## 9. Art Direction

- **Tone:** Gritty but readable; avoid grimdark mud soup and cartoon gloss.
- **Palette:** Desaturated greens/browns, blue & gray uniforms with clear silhouette contrast.
- **Scale:** Slightly heroic proportions so formations read at distance; faces not hyperreal (cost).
- **FX:** Heavy powder smoke, muzzle flashes, leaf litter, heat haze on summer maps.
- **Audio:** Distinct musket vs rifle crack, officer shouts, fife/drum at spawn, sparse music.
- **UI:** Minimal HUD — ammo state, company order text, compass; diegetic where possible.

Reference: War of Rights authenticity + Squad/Hell Let Loose readability.

---

## 10. Feature Scope

### MVP (playable vertical slice)
- [ ] FPS movement + ADS musket with aim-settle & long reload
- [ ] One Antietam-inspired map with fence / trees / two spawn areas
- [ ] AI or player companies in line; officer volley commands
- [ ] Basic morale / rout for AI
- [ ] Hitscan ballistics with spread; no bullet drop required yet
- [ ] 16–32 player listen or dedicated server prototype
- [ ] Union & CSA private kits only
- [ ] Win/lose on tickets or timed objective

### Post-MVP
- Artillery crew gameplay
- Full regiment tools & events
- More maps & historical OOBs
- Bayonet charges, cavalry (careful — balance nightmare)
- Ranked / authentic rulesets
- Modding hooks (uniforms, maps)

### Later / stretch
- Dynamic campaigns linking battles
- Officer FOW / courier orders
- VR experimental mode (optional)

---

## 11. Success Metrics (MVP playtest)

- Average engagement length 15–25 minutes
- Players report “felt like a line battle” ≥ 70% in survey
- Reload / aim timing feels fair (not too punishing vs arcade)
- Regiment officers can run a private event without developer help

---

## 12. Risks

| Risk | Mitigation |
|------|------------|
| Too slow / boring vs modern FPS | Strong audio, officer drama, short match timers, training mode |
| Too hardcore / inaccessible | Soft formation assists, clear order UI, casual ruleset toggle |
| Netcode + 100+ players | Start 32; interest management; dedicated servers early |
| Scope creep (cavalry, navy…) | Lock MVP list; park ideas in backlog |

---

## Campaign: Gettysburg

### Design rule — battlefield decisions & continuous ground

Every **officer decision** is made **in-world on the battlefield** by **where he leads and forms the company** — not by a menu checkbox or choice prompt between missions. A briefing card may describe the situation (courier report), but **it is not the decision**.

Commitment is detected from **trigger zones** plus the **drawn formation line** (and company position):

| Where the officer forms / leads | Commitment |
|--------------------------------|------------|
| **McPherson’s Ridge** | Hold the advanced high ground; delay waves from west/north |
| **Seminary Ridge** | Hold the fallback line on the seminary ground |
| **Cemetery Hill** (march through town) | Fighting withdrawal; company physically retreats under fire to the hill |

Every choice has a **visible, played consequence on the same continuous field**. Falling back means the company walks the streets under pursuit — no cutaway to a new map.

- **Day One** is **one continuous field**: McPherson’s / Seminary Ridge → Chambersburg Pike, railroad cut, Lutheran Seminary → town grid → Cemetery Hill gatehouse and Culp’s Hill.
- **Day Two** is a separate continuous southern field whose connected areas include **Little Round Top**, the **Wheatfield**, Devil’s Den / Houck’s Ridge, and related ground.

### Day One — July 1, 1863 (playable)

The Union company deploys on the approaches west and north of Gettysburg. A courier reins up and briefs the officer that Confederate columns are reported coming down the **Chambersburg Pike** and the **Carlisle Road**. The briefing card is informational only — dismiss it and return to the field. **Commitment is where the officer leads and forms the company** on the continuous map:

| Where formed / led | Opening commitment |
|--------------------|--------------------|
| **McPherson’s Ridge** (fence line, barn, Herbst Woods edge) | Hold the advanced high ground; delay waves from the west and north |
| **Seminary Ridge** (seminary / cupola ground) | Hold the brigade fallback line east of McPherson’s |
| **Through town → Cemetery Hill** (gatehouse / hill crest) | Fighting withdrawal; company physically retreats under fire |

Landmarks on the continuous field: Chambersburg Pike, unfinished railroad cut, McPherson barn, Herbst Woods, Lutheran Seminary with cupola, town streets (incl. brickyard block), Cemetery Hill gatehouse, Culp’s Hill timber.

#### Carry-forward from the opening choice

All three branches stay on the **same Day One field**. What changes is ammunition, casualties, cohesion, and where the company sits when the next phase starts.

| Opening commitment | Ammo | Casualties / cohesion | Arrival into later phases |
|--------------------|------|------------------------|---------------------------|
| **Hold McPherson’s** | Heavy expenditure in the ridge fight; company may enter town / Cemetery low on cartridges unless resupply wagons are reached | Highest early losses if waves are held too long; cohesion high if the line dresses and volleys on command | If forced off the ridge, arrives in town exhausted but with a formed rear guard; if relief arrives, may march to Cemetery with better numbers |
| **Hold Seminary** | Moderate burn; shorter firefight window before XI Corps pressure | Fewer early dead than McPherson hold, but risk of being flanked when XI Corps buckles north of town | Falls back through town from a shorter march; arrives on Cemetery with more ammo than a McPherson last-stand |
| **Immediate withdrawal to Cemetery** | Ammo conserved for the hill | Lowest early combat losses, but cohesion can fray in the streets (stragglers, cut-off squads); moral hit for “abandoning” the advanced line | Arrives on Cemetery earliest with fullest magazines; must dig in while afternoon waves hit the approaches |

Numbers (prototype targets): starting ~20 effectives, 40–60 rounds/man equivalent pooled; cohesion 0–100. Opening choice applies modifiers before phase 2.

---

### Day One — fill-out (phases after the opening choice)

Every phase below is played **on the same continuous field**. Decision points are **where the officer leads and draws the formation line**, never a menu. Enemy waves and win/lose are local to the phase but cascade.

#### Phase A — Iron Brigade stand: Herbst Woods & McPherson’s Ridge

**Setup.** Morning. Company is the left or center of an Iron Brigade–style line along the fence facing west. McPherson barn to the right rear; Herbst Woods fringe to the left; Chambersburg Pike visible to the north-west. Confederate brigades (Archer / Davis wave analogues) advance from the west through the open ground and timber.

**Decision points (position).**
- Form **on the fence crest of McPherson’s** → stand and volley; unlocks Phase A hold objectives.
- Fall back and form **on Seminary Ridge** mid-fight → concede McPherson’s early; jump toward Phase C setup with Seminary modifiers.
- Abandon the ridge and **lead south-east into the town corridor** → opens Phase D early (withdrawal under pressure).

**Visible consequences.** Smoke along the fence; CSA flags closing from the west; if the line holds, enemy piles up on the slope; if the officer pulls to Seminary, Union markers relocate east and CSA occupies the barn/fence; if he marches for town, company columns into the street grid with pursuit spawning behind.

**Enemy waves.** Wave 1: skirmishers then a company-sized line from the west (≈90 s). Wave 2: second line plus pressure from the pike / woods (≈3 min). Optional Wave 3 if still on McPherson’s after 6 min (heavier assault).

**Objectives.** Hold the fence / barn sector until relief timer (~8–10 min) **or** inflict enough casualties that the local CSA wave breaks; keep ≥50% of the company standing and cohesion ≥40.

**Win.** Relief arrives (scripted allied presence east) while the company still holds the crest; or local CSA morale breaks. **Lose.** Company routed (cohesion <20) or officer down with no NCO rally; or crest abandoned with no formation on Seminary / Cemetery (company dissolves into open flight).

#### Phase B — Railroad cut

**Setup.** Unfinished railroad cut north of the barn / pike. Can open from a McPherson hold (company refuses right or is ordered into the cut) or as a side action when CSA tries to turn the northern flank.

**Decision points (position).**
- Lead a detachment **into / along the cut** to enfilade CSA crossing the pike → cut fight.
- Keep the main line **on the ridge crest** and only picket the cut → cut may be lost; flank fire increases.
- Withdraw past the cut toward Seminary without contesting it → CSA gains the cut as a covered approach.

**Visible consequences.** Troops in the cut fight at close range; prisoners / disordered CSA possible on success; on failure, gray coats pour from the cut toward the seminary ground.

**Enemy waves.** One dense close-range wave attempting to cross or clear the cut (~2–3 min), plus skirmishers on the lips.

**Objectives.** Clear or hold the cut long enough for the ridge line to refuse; extract the detachment with ≥ half its men.

**Win.** Cut held or cleared; detachment reforms on the ridge or seminary. **Lose.** Detachment wiped or trapped in the cut; main line flanked (forces Phase C/D under bad modifiers).

#### Phase C — XI Corps collapse: Barlow’s / Blocher’s Knoll pressure

**Setup.** Midday. North of town, XI Corps analogues buckle on Barlow’s Knoll / Blocher’s Knoll. The player company — still on McPherson’s or Seminary — sees the **right/northern flank cave**: dust, routing blue figures, and CSA flags swinging south toward the town and the company’s open flank.

**Decision points (position).**
- **Refuse the right** — draw a new line facing north/north-east on Seminary or the town edge → buy time.
- **Hold facing west** and ignore the knoll collapse → risk encirclement; cohesion drain accelerates.
- **Begin the town withdrawal** immediately — lead toward Carlisle / Baltimore Street corridors → Phase D.

**Visible consequences.** Routing friendlies cross the map; CSA pressure rotates; if refused properly, a hinge forms near the seminary; if ignored, CSA appears in the company’s rear and ammo/cohesion crater.

**Enemy waves.** Flank wave from the north (≈2 waves, 4–6 min) overlapping any remaining western pressure.

**Objectives.** Keep a continuous facing toward the new threat; do not let the company be taken in flank/rear; preserve a path into town.

**Win.** Company refuses or withdraws in order with cohesion ≥35. **Lose.** Flanked rout; officer cut off north of town (bad arrival modifiers into Phase D/E).

#### Phase D — Afternoon collapse & retreat through town

**Setup.** The advanced lines give way. Company must move through the town grid toward Cemetery Hill under pursuit. Street fighting, clogged intersections, and a **Kuhn’s brickyard–style rear-guard** block where a detachment can delay while the column slips south.

**Decision points (position).**
- Form a **rear-guard line at the brickyard / northern blocks** while the bulk marches south → trades men for column speed.
- Keep the **whole company in one body** moving through the main street → faster, but pursuit stays stuck to the rear.
- Attempt to **cut east too early** (wrong alleys) → squads get **cut off** in side streets (straggler state, delayed Cemetery arrival).

**Visible consequences.** Firing in streets; civilians/props as soft cover; brickyard stand shows a thin blue line vs gray; cut-off men appear as separated markers who may rejoin late or become casualties.

**Enemy waves.** Pursuit wave 1 on the heels of the column; wave 2 entering town from the north/west; optional cavalry/skirmisher harass on the flanks (prototype: fast AI).

**Objectives.** Get ≥60% of living effectives through town to the Cemetery approaches; optional: hold brickyard ≥90 s for a cohesion bonus to the column.

**Win.** Column reaches the southern edge / gatehouse approaches in order. **Lose.** Company shattered in town (<40% reach the hill); or officer captured/killed in a cut-off alley with no succession.

#### Phase E — Rally on Cemetery Hill & dig in on Culp’s at dusk

**Setup.** Late afternoon into dusk. Hancock / Howard narrative: officers rally fragments on **Cemetery Hill** by the gatehouse. Company forms on the hill; as light falls, a detachment or the whole company can be led onto **Culp’s Hill** timber to dig in against eastern approaches.

**Decision points (position).**
- Form **on Cemetery Hill crest / gatehouse** → primary rally; artillery park narrative; face west/north.
- Lead **onto Culp’s Hill** and form in the timber → dig-in mini-phase; face east/south-east.
- Linger in the **town’s southern edge** too long → dusk assault catches the company off the crest.

**Visible consequences.** Blue flags mass on the hill; gatehouse silhouette; entrenchment props appear if Culp’s is occupied; CSA probes up the slopes; if the company stays in town, night assault is brutal.

**Enemy waves.** Probe waves up Cemetery Hill (1–2); if on Culp’s, a dusk timber assault; intensity scaled by Day One carry-forward (low ammo / low cohesion → harder).

**Objectives.** Form a dressed line on Cemetery and/or Culp’s; survive until dusk timer; cohesion ≥30; hold the assigned crest.

**Win.** Hill(s) held at dusk with a formed company — Day One complete; carry ammo/casualties/cohesion into Day Two unlock. **Lose.** Crest lost after dark; company routed off the hill (campaign setback; Day Two starts under-strength).

---

### Day Two — July 2, 1863 (connected southern field)

Day Two uses a **separate continuous southern battlefield** (one load): **Devil’s Den / Houck’s Ridge**, the **Wheatfield**, **Little Round Top**, with Peach Orchard / Emmitsburg Road and southern Cemetery Ridge as adjacent pressure (later fill). Officer decisions remain **where the company is led and formed**. Day One ending state (ammo, casualties, cohesion) seeds starting strength.

#### Mission 1 — Little Round Top (20th Maine–style left flank)

**Setup.** Mid-to-late afternoon. Company holds the extreme left on the rocky southern slope of Little Round Top. Timber and stone below; valley toward Devil’s Den visible. Oates’s Alabamians (and adjacent CSA) come **up the slope** in repeated assaults. Cartridges dwindle.

**Map features.** Rocky crest and reverse slope; wooded front slope; narrow shelf for a two-rank line; path down toward the saddle; distant Den boulders as orientation.

**Objectives.** Hold the left flank until the assault breaks or the regiment’s crisis resolves; do not let CSA crest the hill behind the main Union line.

**Decision points (position) & outcomes.**
- **Refuse the line** — draw formation bent back along the southern spur → shorter front, denser fire; may cede lower slope but keeps the crest.
- **Form for bayonet charge downhill** — draw the company line **downslope** toward the attackers (Chamberlain-style right-wheel / charge read) → spends remaining ammo state, commits to melee; on success shatters the local CSA wave and clears the front slope; on failure the company is scattered downslope and the crest is naked.
- Hold a straight line without refusing or charging while ammo hits empty → firefight collapses into a push that the company likely loses.

**Enemy waves.** 3–4 uphill assaults with short recovery gaps; final wave coincides with “last cartridges” scripted beat.

**Win.** Crest held and local CSA broken (charge success **or** refused line survives final wave). **Lose.** CSA crowns Little Round Top; company routed or annihilated on the slope.

#### Mission 2 — The Wheatfield (seesaw)

**Setup.** The company is fed into the Wheatfield fight — open stalks, Stony Hill on one flank, stone wall / tree line as a withdraw anchor toward the east. Control seesaws as brigades push and give way.

**Map features.** Standing wheat (concealment, poor dress); Stony Hill timber; stone wall fallback; lanes toward Rose woods / Den; smoke and overlapping friendlies.

**Objectives.** Contest the wheat long enough to blunt CSA penetration toward the Taneytown / Cemetery Ridge axis; preserve enough company to reform on the wall.

**Decision points (position) & outcomes.**
- **Commit into the wheat** — form advancing line into the stalks → can throw back a CSA push and seize temporary ground; high casualty / cohesion risk; if timed with a friendly wave, gains a “held wheat” state.
- **Withdraw to the stone wall** — lead and form on the wall → cedes the wheat, lowers losses, sets a defensive firefight; CSA gains the field but may stall on the wall.
- Hesitate in the middle ground (no clear form on wheat or wall) → enfilade from Stony Hill flankers; cohesion collapse.

**Stony Hill flank.** If the officer refuses or pickets toward Stony Hill while committed, flank fire drops; if ignored while in the wheat, a flank wave appears.

**Enemy waves.** Alternating Union-pressure / CSA-pressure beats (2–3 seesaw cycles); a flanking detachment from Stony Hill if exposed.

**Win.** Either: hold or re-take the wheat at the timer with cohesion ≥35, **or** conduct an ordered wall defense that stops CSA past the wall. **Lose.** Company broken in the open wheat; CSA streams past the wall toward the ridge.

#### Mission 3 (optional link) — Devil’s Den & Houck’s Ridge

**Setup.** Broken boulder field and ridge linking the valley to Little Round Top. Company may be tasked to delay CSA moving from Den toward the LRT saddle, or to cover a withdrawal from the Wheatfield toward the hill.

**Map features.** Triangular field edge, boulder piles, Plum Run low ground, Houck’s Ridge spine, sightlines up to LRT.

**Objectives.** Delay / screen; keep the LRT left from being taken in reverse; extract toward LRT or Cemetery Ridge when pressed.

**Decision points (position) & outcomes.**
- Form among the **Den boulders** → strong short-range defense, risk of isolation.
- Form on **Houck’s Ridge** spine → better withdraw path to LRT; weaker cover.
- Abandon Den early and **climb toward LRT** → feeds Mission 1 with more bodies but cedes the valley sooner.

**Enemy waves.** Hard CSA push through the boulders (1–2 waves); sharpshooter pressure from high rocks.

**Win.** Delay timer met and company reforms on LRT or ridge with ≥ half effectives. **Lose.** Company trapped in the Den and destroyed; or LRT left opened from below (fails linked Mission 1 setup).

---

### Day Two — design notes

| Area | Role on the continuous southern field |
|------|----------------------------------------|
| Little Round Top | Rocky left-flank height; refuse or charge by formation line on the slope |
| Devil’s Den / Houck’s Ridge | Broken ground linking valley to LRT |
| The Wheatfield | Open murder ground; commit or wall-withdraw by company movement |
| Peach Orchard / Emmitsburg Road | Artillery and crossroads pressure (later fill) |
| Cemetery Ridge (south) | Reform line continuous with Day One’s cemetery narrative |

Officer choices on Day Two follow the same rule: committed by where the company is led and formed on that continuous ground. No host / menu framing.

---

*Document version 0.4 — Gettysburg Day One phases filled; Day Two LRT / Wheatfield / Den missions; position-based commitments throughout.*
