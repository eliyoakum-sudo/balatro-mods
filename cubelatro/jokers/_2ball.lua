
SMODS.Joker{ --2 Ball
    key = "_2ball",
    config = {
        extra = {
            levels0 = 1
        }
    },
    loc_txt = {
        ['name'] = '2 Ball',
        ['text'] = {
            [1] = '{C:attention}Upgrades{} a random {C:clubs}Hand Type{}',
            [2] = 'every time a {C:purple}Pair{} is {C:clubs}Scored{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
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
            if context.scoring_name == "Pair" then
                local available_hands = {}
                for hand, value in pairs(G.GAME.hands) do
                    if value.visible and value.level >= to_big(1) then
                        table.insert(available_hands, hand)
                    end
                end
                local target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed('level_up_hand')) or "High Card"
                level_up_hand(card, target_hand, true, 1)
                return {
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
}