-- LUALOCALS < ---------------------------------------------------------
local core, nodecore
    = core, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = core.get_current_modname()

--local wsrc = "nc_terrain:water_source"
local wflw = "nc_terrain:water_flowing"

--------------------Steam Node Generation--------------------
nodecore.register_abm({
	label = "generate steam:direct",
	interval = 4,
	chance = 4,
	nodenames = {"group:water"},
	neighbors = {"group:igniter"},
	neightbors_invert = true,
	action = function(pos)
		local above = pos:offset(0,1,0)
		local abnod = core.get_node(above)
		if abnod.name == "air" then
			nodecore.set_node(above, {name = modname .. ":steam"})
			nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.02, fade = 1})
--		elseif abnod.name == wsrc or wflw then
		elseif abnod.name == wflw then
			nodecore.set_node(above, {name = modname .. ":steam_dense"})
			nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.05, fade = 1})
		end
	end
})
	
nodecore.register_abm({
	label = "generate steam:boiler",
	interval = 4,
	chance = 4,
	nodenames = {"group:water"},
	action = function(pos)
		local above = pos:offset(0,1,0)
		local coil_pos = pos:offset(0,-2,0)
		local coil_node = core.get_node(coil_pos)
		local abnod = core.get_node(above)
		if abnod.name == "air" then
			if coil_node.name == "nc_fire:fire" then
				nodecore.set_node(above, {name = modname .. ":steam"})
				nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.02, fade = 1})
			elseif coil_node.name == "nc_terrain:lava_source" then
				nodecore.set_node(above, {name = modname .. ":steam"})
				nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.02, fade = 1})
			end
		end
	end
})

--------------------Steam Pressure--------------------
nodecore.register_abm({
	label = "condense steam",
	interval = 1,
	chance = 1,
	nodenames = {modname .. ":steam"},
	without_neighbors = {"air"},
	neighbors = {"group:steam"},
	action = function(pos)
		nodecore.set_node(pos, {name = modname .. ":steam_dense"})
		nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.02, fade = 1})
	end
})

nodecore.register_abm({
	label = "disperse steam",
	interval = 1,
	chance = 1,
	nodenames = {modname .. ":steam_dense"},
	neighbors = {"air"},
	action = function(pos)
		local pressure = #nodecore.find_nodes_around(pos, "group:steam")
		if pressure < 4 then
			nodecore.set_node(pos, {name = modname .. ":steam"})
		end
	end
})


