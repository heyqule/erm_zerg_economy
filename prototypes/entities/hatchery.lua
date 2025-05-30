---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/21/2020 4:42 PM
---
require ("__erm_zerg_economy__/prototypes/circuit_connector_definitions")
local util = require("util")
local hit_effects = require ("__base__/prototypes/entity/hit-effects")
local sounds = require ("__base__/prototypes/entity/sounds")
local ERM_UnitTint = require("__enemyracemanager__/lib/rig/unit_tint")

local AnimationDB = require("__erm_zerg_hd_assets__/animation_db")
local ZergSound = require("__erm_zerg_hd_assets__/sound")


local Unit = {}
function Unit.make(prefix)
    local idle = AnimationDB.get_layered_animations("buildings", "hatchery", "run")

    idle = AnimationDB.change_frame_count(idle, 1)

    idle = AnimationDB.alter_team_color(idle, nil, true)

    local working = AnimationDB.get_layered_animations("buildings", "hatchery", "run")

    working = AnimationDB.alter_team_color(working, nil, true)

    data:extend({
        {
            type = "assembling-machine",
            name = prefix .. "--controllable--hatchery",
            icons = {
                {
                    icon = "__erm_zerg_hd_assets__/graphics/entity/icons/buildings/advisor.png",
                    icon_size = 64,
                },
            },
            flags = {"placeable-neutral","placeable-player", "player-creation"},
            minable = {mining_time = 1, result = prefix .. "--controllable--hatchery"},
            max_health = 2500,
            corpse = "zerg--large-base-corpse",
            dying_explosion = "zerg--building-explosion",
            allow_run_time_change_of_is_military_target = false,
            is_military_target = true,
            circuit_wire_max_distance = erm_zerg_economy_circuit_wire_max_distance,
            circuit_connector = erm_zerg_economy_connector['hatchery'],
            is_military_target = true,
            resistances =
            {
                { type = "poison", percent = 50 },
                { type = "physical", percent = 50 },
                { type = "fire", percent = 50 },
                { type = "explosion", percent = 50},
                { type = "laser", percent = 50 },
                { type = "electric", percent = 50 },
                { type = "cold", percent = 50},
                { type = "impact", percent = 90, decrease = 50 },
            },
            collision_box = {{-3, -2.7}, {3.2, 2.7}},
            selection_box = {{-3, -3}, {3.2, 3}},
            map_generator_bounding_box = {{-4,-4}, {4.2,4}},
            damaged_trigger_effect = hit_effects.entity(),
            energy_source =
            {
                type = "burner",
                fuel_categories = {"nutrients"},
                effectivity = 1,
                burner_usage = "nutrients",
                fuel_inventory_size = 1,
                emissions_per_minute = { pollution = 5 }
            },
            energy_usage = "1MW",
            crafting_categories = {prefix.."--erm_controllable"},
            crafting_speed = 1,
            graphics_set = {
                animation = working,
                idle_animation = idle,
            },
            open_sound = sounds.machine_open,
            close_sound = sounds.machine_close,
            vehicle_impact_sound = sounds.generic_impact,
            working_sound = ZergSound.building_working_sound("hatchery", 0.9),
            dying_sound = ZergSound.building_dying_sound(0.9),
            map_color = ERM_UnitTint.tint_army_color(),
            enemy_map_color = { r=1, b=0, g=0 },
        },
        {
            type = "corpse",
            name = "zerg--large-base-corpse",
            flags = { "placeable-neutral",  "not-on-map" },
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            collision_box = { { -2, -2 }, { 2, 2 } },
            selection_box = { { -2, -2 }, { 2, 2 } },
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = minute * settings.startup["enemyracemanager-enemy-corpse-time"].value,
            subgroup = "corpses",
            order = "c[corpse]-c[large-zerg-base-corpse]",
            final_render_layer = "remnants",
            animation = AnimationDB.get_layered_animations("death", "large_rubble", "run")
        },
        {
            type = "explosion",
            name = "zerg--building-explosion",
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            subgroup = "explosions",
            flags = { "not-on-map" },
            hidden = true,
            order = "zerg-explosions",
            render_layer = "explosion",
            animations = AnimationDB.get_layered_animations("death", "large_building", "explosion")
        },
    })
end
return Unit