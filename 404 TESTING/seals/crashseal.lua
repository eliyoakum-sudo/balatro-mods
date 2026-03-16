
SMODS.Seal {
    key = 'crashseal',
    pos = { x = 0, y = 0 },
    badge_colour = HEX('000000'),
    loc_txt = {
        name = ':(  A critical error has occurred. Test environment has become unstable. Please restart the program.',
            label = ':(  A critical error has occurred. Test environment has become unstable. Please restart the program.',
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
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("modem")
                            
                            return true
                        end,
                    }))
                    SMODS.calculate_effect({balance = true}, card)
                    return {
                        swap = true
                    }
                end
            end
        }