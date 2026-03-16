
SMODS.Joker{ --4 Ball
    key = "_4ball",
    config = {
        extra = {
            mult0 = 4,
            mult = 4
        }
    },
    loc_txt = {
        ['name'] = '4 Ball',
        ['text'] = {
            [1] = '{C:attention}2 Pairs and 4 of a Kinds{} get',
            [2] = '{C:red}+4{} Mult per {C:attention}Card Scored{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
        if context.individual and context.cardarea == G.play  then
            if context.scoring_name == "Two Pair" then
                return {
                    mult = 4
                }
            elseif context.scoring_name == "Four of a Kind" then
                return {
                    mult = 4
                }
            end
        end
    end
}