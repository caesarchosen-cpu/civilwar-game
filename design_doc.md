# War of the States — Game Design Document

**Working title:** War of the States  
**Genre:** First-person American Civil War milsim / multiplayer FPS  
**Inspiration:** War of Rights (unit-based line combat, period authenticity, regiment social layer)  
**Audience:** Civil War enthusiasts, milsim players, War of Rights veterans who want a modern, approachable alternative  
**Target platforms (long-term):** PC (Windows first), Steam  

---

## 1. Concept

You play as a soldier in a Union or Confederate regiment. Combat is not twitch deathmatch — it is about staying in line, obeying officer commands, timing fire under orders, and holding morale under fire. Matches recreate historical or fictional engagements on Antietam-scale fields. Between battles, players join persistent regiments, drill, and schedule events (mirroring War of Rights community life).

**Fantasy promise:** Feel what it meant to stand in a firing line under smoke and artillery, then celebrate (or mourn) with your company afterward.

---

## 2. Core Loop

1. **Muster** — Join a regiment / pick company and rank (Private → Corporal → Sergeant → Officer).
2. **Deploy** — Spawn into a map objective (hold the fence line, take the sunken road, capture the church).
3. **Form & Fight** — Form ranks; fire / reload muskets on command or individually; advance, kneel, or fall back as NCOs call.
4. **Morale Swing** — Take casualties → suppression → possible rout; rally if officers hold the line.
5. **Objective Resolve** — Capture / hold points until ticket bleed or timer ends.
6. **After-Action** — Scoreboard with kills, accuracy, orders obeyed, and regiment XP.

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

Commitment is detected from **trigger zones** plus the **drawn formation line** (and company position). The officer is only ever referred to as **the officer** (never as host) in scenario text.

Every choice has a **visible, played consequence on the same continuous field**. Falling back means the company walks the ground under pursuit — no cutaway to a new map.

- **Day One** is **one continuous field** played as **three sequential Points** (on-screen marker: `Day 1 · Point N`).
- **Day Two** is a separate continuous southern field also played as **three sequential Points** (`Day 2 · Point N`).

---

### Day One — July 1, 1863 (three points, continuous field)

Landmarks: Chambersburg Pike, unfinished railroad cut, McPherson barn, Herbst Woods, Lutheran Seminary with cupola, town streets, **Kuhn’s brickyard**, Cemetery Hill gatehouse, Culp’s Hill timber.

A courier briefs the officer (informational only). **Where the officer first leads and forms** sets opening ammo / casualties / cohesion and which Point opens:

| Where formed / led | Opens |
|--------------------|-------|
| **McPherson’s Ridge** (fence, barn, Herbst Woods) | **Point 1** — stand on the advanced line |
| **Seminary Ridge** (seminary / cupola) | **Point 2** — Seminary fighting withdrawal (shorter Point 1 pressure already behind) |
| **Through town → Cemetery Hill** | **Point 3** — early fighting retreat through town (Points 1–2 skipped with “abandoned advanced line” cohesion hit) |

Carry-forward modifiers (prototype targets: ~20 effectives, cohesion 0–100):

| Opening | Ammo | Cohesion / losses | Later Points |
|---------|------|-------------------|--------------|
| Point 1 stand | Heavy burn | Highest early losses if held too long | Enters Point 2 exhausted but formed |
| Jump to Point 2 at Seminary | Moderate | Fewer ridge dead; flank risk | Shorter march into Point 3 |
| Immediate Point 3 withdraw | Conserved | Street straggler / cut-off risk; moral hit | Earliest on Cemetery, fullest magazines |

#### Day 1 · Point 1 — McPherson’s / Herbst Woods stand

**Setup.** Morning. Company on the Iron Brigade–style fence facing west. Barn right-rear; Herbst Woods left; pike NW. CSA waves from the west.

**Decisions (position).**
- Form on the **McPherson fence crest** → stand and fire independently.
- Lead / form on **Seminary Ridge** mid-fight → concede the barn/fence; advance to **Point 2**.
- Lead **south-east into the town corridor** → open **Point 3** early under pressure.

**Enemy.** Wave 1 (~90 s), Wave 2 (~3 min), optional Wave 3 if still on the crest after ~6 min.

**Objectives.** Hold until relief / local break **or** conduct an ordered hand-off into Point 2; keep ≥50% standing and cohesion ≥40.

**Win → Point 2.** Relief beat or ordered withdrawal east. **Lose.** Rout (cohesion <20), officer down with no rally, or crest abandoned with no formation on Seminary / Cemetery.

#### Day 1 · Point 2 — Seminary Ridge fighting withdrawal

**Setup.** The advanced line gives way or the officer has formed on the seminary. This is a **fighting withdrawal by bounds** on the continuous ground from McPherson / seminary approaches toward the town edge — **not** an aid-station interlude. The company must fall back under fire while men fire independently on the bound.

**Decisions (position).**
- Draw a **west-facing bound line** on seminary ground or the slope → men open fire independently on a west-facing bound, then the company peels another bound south-east.
- Keep the company in **march column without forming** → faster exit toward town, but cohesion drain and CSA closes faster.
- Linger facing west too long without falling back → seminary ground is enveloped; forced disordered entry into Point 3.

**Visible consequences.** Bounds: halt → fire → peel south-east; powder smoke on each bound; CSA flags pressing from the west; if the officer peels into town streets, **Point 3** begins on the same field.

**Enemy.** Continuous pressure from the west plus a flanking probe from the north as XI Corps narrative pressure arrives.

**Objectives.** Extract ≥70% of living effectives off the seminary approaches into the town corridor in order; deliver sustained independent fire on at least one bound before peeling into town.

**Win → Point 3.** Ordered entry into the town grid with cohesion ≥35. **Lose.** Company broken on the seminary slope; or cut off north of town.

#### Day 1 · Point 3 — Fighting retreat through town → Cemetery Hill

**Setup.** Afternoon collapse. Company moves through the town grid toward Cemetery Hill under pursuit. Street fighting, clogged intersections, and a **Kuhn’s brickyard rear-guard** where a detachment can delay while the column slips south. Cut-off risk for stragglers in side alleys.

**Decisions (position).**
- Form a **rear-guard line at the brickyard / northern blocks** while the bulk marches south → trades men for column speed and a cohesion bonus if held ~90 s.
- Keep the **whole company in one body** on the main north–south street → faster, pursuit stuck to the rear.
- Cut **east too early** into side alleys → squads become **cut off** (separated markers; delayed Cemetery arrival or casualties).
- Form on **Cemetery Hill crest / gatehouse** → rally; end of Day One.

**Visible consequences.** Firing in streets; fences and brick blocks as cover; brickyard stand shows a thin blue line vs gray; cut-off men appear separated; CSA pursuit and **flanking through parallel streets**; on the hill, the company dresses the line — no cutaway.

**Enemy.** Pursuit on the heels of the column; flank entries from east/west alleys; optional second wave into town from the north/west.

**Objectives.** Get ≥60% of living effectives through town onto the Cemetery approaches; optional brickyard hold ≥90 s for cohesion bonus.

**Win.** Column reaches gatehouse / crest in order and forms — Day One complete. **Lose.** Shattered in town (<40% reach the hill); or officer cut off in an alley with no succession.

---

### Day Two — July 2, 1863 (three points, southern continuous field)

Day Two loads a **separate continuous southern battlefield**. Day One ending ammo / casualties / cohesion seed starting strength. Marker: `Day 2 · Point N`. Officer decisions remain where the company is led and formed.

#### Day 2 · Point 1 — Devil’s Den / Houck’s Ridge

**Setup.** Broken boulder field and ridge linking the valley to Little Round Top. Delay CSA moving from the Den toward the LRT saddle, or cover a withdrawal toward the hill.

**Map features.** Triangular field edge, boulder piles, Plum Run low ground, Houck’s Ridge spine, sightlines up to LRT.

**Decisions (position).** Form among **Den boulders** (strong short-range, isolation risk); form on **Houck’s Ridge** (better withdraw path); abandon early and **climb toward LRT** → feeds Point 3 with more bodies but cedes the valley sooner.

**Win → Point 2 or 3.** Delay timer met and company reforms toward Wheatfield or LRT. **Lose.** Trapped in the Den; or LRT left opened from below.

#### Day 2 · Point 2 — The Wheatfield

**Setup.** Open stalks, Stony Hill on one flank, stone wall / tree line as withdraw anchor east. Control seesaws.

**Decisions (position).** **Commit into the wheat**; **withdraw to the stone wall**; hesitate in the middle → enfilade from Stony Hill.

**Win.** Hold/re-take wheat at timer with cohesion ≥35, **or** ordered wall defense that stops CSA past the wall. **Lose.** Broken in the open wheat.

#### Day 2 · Point 3 — Little Round Top

**Setup.** Extreme left on the rocky southern slope. Timber and stone below; valley toward Devil’s Den visible. Repeated uphill assaults; cartridges dwindle.

**Decisions (position).** **Refuse the line** along the southern spur; **form for bayonet charge downhill** (Chamberlain-style); hold a straight empty-ammo line → likely lose the crest.

**Win.** Crest held and local CSA broken. **Lose.** CSA crowns Little Round Top.

---

### Day Two — area notes

| Area | Role |
|------|------|
| Devil’s Den / Houck’s Ridge | Point 1 broken ground linking valley to LRT |
| The Wheatfield | Point 2 open murder ground; commit or wall-withdraw |
| Little Round Top | Point 3 rocky left-flank height; refuse or charge by formation |
| Peach Orchard / Emmitsburg Road | Later fill |
| Cemetery Ridge (south) | Reform continuous with Day One cemetery narrative |

Officer choices on both days follow the same rule: committed by where the company is led and formed. No host / menu framing.

---

---

## Gettysburg regiments (historically verified)

Player company is a detachment of the listed Union regiment for that Point. CSA opponents are the historical opposing brigades/regiments. Strengths are approximate effectives engaged (not paper returns). Flag styles follow period practice: Union national + regimental colors; CSA ANV-pattern battle flag.

| Point | Side | Regiment (player or foe) | Brigade / commander | Position | Approx. strength | Flag | Sources |
|-------|------|--------------------------|---------------------|----------|------------------|------|---------|
| Day 1 · Pt 1 | Union (player) | **24th Michigan Infantry** | Iron Brigade (1st Brig., 1st Div., I Corps) — BG Solomon Meredith; Col. Henry A. Morrow | Herbst / McPherson Woods, south of Chambersburg Pike | ~496 engaged; ~363 casualties Jul 1 | US national + blue regimental | [NPS AOP OOB](https://www.nps.gov/gett/learn/historyculture/aop-orderofbattle.htm); [NPS history series](https://www.npshistory.com/publications/civil_war_series/16/sec3.htm) |
| Day 1 · Pt 1 | CSA | **Archer’s Brigade** (13th AL, 5th AL Bn, 1st/7th/14th TN) | Heth’s Div., III Corps — BG James J. Archer | West slope / Willoughby Run into Herbst Woods | ~1,200 | ANV battle flags | [Addressing Gettysburg CSA OOB](https://www.addressinggettysburg.com/confederate-order-of-battle/); NPS series sec.3 |
| Day 1 · Pt 1 | CSA (north) | **Davis’s Brigade** (2nd/11th/42nd MS, 55th NC) | Heth’s Div. — BG Joseph R. Davis | North of pike / unfinished railroad cut | ~2,300 | ANV battle flags | Same CSA OOB; NPS series sec.3 |
| Day 1 · Pt 2 | Union (player) | **24th Michigan** (Iron Brigade remnant) falling back with I Corps | Meredith / Robinson | Seminary Ridge breastworks / approaches | remnant of morning fight | national + regimental | NPS series [sec.4](https://npshistory.com/publications/civil_war_series/16/sec4.htm); NPS AOP OOB |
| Day 1 · Pt 2 | CSA | **Pettigrew’s Brigade** pressure (esp. **26th North Carolina**) then **Pender** | Heth / Pender | West of seminary | 26th NC ~800+ engaged | ANV battle flags | NPS series sec.4; Addressing Gettysburg CSA OOB |
| Day 1 · Pt 3 | Union (player) | **154th New York** (Coster’s brigade detachment narrative) / I–XI Corps fragments | Coster (1st Brig., 2nd Div., XI Corps) — Col. Charles R. Coster | Town streets / Kuhn’s brickyard rear-guard | Coster’s four regiments (134th NY, 154th NY, 27th PA, 73rd PA) | national + regimental | NPS AOP OOB (XI Corps); town fight context |
| Day 1 · Pt 3 | CSA | Early / Rodes pursuit into town | Ewell’s Corps | Town grid from north/west | — | ANV battle flags | NPS first-day narratives |
| Day 2 · Pt 1 | Union | **124th New York** (“Orange Blossoms”) with Ward’s line | Ward’s Brig., Birney’s Div., III Corps | Devil’s Den / Houck’s Ridge | regiment-scale | national + regimental | NPS AOP OOB (III Corps Ward) |
| Day 2 · Pt 1 | CSA | **Texas / Law elements** (Hood) | Hood’s Div., I Corps ANV | Den boulders / gorge | — | ANV battle flags | NPS / ABT Day 2 left |
| Day 2 · Pt 2 | Union | **17th Maine** / de Trobriand & Caldwell fragments | de Trobriand / Caldwell | Wheatfield | — | national + regimental | NPS AOP OOB |
| Day 2 · Pt 3 | Union (player) | **20th Maine Infantry** | Vincent’s 3rd Brig., 1st Div., V Corps — Col. Strong Vincent; Col. Joshua L. Chamberlain | Extreme left, Little Round Top | ~358 | national + regimental | [ABT Defense of LRT](https://www.battlefields.org/learn/articles/defense-little-round-top); [NPS LRT tour](https://www.nps.gov/gett/learn/photosmultimedia/little-round-top-tour.htm); NPS AOP OOB |
| Day 2 · Pt 3 | CSA | **15th Alabama** (with **47th Alabama**) | Law’s Brig., Hood’s Div. — Col. William C. Oates | Front/left of 20th Maine slope | Oates report: 17k / 54w / 90m | ANV battle flag | [NPS Oates OR](https://www.nps.gov/gett/learn/historyculture/official-report-of-colonel-william-c-oates.htm); ABT LRT |

**Corrections applied vs prior “style” stubs:** replaced vague “Iron Brigade–style / 20th Maine–style” wording with named regiments above; player Day 1 company is **24th Michigan** (not a generic western stand-in); Day 1 Point 3 rear-guard framed on **Coster / Kuhn’s brickyard** (154th NY) rather than an unnamed block; Day 2 Point 3 foe locked to **15th/47th Alabama under Oates**; Day 1 morning foes locked to **Archer** (woods) and **Davis** (cut/pike).

### Field music & colors (per regiment)
Each regiment on the field has exactly one **fifer**, one **drummer**, and one **color bearer**. Only the fifer and drummer play procedural WebAudio music. The color bearer carries the colors only (no music). If the color bearer falls, a nearby combatant takes up the colors.

### Morale states & rally
Company morale bar shows: **Steady** (≥70) · **Wavering** (40–69) · **Broken** (<18 and routing) · **Rallying** (at rally point reforming).

When a regiment **retreats to the next point** (or falls back to a rally point on the colors), it restores **25% of the morale it has lost**, once per retreat:

`newMorale = current + 0.25 × (100 − current)`

A brief **+X% morale** flash appears on the bar / HUD. **No soldiers return** — casualties stay lost. While **Rallying**, survivors re-form around the colors, the drummer beats assembly, and morale may continue climbing toward a soft cap of ~45–50% (faster if the officer is nearby and no enemies are close). Once regrouped, the company holds the rally line or returns to the fight.

---

*Document version 0.6 — historical OOB table; independent fire; field music/colors; break/rally morale.*
