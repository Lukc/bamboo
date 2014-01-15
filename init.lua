-- [bamboo] mod by Krock [v2]
-- License for everything: WTFPL
-- Bamboo max high: 10

minetest.register_node("bamboo:bamboo",{
	description = "Bamboo",
	tiles = {"bamboo_bamboo.png"},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{0.1875,-0.5,-0.125,0.4125,0.5,0.0625}, --NodeBox1
			{-0.125,-0.5,0.125,-0.3125,0.5,0.3125}, --NodeBox2
			{-0.25,-0.5,-0.3125,0,0.5,-0.125}, --NodeBox3
		}
	},
})

minetest.register_node("bamboo:block",{
	description = "Bamboo block",
	tiles = {"bamboo_bottom.png", "bamboo_bottom.png", "bamboo_bamboo.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bamboo:block_h",{
	description = "Bamboo block",
	tiles = {
		"bamboo_bamboo.png", 
		"bamboo_bamboo.png", 
		"bamboo_bottom.png", 
		"bamboo_bottom.png", 
		"bamboo_bamboo.png", 
		"bamboo_bamboo.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2,wood=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0.5}, --NodeBox1
		}
	}
})

minetest.register_node("bamboo:slab_h",{
	description = "Bamboo slab",
	tiles = {
		"bamboo_bamboo.png", 
		"bamboo_bamboo.png", 
		"bamboo_bottom.png", 
		"bamboo_bottom.png", 
		"bamboo_bamboo.png", 
		"bamboo_bamboo.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.0,0.5}, --NodeBox1
		}
	}
})

minetest.register_node("bamboo:slab_v",{
	description = "Bamboo slab",
	tiles = {"bamboo_bottom.png", "bamboo_bottom.png", "bamboo_bamboo.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0}, --NodeBox1
		}
	}
})

minetest.register_craft({
	output = 'bamboo:block',
	recipe = {
		{'bamboo:bamboo', 'bamboo:bamboo', 'bamboo:bamboo'},
	}
})

minetest.register_craft({
	output = 'bamboo:block 2',
	recipe = {
		{'bamboo:block_h'},
		{''},
		{'bamboo:block_h'},
	}
})

minetest.register_craft({
	output = 'bamboo:block_h 2',
	recipe = {
		{'bamboo:block', '', 'bamboo:block'},
	}
})

minetest.register_craft({
	output = 'bamboo:slab_h 4',
	recipe = {
		{'bamboo:block', 'bamboo:block'},
	}
})

minetest.register_craft({
	output = 'bamboo:slab_v 4',
	recipe = {
		{'bamboo:block'},
		{'bamboo:block'},
	}
})

minetest.register_craft({
	output = 'bamboo:slab_v',
	recipe = {
		{'bamboo:slab_h'},
	}
})

minetest.register_craft({
	output = 'bamboo:slab_h',
	recipe = {
		{'bamboo:slab_v'},
	}
})

minetest.register_craft({
	output = 'bamboo:block',
	recipe = {
		{'bamboo:slab_h', 'bamboo:slab_h'},
	}
})

minetest.register_craft({
	output = 'bamboo:block',
	recipe = {
		{'bamboo:slab_v'},
		{'bamboo:slab_v'},
	}
})

minetest.register_abm({
	nodenames = {"bamboo:bamboo"},
	interval = 50,
	chance = 25,
	action = function(pos, node)
		if(minetest.get_node_light(pos) < 8) then
			return
		end
		local found_soil = false
		for py = -1, -6, -1 do
			local name = minetest.get_node({x=pos.x,y=pos.y+py,z=pos.z}).name
			if(minetest.get_item_group(name, "soil") ~= 0) then
				found_soil = true
				break
			elseif(name ~= "bamboo:bamboo") then
				break
			end
		end
		if (not found_soil) then
			return
		end
		for py = 1, 4 do
			local npos = {x=pos.x,y=pos.y+py,z=pos.z}
			local name = minetest.get_node(npos).name
			if(name == "air" or name == "default:water_flowing") then
				if(minetest.get_node_light(npos) < 8) then
					break
				end
				minetest.set_node(npos, {name="bamboo:bamboo"})
				break
			elseif(name ~= "bamboo:bamboo") then
				break
			end
		end
	end,
})