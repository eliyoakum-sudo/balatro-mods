-- Adds Scientist joker to the title screen
SMODS.current_mod.menu_cards = function()
    return { -- This takes any SMODS.create_card parameters
        key = "j_SM_Scientist",
        remove_original = false -- This removes the vanilla Ace
    }
end