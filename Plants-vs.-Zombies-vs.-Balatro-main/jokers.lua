-- Crazy Dave
SMODS.Joker {
	key = 'crazy_dave',
	-- no_collection = true,
	in_pool = function(self) return false end,
	blueprint_compat = true,
	atlas = 'pvz_jokers',
	pos = { x = 0, y = 0 },
	cost = 4,
	rarity = 1,
	blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
	-- Logic Goes Here
	config = {
        extra = {
            Tarot = 0
        }
    },
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Tarot', key = nil, key_append = 'joker_forge_tarot'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                    return true
                end
                }
        end
    end
}
SMODS.Joker {
	key = 'zombie',
	-- no_collection = true,
	in_pool = function(self) return false end,
	blueprint_compat = true,
	atlas = 'pvz_jokers',
	pos = { x = 1, y = 0 },
	rarity = 1,
	-- Logic Goes Here
	config = {
        extra = {
            repetitions = 1
        }
    },
	calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if (context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 4 or context.other_card:get_id() == 5 or context.other_card:get_id() == 6 or context.other_card:get_id() == 7 or context.other_card:get_id() == 8) then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}