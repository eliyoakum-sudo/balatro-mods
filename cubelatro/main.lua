SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomBoosters", 
    path = "CustomBoosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local jokerIndexList = {7,8,9,10,12,13,14,15,1,2,3,4,5,6,11}

local function load_jokers_folder()
    local mod_path = SMODS.current_mod.path
    local jokers_path = mod_path .. "/jokers"
    local files = NFS.getDirectoryItemsInfo(jokers_path)
    for i = 1, #jokerIndexList do
        local file_name = files[jokerIndexList[i]].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("jokers/" .. file_name))()
        end
    end
end


local function load_boosters_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("boosters.lua"))()
end

load_boosters_file()
load_jokers_folder()
SMODS.ObjectType({
    key = "cueblatr_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true
    },
})

SMODS.ObjectType({
    key = "cueblatr_cueblatr_jokers",
    cards = {
        ["j_cueblatr__10ball"] = true,
        ["j_cueblatr__11ball"] = true,
        ["j_cueblatr__12ball"] = true,
        ["j_cueblatr__13ball"] = true,
        ["j_cueblatr__14ball"] = true,
        ["j_cueblatr__15ball"] = true,
        ["j_cueblatr__1ball"] = true,
        ["j_cueblatr__2ball"] = true,
        ["j_cueblatr__3ball"] = true,
        ["j_cueblatr__4ball"] = true,
        ["j_cueblatr__57ball"] = true,
        ["j_cueblatr__5ball"] = true,
        ["j_cueblatr__6ball"] = true,
        ["j_cueblatr__7ball"] = true,
        ["j_cueblatr__9ball"] = true
    },
})

SMODS.ObjectType({
    key = "cueblatr_pool_ball",
    cards = {
        ["j_cueblatr__1ball"] = true,
        ["j_cueblatr__2ball"] = true,
        ["j_cueblatr__3ball"] = true,
        ["j_cueblatr__4ball"] = true,
        ["j_cueblatr__5ball"] = true,
        ["j_cueblatr__6ball"] = true,
        ["j_cueblatr__7ball"] = true
    },
})


SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end