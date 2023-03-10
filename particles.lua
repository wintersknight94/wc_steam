-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, math
    = minetest, nodecore, math
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local hotrock = "nc_igneous:amalgam"
------------------------------------------------------------------------
local function steamy(posa, posb)
	posb=posb or posa 
	local minpos = {
		x = (posa.x < posb.x and posa.x or posb.x) - 0.5,
		y = (posa.y < posb.y and posa.y or posb.y) - 0.5,
		z = (posa.z < posb.z and posa.z or posb.z) - 0.5
	}
	local maxpos = {
		x = (posa.x > posb.x and posa.x or posb.x) + 0.5,
		y = (posa.y > posb.y and posa.y or posb.y) + 1.5,
		z = (posa.z > posb.z and posa.z or posb.z) + 0.5
	}
	local volume = (maxpos.x - minpos.x + 1) * (maxpos.y - minpos.y + 1)
	* (maxpos.z - minpos.z + 1)
	minetest.add_particlespawner({
			amount = 5 * volume,
			time = 10,
			minpos = minpos,
			maxpos = maxpos,
			minvel = {x = -0.1, y = 0.25, z = -0.1},
			maxvel = {x = 0.1, y = 0.75, z = 0.1},
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
			local above = {x = pos.x, y = pos.y + 1, z = pos.z}
			local abnod = minetest.get_node(above)
			     if abnod.name == "nc_terrain:water_source" then
					steamy(pos)
					nodecore.sound_play("nc_api_craft_hiss", {pos = pos, gain = 0.02, fade = 1})
			end
		end
})


