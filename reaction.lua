-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, pairs, ipairs
    = minetest, nodecore, pairs, ipairs
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()
local get_node = minetest.get_node
local set_node = minetest.swap_node

local wsrc = "nc_terrain:water_source"
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
			local above = {x = pos.x, y = pos.y + 1, z = pos.z}
			local abnod = minetest.get_node(above)
				if abnod.name == "air" then
					nodecore.set_node(above, {name = modname .. ":steam"})
					nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.02, fade = 1})
--				else if abnod.name == wsrc or wflw then
				else if abnod.name == wflw then
					nodecore.set_node(above, {name = modname .. ":steam_dense"})
					nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.05, fade = 1})
				end
			end
		end
	})
	
nodecore.register_abm({
		label = "generate steam:boiler",
		interval = 4,
		chance = 4,
		nodenames = {"group:water"},
		action = function(pos)
			local above = {x = pos.x, y = pos.y + 1, z = pos.z}
			local coil_pos = {x = pos.x, y = pos.y - 2, z = pos.z}
			local coil_node = minetest.get_node(coil_pos)
			local abnod = minetest.get_node(above)
			     if abnod.name == "air" then
			          if coil_node.name == "nc_fire:fire" then
		                    nodecore.set_node(above, {name = modname .. ":steam"})
		    	               nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.02, fade = 1})
		    	          else  if coil_node.name == "nc_terrain:lava_source" then
		                    nodecore.set_node(above, {name = modname .. ":steam"})
		    	               nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.02, fade = 1})
		          end
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
		action = function(pos, node)
          local pressure = #nodecore.find_nodes_around(pos, "group:steam")
          local airway = #nodecore.find_nodes_around(pos, "air")
               if pressure ~= 0 and airway == 0 then
		     nodecore.set_node(pos, {name = modname .. ":steam_dense"})
		     nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.02, fade = 1})
		end
	end	
})

nodecore.register_abm({
		label = "disperse steam",
		interval = 1,
		chance = 1,
		nodenames = {modname .. ":steam_dense"},
		action = function(pos, node)
          local pressure = #nodecore.find_nodes_around(pos, "group:steam")
          local airway = #nodecore.find_nodes_around(pos, "air")
               if pressure < 4 and airway ~= 0 then
		     nodecore.set_node(pos, {name = modname .. ":steam"})
		end
	end	
})


