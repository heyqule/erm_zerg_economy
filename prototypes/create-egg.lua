---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 2/22/2025 1:31 PM
---
--- Create egg item, tech and recipe
---
local FusionEconomy = require("__erm_libs__/prototypes/fusion_economy_helper")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")


local ZergLarva = {}

local function get_secondary_color(color)
    color = util.table.deepcopy(color)
    local limit = (240/255)
    local change_r = 60/255
    local change_g = 32/255
    if color.r + change_r < limit then
        color.r = color.r + change_r
    end
    if color.g + change_g < limit then
        color.g = color.g + change_g
    end
    return color
end

function ZergLarva.init()
    data.extend({
        {
            type = "item-subgroup",
            name = "erm-egg-processes",
            group = "intermediate-products",
            order = "m"
        },
    })
end

function ZergLarva.create_item(name, trigger_name, color_tint)
    color_tint = util.table.deepcopy(color_tint)
    data.extend({
        {
            type = "item",
            name = name,
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/items/larva_egg.png",
            pictures = {
                {
                    layers = {
                        { size = 64, filename = "__erm_zerg_hd_assets__/graphics/entity/items/larva_egg/larva_egg_1.png", scale = 0.5 },
                        { size = 64, filename = "__erm_zerg_hd_assets__/graphics/entity/items/larva_egg/larva_egg_1_teamcolor.png", scale = 0.5, tint = color_tint, blend_mode = 'additive-soft' },
                    }
                }
            },
            fuel_category = "chemical",
            fuel_value = "10MJ",
            subgroup = "agriculture-products",
            order = "x[eggs]-a[zerg-larva]",
            inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
            pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
            drop_sound = space_age_item_sounds.agriculture_inventory_move,
            stack_size = 100,
            weight = 1 * kg,
            spoil_ticks = 0.5 * hour,
            --spoil_ticks = 10 * second,
            spoil_to_trigger_result = {
                items_per_trigger = 1,
                trigger = {
                    type = "direct",
                    action_delivery = {
                        type = "instant",
                        source_effects = {
                            {
                                type = "script",
                                effect_id = trigger_name,
                            },
                        }
                    }
                }
            }
        }
    })
end

function ZergLarva.create_larva_egg_duplication_recipe(name, additional_ingredients, color_tint)
    color_tint = util.table.deepcopy(color_tint)
    color_tint.a = 1
    local ingredients = {
        {type = "item", name = name, amount = 2}
    }
    
    if additional_ingredients then
        for _, ind in pairs(additional_ingredients) do
            table.insert(ingredients, ind)
        end            
    end

    data.extend({
        {
             type = "recipe",
             name = name.."-clone",
             icon = "__erm_zerg_hd_assets__/graphics/entity/icons/items/larva_egg.png",
             category = "organic",
             subgroup = "erm-egg-processes",
             order = "x["..name.."]-a[larva]",
             hide_from_player_crafting = false,
             auto_recycle = false,
             preserve_products_in_machine_output = true,
             energy_required = 10,
             ingredients = ingredients,
             results =
             {
                 {type = "item", name = name, amount = 4}
             },
             result_is_always_fresh = false,
             allow_productivity = true,
             allow_quality = false,
             enabled = false,
             crafting_machine_tint =
             {
                 primary = color_tint,
                 secondary = get_secondary_color(color_tint),
             },
         }
    })
end

function ZergLarva.create_larva_egg_fresh_duplication_recipe(name, additional_ingredients, color_tint)
    color_tint = util.table.deepcopy(color_tint)
    color_tint.a = 1
    local ingredients = {
        {type = "item", name = name, amount = 50}
    }

    if additional_ingredients then
        for _, ind in pairs(additional_ingredients) do
            table.insert(ingredients, ind)
        end
    end

    data.extend({
        {
            type = "recipe",
            name = name.."-fresh-clone",
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/items/larva_egg.png",
            category = "organic",
            subgroup = "erm-egg-processes",
            order = "x["..name.."]-a[larva]",
            hide_from_player_crafting = false,
            auto_recycle = false,
            preserve_products_in_machine_output = true,
            energy_required = 30,
            ingredients = ingredients,
            results =
            {
                {type = "item", name = name, amount = 1}
            },
            result_is_always_fresh = true,
            allow_productivity = false,
            allow_quality = false,
            enabled = false,
            crafting_machine_tint =
            {
                primary = color_tint,
                secondary = get_secondary_color(color_tint),
            },
        }
    })
end


function ZergLarva.create_larva_egg_to_nutrients_recipe(name, nutrients_amount, color_tint)
    color_tint = util.table.deepcopy(color_tint)
    color_tint.a = 1
    data.extend({
        {
            type = "recipe",
            name = name.."-to-nutrients",
            icons = {
                {
                    icon = "__erm_zerg_hd_assets__/graphics/entity/icons/items/larva_egg.png",
                    icon_size = 64,
                    scale = 0.5,
                    shift = {-9,-9}
                },
                {
                    icon = "__space-age__/graphics/icons/nutrients.png",
                    icon_size = 64,
                    scale = 0.5,
                    shift = {9, 9}
                },
            },
            category = "organic",
            subgroup = "erm-egg-processes",
            order = "x["..name.."]-a[egg-nutrients]",
            hide_from_player_crafting = false,
            auto_recycle = false,
            enabled = false,
            energy_required = 2,
            ingredients = {{type = "item", name = name, amount = 1}},
            results = {{type="item", name="nutrients", amount= nutrients_amount}},
            allow_productivity = true,
            allow_quality = false,
            crafting_machine_tint =
            {
                primary = color_tint,
                secondary = get_secondary_color(color_tint),
            },
        }
        
    })
end

function ZergLarva.create_larva_egg_to_biter_egg_recipe(name, additional_ingredients, color_tint)
    color_tint = util.table.deepcopy(color_tint)
    color_tint.a = 1
    local ingredients = {
        {type = "item", name = name, amount = 1}
    }

    if additional_ingredients then
        for _, ind in pairs(additional_ingredients) do
            table.insert(ingredients, ind)
        end
    end

    data.extend({
    {
        type = "recipe",
        name = name.."-to-biter-egg",
        icons = {
            {
                icon = "__erm_zerg_hd_assets__/graphics/entity/icons/items/larva_egg.png",
                icon_size = 64,
                scale = 0.5,
                shift = {-9,-9}
            },
            {
                icon = "__space-age__/graphics/icons/biter-egg.png",
                icon_size = 64,
                scale = 0.5,
                shift = {9, 9}
            },
        },
        category = "organic",
        subgroup = "erm-egg-processes",
        order = "x["..name.."]-a[egg-nutrients]",
        hide_from_player_crafting = false,
        auto_recycle = false,
        enabled = false,
        energy_required = 5,
        ingredients = ingredients,
        results = {{type="item", name="biter-egg", amount=1}},
        allow_productivity = true,
        allow_quality = false,
        crafting_machine_tint =
        {
            primary = color_tint,
            secondary = get_secondary_color(color_tint),
        },
    }})
end


function ZergLarva.create_larva_egg_to_uranium238_recipe(name)
    FusionEconomy.init()
    data.extend({
        {
            type = "recipe",
            name = name.."-to-uranium",
            icons = {
                {
                    icon = "__erm_zerg_hd_assets__/graphics/entity/icons/items/larva_egg.png",
                    icon_size = 64,
                    scale = 0.5,
                    shift = {-9,-9}
                },
                {
                    icon = "__base__/graphics/icons/uranium-ore.png",
                    icon_size = 64,
                    scale = 0.5,
                    shift = {9, 9}
                },
            },
            category = "fusion-assembly",
            subgroup = "erm-egg-processes",
            order = "x["..name.."]-a[uranium-238]",
            hide_from_player_crafting = false,
            auto_recycle = false,
            enabled = false,
            energy_required = 20,
            ingredients = {
                {type="item", name= name, amount=1},
                {type="item", name="uranium-238", amount = 10, ignored_by_stats = 10, ignored_by_productivity = 10},
                {type="fluid", name="fusion-plasma", amount = 2}
            },
            results = {
                {type = "item", name = "uranium-238", amount = 11, ignored_by_stats = 10, ignored_by_productivity = 10},
                {type= "fluid", name="fluoroketone-hot", amount= 2, temperature = 180, ignored_by_stats = 2, ignored_by_productivity = 2}
            },
            allow_productivity = true,
            allow_quality = false,
        }})
end

function ZergLarva.create_larva_egg_to_military_recipe(name, color_tint)
    color_tint = util.table.deepcopy(color_tint)
    color_tint.a = 1
    data.extend({
        {
            type = "recipe",
            name = name.."-to-military",
            icons = {
                {
                    icon = "__erm_zerg_hd_assets__/graphics/entity/icons/items/larva_egg.png",
                    icon_size = 64,
                    scale = 0.5,
                    shift = {-9,-9}
                },
                {
                    icon = "__base__/graphics/icons/military-science-pack.png",
                    icon_size = 64,
                    scale = 0.5,
                    shift = {9, 9}
                },
            },
            category = "chemistry",
            subgroup = "erm-egg-processes",
            order = "x["..name.."]-a[military]",
            hide_from_player_crafting = false,
            auto_recycle = false,
            enabled = false,
            energy_required = 10,
            ingredients = {
                {type="item", name= name, amount = 2},
                {type="item", name="military-science-pack", amount = 10},
            },
            results = {
                {type = "item", name = "military-science-pack", amount = 11, ignored_by_stats = 10, ignored_by_productivity = 10},
            },
            allow_productivity = true,
            allow_quality = false,
            crafting_machine_tint =
            {
                primary = color_tint,
                secondary = get_secondary_color(color_tint),
            },
        }})
end

function ZergLarva.create_larva_egg_to_promethium_recipe(name)
    FusionEconomy.init()
    data.extend({
        {
            type = "recipe",
            name = name.."-to-promethium",
            icons = {
                {
                    icon = "__erm_zerg_hd_assets__/graphics/entity/icons/items/larva_egg.png",
                    icon_size = 64,
                    scale = 0.5,
                    shift = {-9,-9}
                },
                {
                    icon = "__space-age__/graphics/icons/promethium-science-pack.png",
                    icon_size = 64,
                    scale = 0.5,
                    shift = {9, 9}
                },
            },
            category = "fusion-assembly",
            subgroup = "erm-egg-processes",
            order = "x["..name.."]-a[promethium]",
            hide_from_player_crafting = false,
            auto_recycle = false,
            enabled = false,
            energy_required = 10,
            ingredients = {
                {type="item", name= name, amount = 10},
                {type = "item", name = "promethium-science-pack", amount = 10},
                {type="fluid", name="fusion-plasma", amount = 1}
            },
            results = {
                {type = "item", name = "promethium-science-pack", amount = 12, ignored_by_stats = 10, ignored_by_productivity = 10},
                {type= "fluid", name="fluoroketone-hot", amount = 1, temperature = 180, ignored_by_stats = 1, ignored_by_productivity = 1}
            },
            allow_productivity = true,
            allow_quality = false,
        }})
end

function ZergLarva.create_tech(name)
    data.extend({
        {
            type = "technology",
            name = name.."-processing",
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/items/larva_egg.png",
            icon_size = 64,
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = name.."-clone"
                },
                {
                    type = "unlock-recipe",
                    recipe = name.."-fresh-clone"
                },
                {
                    type = "unlock-recipe",
                    recipe = name.."-to-nutrients"
                },
                {
                    type = "unlock-recipe",
                    recipe = name.."-to-biter-egg"
                },
                {
                    type = "unlock-recipe",
                    recipe = name.."-to-uranium"
                },
                {
                    type = "unlock-recipe",
                    recipe = name.."-to-promethium"
                }
            },
            research_trigger =
            {
                type = "build-entity",
                entity = "biochamber"
            }
        }
    })

    if data.raw.technology["military-science-pack"] then
        table.insert(data.raw.technology["military-science-pack"].effects, {
            type = "unlock-recipe",
            recipe = name.."-to-military"
        })
    end
end


return ZergLarva