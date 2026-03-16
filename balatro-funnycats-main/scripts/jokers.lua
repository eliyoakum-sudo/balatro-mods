
SMODS.Joker{
    key = 'canny_cat', --joker key
    loc_txt = { -- local text
        name = "Canny Cat",
        text = {
          '{C:chips}+#1#{} Chips'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 3, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 80,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.extra.chips
            }
        } --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                chips = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'uncanny_cat', --joker key
    loc_txt = { -- local text
        name = "Uncanny Cat",
        text = {
          '{C:mult}+#2#{} Mult',
          '{C:inactive}(Destroyed after {C:attention}#1#{C:inactive}/#3# Rounds){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 3, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 16, --configurable value
        uses = 0,
        uses_max = 4,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.uses,
            center.ability.extra.mult,
            center.ability.extra.uses_max
        }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if
            context.end_of_round 
        	and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
        then
            card.ability.extra.uses = card.ability.extra.uses + 1
            if card.ability.extra.uses + 1 <= card.ability.extra.uses_max then
                return{
                    message = {
                        localize{
                            type='variable',
                            key='a_remaining',
                            vars={(card.ability.extra.uses - card.ability.extra.uses_max) * -1}},
                            colour = G.C.FILTER, 
                            delay = 0.45
                    },
                    colour = G.C.FILTER,
                    card = card
                }
            else
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = "Uncanny!",
					colour = G.C.FILTER,
				}
			end
        end
        if context.joker_main then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = "+" .. card.ability.extra.mult .. " Mult",
                colour = G.C.MULT
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'dapper_cat', --joker key
    loc_txt = { -- local text
        name = "Dapper Cat",
        text = {
          '{C:mult}+#2#{} Mult when',
          'a hand is played',
          '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0, --configurable value
        mult_add = 2
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.mult,
            center.ability.extra.mult_add
        }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.before
        	and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
        then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_add
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.FILTER,
                card = card
            }
        end
        if context.joker_main then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = "+" .. card.ability.extra.mult .. " Mult",
                colour = G.C.MULT,
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'glungus', --joker key
    loc_txt = { -- local text
        name = "Glungus",
        text = {
          'Gains {X:chips,C:white}X#3#{} {C:chips}+Chips{}',
          'when {C:attention}Blind{} is selected',
          '{C:inactive}(Caps at {C:chips}+#2#{C:inactive} Chips)',
          '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 3, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 3, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 1, --configurable value
        limit = 512,
        chipsmult = 2,
        maxxed = 0
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.chips,
            center.ability.extra.limit,
            center.ability.extra.chipsmult,
        }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                chips = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
        if context.setting_blind then
            if card.ability.extra.chips + card.ability.extra.chips * card.ability.extra.chipsmult < card.ability.extra.limit then
                card.ability.extra.chips = card.ability.extra.chips * card.ability.extra.chipsmult
                card.ability.extra.maxxed = 0
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.FILTER,
                    card = card
                }
            else
                card.ability.extra.chips = card.ability.extra.limit
                if card.ability.extra.maxxed == 0 then
                   card.ability.extra.maxxed = 1
                    return {
                        message = "Max Silly!",
                        colour = G.C.FILTER,
                        card = card
                    }
                end
            end
                
                
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'silly_cat', --joker key
    loc_txt = { -- local text
        name = "Silly Cat",
        text = {
            '{C:green}#1# in #2#{} chance for',
            '{C:chips}+#4#{} Chips',
            '{C:green}#1# in #3#{} chance for',
            '{C:mult}+#5#{} Mult',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
        probabilities = {
            normal = 1,
        },
        extra = {
            chips = 250,
            mult = 25,
            m_chance = 2,
            c_chance = 2,
        }
    },
    give_mult = 0,
    give_chips = 0,
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
            G.GAME.probabilities.normal,
            center.ability.extra.m_chance,
            center.ability.extra.c_chance,
            center.ability.extra.chips,
            center.ability.extra.mult,
            }
        } --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            if pseudorandom('silly cat chips') < G.GAME.probabilities.normal/card.ability.extra.m_chance then
                card.give_mult = 1
            else
                card.give_mult = 0
            end
            if pseudorandom('silly cat mult') < G.GAME.probabilities.normal/card.ability.extra.c_chance then
                card.give_chips = 1
            else
                card.give_chips = 0
            end

            if card.give_chips == 1 and card.give_mult == 1 then
                return {
                    card = card,
                    chips = card.ability.extra.chips,
                    mult_mod = card.ability.extra.mult,
                    message = "+" .. card.ability.extra.mult .. " Mult",
                    colour = G.C.MULT
                }
            elseif card.give_chips == 1 then
                return {
                    card = card,
                    chips = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            elseif card.give_mult == 1 then
                return {
                    card = card,
                    mult_mod = card.ability.extra.mult,
                    message = "+" .. card.ability.extra.mult .. " Mult",
                    colour = G.C.MULT
                }
            end
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'ah_so_sorry', --joker key
    loc_txt = { -- local text
        name = "Ah! So Sorry!",
        text = {
          '{C:mult}+#2#{} Mult',
          '{C:inactive}(Activates after {C:attention}#1#{C:inactive}/#3# Hands){}'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 4, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 20, --configurable value
        uses = 0,
        uses_max = 5
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.uses,
            center.ability.extra.mult,
            center.ability.extra.uses_max}} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.before
        	and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
        then
            if card.ability.extra.uses < card.ability.extra.uses_max then
                card.ability.extra.uses = card.ability.extra.uses + 1
                if card.ability.extra.uses < card.ability.extra.uses_max then
                    return {
                        message = "Ah! So Sorry!",
                        colour = G.C.FILTER
                    }
                end
            end
        end
        if context.joker_main then
            if card.ability.extra.uses >= card.ability.extra.uses_max then
                return {
                    card = card,
                    mult_mod = card.ability.extra.mult,
                    message = "+" .. card.ability.extra.mult .. " Mult",
                    colour = G.C.MULT
                }
            end
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}

SMODS.Joker{
    key = 'tole_tole', --joker key
    loc_txt = { -- local text
        name = "Tole Tole",
        text = {
          '{C:dark_edition}+3{C:attention} Joker{} slots',
          '{C:inactive}(This joker still takes up a slot)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        slots = 3,
      }
    },
    loc_vars = function(self,info_queue,center)
        return {} --#1# is replaced with card.ability.extra.Xmult
    end,
    add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 3
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 3
	end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'singing_cat', --joker key
    loc_txt = { -- local text
        name = "Singing Cat",
        text = {
            'Gives {C:money}$#1#{}, increases payout by {C:money}$#3#{}',
            'after {C:attention}#4#{}/#2# Hands played',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        money = 1,
        hands_max = 4,
        hands_to_upgrade = 0,
        money_to_add = 1
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.money,
            center.ability.extra.hands_max,
            center.ability.extra.money_to_add,
            center.ability.extra.hands_to_upgrade,
        }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.before
        	and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
        then
            card.ability.extra.hands_to_upgrade = card.ability.extra.hands_to_upgrade + 1
            if card.ability.extra.hands_to_upgrade >= card.ability.extra.hands_max then
                card.ability.extra.hands_to_upgrade = 0
                card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_to_add
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.FILTER,
                    card = card
                }
            end
        end
        if context.joker_main then
            return {
                dollars = card.ability.extra.money,
                card = card
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'long_cat', --joker key
    loc_txt = { -- local text
        name = "Long Cat",
        text = {
          "Copies the ability",
          "of rightmost{C:attention} Joker{}"
        },
        --[[unlock = { 
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 2, y = 3 },
    cost = 10, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
      }
    },
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local compatible = G.jokers.cards[#G.jokers.cards] and G.jokers.cards[#G.jokers.cards] ~= card and
                G.jokers.cards[#G.jokers.cards].config.center.blueprint_compat
            local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        local ret = SMODS.blueprint_effect(card, G.jokers.cards[#G.jokers.cards], context)
        if ret then
            ret.colour = G.C.RED
        end
        return ret
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'larry', --joker key
    loc_txt = { -- local text
        name = "Larry",
        text = {
          '{C:chips}+#4#{} Chips and {C:mult}+#2#{} Mult',
          'when a {C:attention}Blind{} is defeated',
          '{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips and {C:mult}+#1#{C:inactive} Mult)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 3}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0, --configurable value
        mult_add = 4,
        chips = 0,
        chips_add = 15
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.mult,
            center.ability.extra.mult_add,
            center.ability.extra.chips,
            center.ability.extra.chips_add
        }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if
            context.end_of_round 
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
        then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_add
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_add
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.FILTER
            }
        end
        if context.joker_main then
            if card.ability.extra.chips ~= 0 and card.ability.extra.mult ~= 0 then
                return {
                    card = card,
                    chips = card.ability.extra.chips,
                    mult_mod = card.ability.extra.mult,
                    message = "+" .. card.ability.extra.mult .. " Mult",
                    colour = G.C.MULT,
                }
            end
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'floppa', --joker key
    loc_txt = { -- local text
        name = "Floppa",
        text = {
            '{C:green}#2# in #3#{} chance to increase',
            'hand size by {C:attention}+#4#{} when',
            'a {C:attention}Blind{} is defeated',
            '{C:inactive}(Currently {C:attention}+#1#{C:inactive} hand size){}',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 3}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
        probabilties = {
            normal = 1
        },
        extra = {
            handsize = 1,
            chance = 5,
            increase = 1,
        }
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.extra.handsize,
                G.GAME.probabilities.normal,
                center.ability.extra.chance,
                center.ability.extra.increase
            }
        } --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.handsize)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.handsize)
    end,
    calculate = function(self,card,context)
        if
            context.end_of_round 
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
        then
            if pseudorandom('floppa') < G.GAME.probabilities.normal/card.ability.extra.chance then
                card.ability.extra.handsize = card.ability.extra.handsize + card.ability.extra.increase
                G.hand:change_size(card.ability.extra.increase)
                return {
                    card = card,
                    message = localize('k_upgrade_ex'),
                    colour = G.C.FILTER
                }
            end
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'uni', --joker key
    loc_txt = { -- local text
        name = "Uni :3",
        text = {
          '{X:mult,C:white}X#1#{} Mult',
          'secondary ability {C:attention}Randomizes{}',
          'when a {C:attention}Blind{} is defeated',
          '{C:inactive}(Currently #5#)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 3, y = 3}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mode = -1,
        mult = 10,
        money = 5,
        chips = 300,
        Xmult = 1.5, --configurable value
        text = "",
      }
    },
    loc_vars = function(self,info_queue,center)
        if center.ability.extra.mode == -1 then
            center.ability.extra.text = 'uni_default_text'
        elseif center.ability.extra.mode == 0 then
            center.ability.extra.text = 'uni_chips_text'
        elseif center.ability.extra.mode == 1 then
            center.ability.extra.text = 'uni_mult_text'
        elseif center.ability.extra.mode == 2 then
            center.ability.extra.text = 'uni_money_text'
        end
        return {vars = {
            center.ability.extra.Xmult,
            center.ability.extra.chips,
            center.ability.extra.mult,
            center.ability.extra.money,
            },
            key = center.ability.extra.text
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.mode = math.floor((pseudorandom('uni :3') * 2) + 0.5)
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if
            context.end_of_round 
        	and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
        then
            card.ability.extra.mode = math.floor((pseudorandom('uni :3') * 2) + 0.5)
            return {
                message = 'Randomize!',
                colour = G.C.FILTER
            }
        end
        if context.joker_main then
            if card.ability.extra.mode == 0 then
                return {
                    card = card,
                    chips = card.ability.extra.chips,
                    Xmult_mod = card.ability.extra.Xmult,
                    message = 'X' .. card.ability.extra.Xmult .. ' Mult',
                    colour = G.C.MULT,
                }
            end
            if card.ability.extra.mode == 1 then
                return {
                    card = card,
                    mult = card.ability.extra.mult,
                    Xmult_mod = card.ability.extra.Xmult,
                    message = 'X' .. card.ability.extra.Xmult .. ' Mult',
                    colour = G.C.MULT,
                }
            end
            if card.ability.extra.mode == 2 then
                return {
                    card = card,
                    dollars = card.ability.extra.money,
                    Xmult_mod = card.ability.extra.Xmult,
                    message = 'X' .. card.ability.extra.Xmult .. ' Mult',
                    colour = G.C.MULT,
                }
            end
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'lollipop_cat', --joker key
    loc_txt = { -- local text
        name = "Lollipop Cat",
        text = {
          '{C:green}#1# in #2#{} Chance to give each',
          'scored {C:attention}Card{} a random {C:attention}Seal{}',
          'when a {C:attention}Hand{} is done scoring'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 6, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
        extra = {
            chance = 3,
        }
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                G.GAME.probabilities.normal,
                center.ability.extra.chance,
            }
        } --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.after 
			and not context.repetition
			and not context.retrigger_joker then
            local do_return = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if pseudorandom('lollipop_cat') < G.GAME.probabilities.normal/card.ability.extra.chance then
                    local seal = SMODS.poll_seal( {guaranteed = true, type_key = "lollipop_cat_seal"} )
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:set_seal(seal, false, true)
                            scored_card:juice_up()
                            return true
                        end
                    }))
                    do_return = 1
                end
            end
            if do_return == 1 then
                return {
                    message = "Blehh :P",
                    card = card,
                    colour = G.C.FILTER
                }
            end
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'chair', --joker key
    loc_txt = { -- local text
        name = "CHAIR!!!",
        text = {
            'Gains {X:mult,C:white}X#2#{} Mult if played',
            '{C:attention}Poker hand{} is a {C:attention}#3#{}',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 3, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 7, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 1,
        gain = 0.25,
        poker_hand = "Full House"
      }
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.extra.Xmult,
                center.ability.extra.gain,
                localize(center.ability.extra.poker_hand, 'poker_hands'),
            }
        } --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,

    calculate = function(self, card, context)
        if context.before
        and not context.repetition
        and not context.retrigger_joker
        and context.main_eval 
        and context.scoring_name == card.ability.extra.poker_hand then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.gain
            return {
                message = localize('k_upgrade_ex')
            }
        end
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult .. ' Mult',
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}

----------------------
-- Legendary jokers --
----------------------

SMODS.Joker{
    key = 'ultra_glungus', --joker key
    loc_txt = { -- local text
        name = "Ultra Glungus",
        text = {
          'Gains {X:chips,C:white}X#3#{} {C:chips}+Chips{}',
          'And {X:chips,C:white}X#4#{C:chips} +Chips{} Limit',
          'when {C:attention}Blind{} is selected',
          '{C:inactive}(Caps at {C:chips}+#2#{C:inactive} Chips)',
          '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 0, y = 2 },
    cost = 20, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        chips = 1, --configurable value
        limit = 1024,
        limit_mult = 1.1,
        maxxed = 0,
        chipsmult = 3
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.chips,
            center.ability.extra.limit,
            center.ability.extra.chipsmult,
            center.ability.extra.limit_mult
        }} --#1# is replaced with card.ability.extra.Xmult
    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                chips = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
        if context.setting_blind then
            card.ability.extra.limit = card.ability.extra.limit * card.ability.extra.limit_mult
            card.ability.extra.chips = card.ability.extra.chips * card.ability.extra.chipsmult
            if card.ability.extra.chips > card.ability.extra.limit then
                card.ability.extra.chips = card.ability.extra.limit
            end
            card.ability.extra.maxxed = 0
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.FILTER,
                card = card
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'cat_astro', --joker key
    loc_txt = { -- local text
        name = "Cat Astro",
        text = {
          'Gains {X:mult,C:white}X#2#{} Mult for every {C:attention}Joker{} card ',
          'you have when a hand is played',
          '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
          '{C:inactive}(Art by Astro){}',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 3, y = 2 },
    cost = 20, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 3, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
        extra = {
            Xmult = 1,
            Xmult_percard = 0.1
        }
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.extra.Xmult,
                center.ability.extra.Xmult_percard
            }
        }

    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.before 
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
        then
            local x = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then 
                    x = x + 1 
                end
            end
            card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.Xmult_percard * x)
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.FILTER,
                card = card
            }
        end
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult .. ' Mult',
                colour = G.C.MULT
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
SMODS.Joker{
    key = 'glorpsto', --joker key
    loc_txt = { -- local text
        name = "Glorpsto",
        text = {
          'Gains {C:chips}+#2#{} Chips for every {C:attention}Joker{} card ',
          'you have when a hand is played',
          '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips){}',
          '{C:inactive}(Art by Astro){}',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'catjokers', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 4, y = 2 },
    cost = 20, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = false, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 4, y = 1}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
        extra = {
            chips = 0,
            chipsgain = 80,
        }
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.extra.chips,
                center.ability.extra.chipsgain
            }
        }

    end,
    check_for_unlock = function(self, args)
        unlock_card(self) --unlocks the card if it isnt unlocked
    end,
    calculate = function(self,card,context)
        if context.before 
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
        then
            local x = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then 
                    x = x + 1 
                end
            end
            card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chipsgain * x)
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.FILTER,
                card = card
            }
        end
        if context.joker_main then
            return {
                card = card,
                chips = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end

    end,
    in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return true
    end,
}
