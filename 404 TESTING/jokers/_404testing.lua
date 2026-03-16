
SMODS.Joker{ --404 TESTING
    key = "_404testing",
    config = {
        extra = {
            chips0 = 404,
            xmult0 = 7357
        }
    },
    loc_txt = {
        ['name'] = '404 TESTING',
        ['text'] = {
            [1] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
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
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            return {
                chips = 404,
                message = "404",
                extra = {
                    Xmult = 7357,
                    message = "TESTING"
                }
            }
        end
    end
}