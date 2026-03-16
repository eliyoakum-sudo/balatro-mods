
SMODS.Joker{ --11 Ball
    key = "_11ball",
    config = {
        extra = {
            time_until_death = 11,
            xmult0 = 11
        }
    },
    loc_txt = {
        ['name'] = '11 Ball',
        ['text'] = {
            [1] = 'Dies after {C:clubs}11 Hands{}, {X:red,C:white}X11{} Mult',
            [2] = 'on the {C:attention}10th turn{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cueblatr_cueblatr_jokers"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' 
            or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.time_until_death}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big((card.ability.extra.time_until_death or 0)) == to_big(10) then
                return {
                    Xmult = 11
                }
            else
                card.ability.extra.time_until_death = math.max(0, (card.ability.extra.time_until_death) - 1)
            end
        end
        if context.after and context.cardarea == G.jokers  then
            if to_big((card.ability.extra.time_until_death or 0)) == to_big(0) then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            if target_joker.ability.eternal then
                                target_joker.ability.eternal = nil
                            end
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:explode({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end
                }
            end
        end
    end
}