# ERM Zerg Economy
This mod is an internal library to share zerg economy features between zerg enemy mods. It provides a workflow to get biter egg if the player doesn't play with biter enemy at all.  

This mod does not add prototype or handle game logic by itself.  It's done in the enemy mod that uses this.

# Features:
- Added Larva egg economy.
- Added recipe to create more larva egg (Biochamber).
- Added recipe to convert larva egg to nutrients (Biochamber).
- Added recipe to convert larva egg to biter egg (Biochamber).
- Added recipe to produce uranium-238 with larva egg (New Assembly machine: Plasma Assembling Machine)
- Added technology to unlock playable zerg.
- Added Hatchery for player to build zerg units.
- Added zerglings, hydralisk, mutalisk, guardian, infested terran and ultralisk as playable units.
- Added zerg damage research to upgrade their damage (10 tiers, up to 200% increase).

# Implementation Guide
See zerg's prototypes/economy.lua

