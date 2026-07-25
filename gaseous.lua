-- LUALOCALS < ---------------------------------------------------------
local core, nodecore, math
    = core, nodecore, math
-- LUALOCALS > ---------------------------------------------------------
local modname = core.get_current_modname()
local get_node = core.get_node
local set_node = core.swap_node
local directions = {
	vector.new( 1, 0, 0),
	vector.new(-1, 0, 0),
	vector.new( 0, 0, 1),
	vector.new( 0, 0,-1),
}
local steam = {name = modname.. ":steam"}

----- ----- Lighter Than Air ----- -----
nodecore.register_abm({
	label = "gaseous:lighter than air",
	nodenames = {"group:gaseous"},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		local next_pos = pos:offset(0,1,0)
		local next_node = core.get_node(next_pos)
		local node = core.get_node(pos)
		if next_node.name == "air" then
			core.swap_node(next_pos, node)
			core.swap_node(pos, next_node)
		else
			local dir = directions[math.random(1,4)]
			local next_pos = vector.add(pos, dir)
			local next_node = core.get_node(next_pos)
			if next_node.name == "air" then
				core.swap_node(next_pos, node)
				core.swap_node(pos, next_node)
			end
		end
	end,
})
----- ----- Lighter Than Water ----- -----
nodecore.register_abm({
	label = "gaseous:lighter than water",
	nodenames = {"group:gaseous"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
		local next_pos = pos:offset(0,1,0)
		local next_node = core.get_node(next_pos)
		local node = core.get_node(pos)
		if next_node.name == "nc_terrain:water_flowing" then
			core.swap_node(next_pos, node)
			core.swap_node(pos, next_node)
		else
			local dir = directions[math.random(1,4)]
			local next_pos = vector.add(pos, dir)
			local next_node = core.get_node(next_pos)
			if next_node.name == "nc_terrain:water_flowing" then
				core.swap_node(next_pos, node)
				core.swap_node(pos, next_node)
			end
		end
	end,
})

nodecore.register_abm({
	label = "gaseous:lighter than water source",
	nodenames = {"group:gaseous"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
		local next_pos = pos:offset(0,1,0)
		local next_node = core.get_node(next_pos)
		local node = core.get_node(pos)
		if next_node.name == "nc_terrain:water_source" then
			core.swap_node(next_pos, node)
			core.swap_node(pos, next_node)
		else
			local dir = directions[math.random(1,4)]
			local next_pos = vector.add(pos, dir)
			local next_node = core.get_node(next_pos)
			if next_node.name == "nc_terrain:water_source" then
				core.swap_node(next_pos, node)
				core.swap_node(pos, next_node)
			end
		end
	end,
})

----- ----- Gaseous Dissapation ----- -----
nodecore.register_abm({
	label = "gaseous:dissapation",
	interval = 1,
	chance = 10,
	nodenames = {"group:gaseous"},
	action = function(pos, node)
		local pressure = #nodecore.find_nodes_around(pos, "group:gaseous")
		local airway = #nodecore.find_nodes_around(pos, "air")
		if pressure < 4 and airway > 2 then
			nodecore.set_node(pos, {name = "air"})
		end
	end
})

nodecore.register_abm({
	label = "thin atmoshpere",
	interval = 1,
	chance = 1,
	nodenames = {"group:gaseous"},
	action = function(pos, node)
		local altitude = pos.y
		local airway = #nodecore.find_nodes_around(pos, "air")
		if altitude > 120 and airway > 1 then
			nodecore.set_node(pos, {name = "air"})
		end
	end
})

