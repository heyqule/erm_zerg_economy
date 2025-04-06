--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--

local ERM_UnitTint = require("__enemyracemanager__/lib/rig/unit_tint")
local ERM_UnitHelper = require("__enemyracemanager__/lib/rig/unit_helper")
local ERMPlayerUnitHelper = require("__enemyracemanager__/lib/rig/player_unit_helper")
local GlobalConfig = require("__enemyracemanager__/lib/global_config")
local ZergSound = require("__erm_zerg_hd_assets__/sound")
local AnimationDB = require("__erm_zerg_hd_assets__/animation_db")
local name = "zergling"

local hitpoint = 75
local resistances = 72


local movement_speed = 0.35
local damage_modifier = 25

-- Misc settings
local distraction_cooldown = 30

local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }

local running_animation = AnimationDB.get_layered_animations("units", name, "run")
running_animation = AnimationDB.apply_runtime_tint(running_animation, true)

local attack_animation = AnimationDB.get_layered_animations("units", name, "attack")
attack_animation = AnimationDB.apply_runtime_tint(attack_animation, true)

local Unit = {}

function Unit.make(prefix, hp_mp, damage_mp)
    local attack_range = 1
    local vision_distance = ERMPlayerUnitHelper.get_vision_distance(attack_range)
    
    data:extend({
        {
            type = "unit",
            name = prefix..'--controllable--'..name,
            localised_name = { "entity-name." .. prefix..'--controllable--'..name },
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air", "not-repairable" },
            has_belt_immunity = false,
            max_health = hitpoint * hp_mp * ERMPlayerUnitHelper.get_health_multiplier(),
            order = prefix .. "--unit--" .. name,
            subgroup = "erm_controllable_units",
            can_open_gates = true,
            --ai_settings = biter_ai_settings,
            radar_range = 1,
            shooting_cursor_size = 2,
            resistances = {
                { type = "acid", percent = resistances },
                { type = "poison", percent = resistances },
                { type = "physical", percent = resistances },
                { type = "fire", percent = resistances },
                { type = "explosion", percent = resistances },
                { type = "laser", percent = resistances },
                { type = "electric", percent = resistances },
                { type = "cold", percent = resistances }
            },
            healing_per_tick = 0,
            --collision_mask = { "player-layer" },
            collision_box = collision_box,
            selection_box = selection_box,
            sticker_box = selection_box,
            vision_distance = vision_distance,
            movement_speed = movement_speed * ERMPlayerUnitHelper.get_speed_multiplier(),
            absorptions_to_join_attack = { pollution = 100},
            distraction_cooldown = distraction_cooldown,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                range = 1,
                cooldown = 15,
                cooldown_deviation = 0.1,
                damage_modifier = damage_modifier * damage_mp,
                ammo_category = prefix.."--erm_controllable",
                ammo_type = ERM_UnitHelper.make_unit_melee_ammo_type(10),
                sound = ZergSound.zergling_attack(0.9),
                animation = attack_animation
            },
            distance_per_frame = 0.24,
            run_animation = running_animation,
            dying_sound = ZergSound.enemy_death(name, 0.9),
            map_color = ERM_UnitTint.tint_army_color(),
            enemy_map_color = { r=1, b=0, g=0 },
            corpse = name .. "-corpse"
        },
        {
            type = "corpse",
            name = name .. "-corpse",
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-off-grid", "building-direction-8-way", "not-on-map" },
            selection_box = selection_box,
            selectable_in_game = false,
            dying_speed = 0.04,

            subgroup = "corpses",
            order = name .. "-corpse",
            final_render_layer = "corpse",
            animation = AnimationDB.get_layered_animations("units", name, "corpse"),
        }
    })
end

return Unit