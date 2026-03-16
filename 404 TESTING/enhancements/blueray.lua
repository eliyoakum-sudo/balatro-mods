
SMODS.Enhancement {
    key = 'blueray',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            dollars0 = 5
        }
    },
    loc_txt = {
        name = 'blueray',
        text = {
            [1] = ''
        }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 5,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars + 5
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+"..tostring(5), colour = G.C.MONEY})
                    return true
                end
            }
        end
    end
}