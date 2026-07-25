-- LUALOCALS < ---------------------------------------------------------
local core, nodecore, math, vector
    = core, nodecore, math, vector
-- LUALOCALS > ---------------------------------------------------------

local directions = {
	vector.new( 1, 0, 0),
	vector.new(-1, 0, 0),
	vector.new( 0, 0, 1),
	vector.new( 0, 0,-1),
}

----- ----- Lighter Than Air ----- -----
nodecore.register_abm({
	label = "gaseous:lighter than air",
	nodenames = {"group:gaseous"},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		local above = pos:offset(0,1,0)
		local abnod = core.get_node(above)
		if abnod.name == "air" then
			core.swap_node(above, node)
			core.swap_node(pos, abnod)
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
		local above = pos:offset(0,1,0)
		local abnod = core.get_node(above)
		if core.get_item_group(abnod.name, "water") > 0 then
			core.swap_node(above, node)
			core.swap_node(pos, abnod)
		else
			local dir = directions[math.random(1,4)]
			local next_pos = vector.add(pos, dir)
			local next_node = core.get_node(next_pos)
			if core.get_item_group(next_node.name, "water") > 0 then
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
	action = function(pos)
		local pressure = #nodecore.find_nodes_around(pos, "group:gaseous")
		local airway = #nodecore.find_nodes_around(pos, "air")
		if pressure < 4 and airway > 2 then
			core.remove_node(pos)
		end
	end
})

nodecore.register_abm({
	label = "thin atmoshpere",
	interval = 1,
	chance = 1,
	nodenames = {"group:gaseous"},
	neighbors = {"air"},
	min_y = 121,
	action = function(pos)
		local airway = #nodecore.find_nodes_around(pos, "air")
		if airway > 1 then
			core.remove_node(pos)
		end
	end
})

