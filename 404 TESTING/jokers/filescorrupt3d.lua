
SMODS.Joker{ --file /s corrupt3d
    key = "filescorrupt3d",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'file /s corrupt3d',
        ['text'] = {
            [1] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = "test_404",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["test_test_jokers"] = true },
    
    set_ability = function(self, card, initial)
        card:set_eternal(true)
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    
                    assert(SMODS.change_base(scored_card, pseudorandom_element(SMODS.Suits, 'edit_card_suit').key, "2"))
                    scored_card:set_ability(G.P_CENTERS.c_base)
                    scored_card:set_seal(nil)
                    scored_card:set_edition(nil)
                    card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = "files corrupted", colour = G.C.ORANGE})
                    return true
                end
            }))
        end
    end
}