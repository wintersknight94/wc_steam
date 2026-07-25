-- LUALOCALS < ---------------------------------------------------------
local core, nodecore, math
    = core, nodecore, math
-- LUALOCALS > ---------------------------------------------------------
local modname = core.get_current_modname()
local hotrock = "nc_igneous:amalgam"
------------------------------------------------------------------------
local function steamy(posa, posb)
	posb=posb or posa 
	local minpos, maxpos = vector.sort(posa, posb)
	minpos = minpos:offset(-0.5, -0.5, -0.5)
	maxpos = maxpos:offset(0.5, 1.5, 0.5)
	local volume = (maxpos.x - minpos.x + 1) * (maxpos.y - minpos.y + 1)
	* (maxpos.z - minpos.z + 1)
	core.add_particlespawner({
			amount = 5 * volume,
			time = 10,
			minpos = minpos,
			maxpos = maxpos,
			minvel = vector.new(-0.1, 0.25, -0.1),
			maxvel = vector.new(0.1, 0.75, 0.1),
			texture = "nc_api_craft_smoke.png^[opacity:150",
			minexptime = 2,
			maxexptime = 20,
			collisiondetection = true,
			minsize = 1,
			maxsize = 5
		})
end
------------------------------------------------------------------------
nodecore.register_abm({
		label = "particles:hydrothermal",
		interval = 20,
		chance = 5,
		nodenames = {"nc_igneous:amalgam"},
		action = function(pos)
			local above = pos:offset(0, 1, 0)
			local abnod = core.get_node(above)
			     if abnod.name == "nc_terrain:water_source" then
					steamy(pos)
					nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.02, fade = 1})
			end
		end
})


