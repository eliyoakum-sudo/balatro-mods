
SMODS.Joker{ --Mad Noob Joker
    key = "madnoobjoker",
    config = {
        extra = {
            xmult0 = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Mad Noob Joker',
        ['text'] = {
            [1] = 'Gives {C:red}1.5x Mult{} for each',
            [2] = 'card played in hand.'
        },
        ['unlock'] = {
            [1] = 'Comes with Noob Joker.'
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
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokers_jokers"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rta' and args.source ~= 'wra' 
            or args.source == 'rif' or args.source == 'sou' or args.source == 'uta'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            return {
                Xmult = 1.5
            }
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "chip_score" then
            local count = 0
            return args.chips >= to_big(100000)
        end
        return false
    end
}