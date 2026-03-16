
SMODS.Joker{ --5 Ball
    key = "_5ball",
    config = {
        extra = {
            xmult0 = 5,
            xmult = 5
        }
    },
    loc_txt = {
        ['name'] = '5 Ball',
        ['text'] = {
            [1] = '{C:attention}Flush Fives{} or',
            [2] = '{C:attention}5 of a Kinds{} Get {C:red}x5 Mult{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cueblatr_cueblatr_jokers"] = true, ["cueblatr_pool_ball"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' 
            or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if context.scoring_name == "Flush Five" then
                return {
                    Xmult = 5
                }
            elseif context.scoring_name == "Five of a Kind" then
                return {
                    Xmult = 5
                }
            end
        end
    end
}