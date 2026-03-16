
SMODS.Enhancement {
    key = 'colortestingcredcgreencblue',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            xchips0 = 5,
            xmult0 = 3
        }
    },
    loc_txt = {
        name = 'color testing {C:red}{} {C:green}{} {C:blue}{}',
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
                x_chips = 5,
                extra = {
                    Xmult = 3
                }
            }
        end
    end
}