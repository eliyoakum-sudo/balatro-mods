local atlas_key = 'pvz_atlas' -- Format: PREFIX_KEY
local atlas_path = 'pvz_lc.png' -- Filename for the image in the asset folder
local atlas_path_hc = 'pvz_hc.png' -- Filename for the high-contrast version of the texture, if existing

local suits = {'hearts', 'clubs', 'diamonds', 'spades'} -- Which suits to replace
local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace",} -- Which ranks to replace

local description = 'Plants vs. Zombies' -- English-language description, also used as default

-- Config
pvz_config = SMODS.current_mod.config

-- UI
local UI, load_error = SMODS.load_file("ui.lua")
if load_error then
  sendDebugMessage ("The error is: "..load_error)
else
  UI()
end

-- Quips
if pvz_config.pvzquips then
    SMODS.load_file("quips.lua")()
else
end

-- Consumables
if pvz_config.pvzconsumables then
    SMODS.load_file("consumables.lua")()
	SMODS.load_file("boosters.lua")()
else
end

-- UI Suits

if pvz_config.pvzshopsign then -- Check if Shop Sign on.
	SMODS.Atlas{
		key = 'shop_sign',
		atlas_table = 'ANIMATION_ATLAS',
		px = 113,
		py = 57,
		path = "pvz_store_sign.png",
		prefix_config = {key = false},
		frames = 4,
	}
else
end

-- Jokers
SMODS.Atlas{  
        key = 'pvz_jokers',
        px = 71,
        py = 95,
        path = "pvz_jokers.png",
    }
assert(SMODS.load_file("jokers.lua"))() -- Testing
-- SMODS.load_file("jokers.lua")()

-- Modicon
SMODS.Atlas {
  key = 'modicon',
  px = 32,
  py = 32,
  path = 'modicon.png'
}

-- Deck
SMODS.Atlas{  
    key = atlas_key..'_lc',
    px = 71,
    py = 95,
    path = atlas_path,
    prefix_config = {key = false},
}

if atlas_path_hc then
    SMODS.Atlas{  
        key = atlas_key..'_hc',
        px = 71,
        py = 95,
        path = atlas_path_hc,
        prefix_config = {key = false},
    }
end

for _, suit in ipairs(suits) do
    SMODS.DeckSkin{
        key = suit.."_skin",
        suit = suit:gsub("^%l", string.upper),
        ranks = ranks,
        lc_atlas = atlas_key..'_lc',
        hc_atlas = (atlas_path_hc and atlas_key..'_hc') or atlas_key..'_lc',
        loc_txt = {
            ['en-us'] = description
        },
        posStyle = 'deck'
    }
end