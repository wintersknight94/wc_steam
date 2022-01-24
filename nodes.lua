-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, pairs, ipairs
    = minetest, nodecore, pairs, ipairs
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

--------------------Steam Nodes--------------------
minetest.register_node(modname ..":steam", {
		description = "Steam",
		tiles = {"nc_concrete_etched.png^[opacity:50"},
--		tiles = {modname .. "_thin.png"},
		use_texture_alpha = true,
		drawtype = "allfaces",
		drowning = 1,
		paramtype = "light",
		sunlight_propagates = true,
		floodable = false,
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		touchthru = true,
		groups = {
               gaseous = 1,
               steam = 1
		},
--		sounds = nodecore.sounds("nc_api_craft_hiss")
		post_effect_color = {a=100, r=200, g=200, b=200},
		color = "white"
	})

minetest.register_node(modname ..":steam_dense", {
		description = "Steam",
		tiles = {"nc_concrete_etched.png^[opacity:100"},
--		tiles = {modname .. "_dense.png"},
		use_texture_alpha = true,
		drawtype = "allfaces",
		drowning = 2,
		paramtype = "light",
		sunlight_propagates = true,
		floodable = false,
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		touchthru = true,
		groups = {
               gaseous = 1,
               steam = 1,
               dense_gas = 1
		},
--		sounds = nodecore.sounds("nc_api_craft_hiss")
		post_effect_color = {a=200, r=200, g=200, b=200},
		color = "white"
	})


