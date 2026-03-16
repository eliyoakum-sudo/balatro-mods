
SMODS.Seal {
    key = 'usb',
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            dollars0 = 5,
            xchips0 = 5,
            xmult0 = 5
        }
    },
    badge_colour = HEX('000000'),
    loc_txt = {
        name = 'USB',
        label = 'USB',
        text = {
            [1] = ''
        }
    },
    atlas = 'CustomSeals',
    unlocked = true,
    discovered = true,
    no_collection = false,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            card:set_seal(nil)
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars * 5
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "X"..tostring(5), colour = G.C.MONEY})
                    return true
                end,
                extra = {
                    x_chips = 5,
                    colour = G.C.DARK_EDITION,
                    extra = {
                        Xmult = 5,
                        extra = {
                            message = "windows defender has blocked this possibly malicious code",
                            colour = G.C.BLUE
                        }
                    }
                }
            }
        end
    end
}