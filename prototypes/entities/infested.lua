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
local name = "infested"

local hitpoint = 78

local resistances = 75


-- Handles explosion damages

local damage_modifier = 40



-- Misc settings

local distraction_cooldown = 30

local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }

local running_animation = AnimationDB.get_layered_animations("units", name, "run")
running_animation = AnimationDB.apply_runtime_tint(running_animation, true)

local Unit = {}

function Unit.make(prefix, hp_mp, damage_mp, SDA)
    local attack_range = 1
    local vision_distance = ERMPlayerUnitHelper.get_vision_distance(attack_range)
    data:extend({
        {
            type = "unit",
            name = prefix..'--controllable--'..name,
            localised_name = { "entity-name." .. prefix..'--controllable--'..name },
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air", "not-flammable", "not-repairable" },
            has_belt_immunity = true,
            max_health = hitpoint * hp_mp * ERMPlayerUnitHelper.get_health_multiplier(),
            order = prefix .. "--unit--" .. name,
            subgroup = "erm_controllable_units",
            shooting_cursor_size = 2,
            radar_range = 1,
            can_open_gates = true,
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
            movement_speed = 0.275 * ERMPlayerUnitHelper.get_speed_multiplier(),
            absorptions_to_join_attack = { pollution = 100},
            distraction_cooldown = distraction_cooldown,
            spawning_time_modifier = 1.5,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                range = attack_range,
                cooldown = 10,
                warmup = 10,
                damage_modifier = damage_modifier * damage_mp,

                ammo_category = prefix.."--erm_controllable",
                ammo_type = {
                    target_type = "direction",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "instant",
                            source_effects = {
                                {
                                    type = "script",
                                    effect_id = SDA,
                                },
                                {
                                    type = "create-explosion",
                                    entity_name = "medium-explosion"
                                },
                            },
                            target_effects = {
                                {
                                    type = "nested-result",
                                    action = {
                                        type = "area",
                                        force = "not-same",
                                        radius = 5,
                                        ignore_collision_condition = true,
                                        action_delivery = {
                                            type = "instant",
                                            target_effects = {
                                                {
                                                    type = "damage",
                                                    damage = { amount = 100, type = "explosion" },
                                                    apply_damage_to_trees = true
                                                },
                                            }
                                        }
                                    },
                                },
                            }
                        }
                    },
                },
                sound = ZergSound.infested_attack(0.9),
                animation = running_animation
            },
            map_color = ERM_UnitTint.tint_army_color(),
            enemy_map_color = { r=1, b=0, g=0 },
            distance_per_frame = 0.24,
            run_animation = running_animation,
            dying_sound = ZergSound.infested_death(1),
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
            time_before_removed = minute * settings.startup["enemyracemanager-enemy-corpse-time"].value,
            subgroup = "corpses",
            order = name,
            final_render_layer = "corpse",
            animation = AnimationDB.get_single_animation("units", name, "corpse"),
        }
    })
end

return Unit
