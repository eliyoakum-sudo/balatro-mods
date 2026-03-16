
SMODS.Seal {
    key = 'suspicioususb',
    pos = { x = 4, y = 0 },
    config = {
        extra = {
            dollars0 = 5,
            xchips0 = -5,
            xmult0 = -5
        }
    },
    badge_colour = HEX('000000'),
    loc_txt = {
        name = 'suspicious USB',
        label = 'suspicious USB',
        text = {
            [1] = 'USB but doesn\'t remove itself',
            [2] = '',
            [3] = '-that guy you met in an alleyway'
        }
    },
    atlas = 'CustomSeals',
    unlocked = true,
    discovered = true,
    no_collection = false,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars / 5
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "X5 $", colour = G.C.MONEY})
                    return true
                end,
                extra = {
                    x_chips = -5,
                    message = "x5 chips",
                    colour = G.C.DARK_EDITION,
                    extra = {
                        Xmult = -5,
                        message = "x5 chips"
                    }
                }
            }
        end
    end
}