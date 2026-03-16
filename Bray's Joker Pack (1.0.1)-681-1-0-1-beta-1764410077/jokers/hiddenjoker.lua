
SMODS.Joker{ --Hidden Joker
    key = "hiddenjoker",
    config = {
        extra = {
            hiddenrounds = 5
        }
    },
    loc_txt = {
        ['name'] = 'Hidden Joker',
        ['text'] = {
            [1] = 'Disables all {C:enhanced}Boss Blinds,{}',
            [2] = 'But hides all Jokers.'
        },
        ['unlock'] = {
            [1] = 'Sell 10 Jokers.'
        }
    },
    pos = {
        x = 8,
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.hiddenrounds}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            if #G.jokers.cards > 0 then
                for _, joker in ipairs(G.jokers.cards) do
                    joker:flip()
                end
            end
            return {
                func = function()
                    if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.blind:disable()
                                play_sound('timpani')
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled'), colour = G.C.GREEN})
                    end
                    return true
                end,
                extra = {
                    message = "Flip!",
                    colour = G.C.ORANGE
                }
            }
        end
    end,
    check_for_unlock = function(self,args)
        if args.type == "career_stat" then
            local count = 0
            return G.PROFILES[G.SETTINGS.profile].career_stats.c_jokers_sold == to_big(10)
        end
        return false
    end
}