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

SMODS.Atlas({
    key = "CustomDecks", 
    path = "CustomDecks.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local jokerIndexList = {14,10,3,2,16,17,13,11,8,9,4,6,5,7,12,1,15}

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


local deckIndexList = {1}

local function load_decks_folder()
    local mod_path = SMODS.current_mod.path
    local decks_path = mod_path .. "/decks"
    local files = NFS.getDirectoryItemsInfo(decks_path)
    for i = 1, #deckIndexList do
        local file_name = files[deckIndexList[i]].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("decks/" .. file_name))()
        end
    end
end

local function load_rarities_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("rarities.lua"))()
end

load_rarities_file()

local function load_boosters_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("boosters.lua"))()
end

load_boosters_file()
load_jokers_folder()
load_decks_folder()
SMODS.ObjectType({
    key = "braysjokers_food",
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
    key = "braysjokers_braysjokerswip_jokers",
    cards = {
        ["j_braysjokers_bankingjoker"] = true,
        ["j_braysjokers_petroglyphjoker"] = true
    },
})

SMODS.ObjectType({
    key = "braysjokers_braysjokers_jokers",
    cards = {
        ["j_braysjokers_billionarejoker"] = true,
        ["j_braysjokers_cardiacjoker"] = true,
        ["j_braysjokers_crashjoker"] = true,
        ["j_braysjokers_electrochad"] = true,
        ["j_braysjokers_epicjoker"] = true,
        ["j_braysjokers_frozenjoker"] = true,
        ["j_braysjokers_hiddenjoker"] = true,
        ["j_braysjokers_lazyjoker"] = true,
        ["j_braysjokers_madnoobjoker"] = true,
        ["j_braysjokers_moltenjoker"] = true,
        ["j_braysjokers_noobjoker"] = true,
        ["j_braysjokers_shiftyjoker"] = true,
        ["j_braysjokers_wildfirejoker"] = true
    },
})

SMODS.ObjectType({
    key = "braysjokers_braysjokers_secretjokers",
    cards = {
        ["j_braysjokers_johnreroll"] = true,
        ["j_braysjokers_orangejoker"] = true
    },
})


SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end