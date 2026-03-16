
----------------------------------------------
------------MOD CODE -------------------------


SMODS.Atlas{
    key = 'catjokers', --atlas key
    path = 'catjokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Atlas{
    key = 'catboosters', --atlas key
    path = 'catboosters.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Atlas{
    key = 'catdecks', --atlas key
    path = 'catdecks.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Atlas{
    key = "catpartner",
    px = 46,
    py = 58,
    path = "catpartner.png"
}

SMODS.Atlas({
	key = "modicon",
	path = "icon.png",
	px = 34,
	py = 34,
})

SMODS.ObjectType{
    key = "catjokers",
    default = 'j_funnycats_canny_cat',
    cards = {
        ['j_funnycats_canny_cat'] = true,
        ['j_funnycats_uncanny_cat'] = true,
        ['j_funnycats_dapper_cat'] = true,
        ['j_funnycats_glungus'] = true,
        ['j_funnycats_silly_cat'] = true,
        ['j_funnycats_ah_so_sorry'] = true,
        ['j_funnycats_tole_tole'] = true,
        ['j_funnycats_singing_cat'] = true,
        ['j_funnycats_long_cat'] = true,
        ['j_funnycats_larry'] = true,
        ['j_funnycats_floppa'] = true,
        ['j_funnycats_uni'] = true,
        ['j_funnycats_lollipop_cat'] = true,
        ['j_funnycats_chair'] = true,
        
        ['j_funnycats_ultra_glungus'] = true,
        ['j_funnycats_cat_astro'] = true,
        ['j_funnycats_glorpsto'] = true,
    },
    rarities = {
        {
            key = "Common",
            weight = 1
        },
        {
            key = 'Uncommon',
            weight = 0.7
        },
        {
            key = 'Rare',
            weight = 0.4
        },
        {
            key = 'Legendary',
            weight = 0.125
        },
    },
}

local mod_path = "" .. SMODS.current_mod.path
local scripts = NFS.getDirectoryItems(mod_path .. "scripts")
for _, script in ipairs(scripts) do
	print("[FUNNYCATS] Loading file " .. script)
	local f, err = SMODS.load_file("scripts/" .. script)
	if err then
		error(err)
	end
	f()
end -- file loader from cryptid, thanks! :3

-- OH ALSO BTW BTW this code might suck complete doo doo!! im a stinky baby when it comes to coding balatro mods
----------------------------------------------
------------MOD CODE END----------------------
