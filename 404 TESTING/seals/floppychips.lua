
SMODS.Seal {
    key = 'floppychips',
    pos = { x = 1, y = 0 },
    badge_colour = HEX('000000'),
    loc_txt = {
        name = 'floppy disk chips',
        label = 'floppy disk chips',
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
            assert(SMODS.change_base(card, nil, "14"))
            card:set_edition("foil", true)
            card:set_seal(nil)
            return {
                message = "Card Modified!",
                extra = {
                    message = "Card Modified!",
                    colour = G.C.BLUE,
                    extra = {
                        message = "chipified",
                        colour = G.C.BLUE
                    }
                }
            }
        end
    end
}