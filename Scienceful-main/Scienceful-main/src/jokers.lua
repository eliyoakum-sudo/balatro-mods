---Scientist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Scientist',
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 0, y = 0},
    config = { extra = { chips = 0, mult = 0, chip_mod = 3, mult_mod = 2 } },

    loc_vars = function(self, info_queue, card)
        return{vars = {card.ability.extra.chip_mod, card.ability.extra.mult_mod, card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.prev_hand}}
    end,
    --Joker checks if the current poker hand name played is different than the previous one
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            card.ability.extra.prev_hand = card.ability.extra.prev_hand or ""
            local isnotsame = false
            if context.scoring_name ~= card.ability.extra.prev_hand then
                isnotsame = true
            end
            card.ability.extra.prev_hand = context.scoring_name
            local passed = false
            if isnotsame then
                passed = true
            end
            if passed then
                -- gain chips OR +mult
                local randomVar = pseudorandom('SM_seed', 1, 10)
                if randomVar <= 5 then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                    return {
                        message = localize('k_SM_upgrade_chips'),
                        colour = G.C.BLUE
                    }
                else
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                    return {
                        message = localize('k_SM_upgrade_mult'),
                        colour = G.C.RED
                    }
                end
            else
                -- resets
                card.ability.extra.chips = 0
                card.ability.extra.mult = 0
                card.ability.extra.prev_hand = nil
                return{
                    message = localize('k_reset'),
                    sound = 'tarot1',
                    pitch = 1,
                    colour = G.C.attention
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}

---Chemist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Chemist',
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 1, y = 0},
    config = { extra = { chips = 0 } },

    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.chips }}
    end,
    
    --Joker checks if the current poker hand has at least 2 cards with different suits
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {}
            local passed = false
                for i,v in ipairs(context.scoring_hand) do
                    if #context.scoring_hand >= 2 then
                        if i >= 2 then
                            local unique_suit = true
                            for suit,_ in pairs(suits) do
                                if v:is_suit(suit) then unique_suit = false;
                                break end
                                if unique_suit then passed = true;
                                break end

                            end
                        end
                        if not suits[v.base.suit] then suits[v.base.suit] = true end
                    end
                end
            if passed then
                ---Give normal a random amount of chips
                card.ability.extra.chips = pseudorandom('SM_seed', -10, 90)
                return {
                chips = card.ability.extra.chips
                }
            else
                return{
                    message = localize('k_nope_ex'),
                    sound = 'tarot2',
                    pitch = 1,
                    colour = G.C.BLACK
                }
            end
        end
    end
}

---Physicist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Physicist',
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 2, y = 0},
    config = { extra = { xchips = 1.3, chip_mod = 0.01 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.xchips, card.ability.extra.chip_mod }}
    end,

    ---Joker gives amount of Xchips for every scored card, decreases Xchips value for every card discarded, resets after played hand
    calculate = function(self, card, context)
        if context.after and context.main_eval and not context.blueprint then
            card.ability.extra.xchips = 1.3
            return {
            message = localize('k_SM_recharge'),
            colour = G.C.attention
            }
        end
        if context.discard and not context.blueprint then
            card.ability.extra.xchips = card.ability.extra.xchips - card.ability.extra.chip_mod
            if card.ability.extra.xchips < 1 then
                card.ability.extra.xchips = 1
            end
            return {
                message = '-'..card.ability.extra.chip_mod,
                colour = G.C.RED
            }
        end
        if context.individual and context.cardarea == G.play and context.scoring_hand then
            return {
                --Gives Xchipsmult for every card scored
                xchips = card.ability.extra.xchips
            }
        end
    end
}

---Toxicologist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Toxicologist',
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 3, y = 0},
    config = { extra = { mult = 15, mult_mod = 30 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.mult, card.ability.extra.mult_mod }}
    end,
    --joker checks if at the final hand of the round there are any jokers to its sides to destroy them and give +30 for every joker destroyed
    --resets at the end of the round
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.mult > 15 then
                card.ability.extra.mult = 15
                return {
                    message = localize('k_reset'),
                    colour = G.C.attention,
                }
            end
        end
        if G.GAME.current_round.hands_left == 0 and context.before and context.main_eval then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].ability.eternal and not G.jokers.cards[my_pos + 1].getting_sliced or G.jokers.cards[my_pos - 1] and not G.jokers.cards[my_pos - 1].ability.eternal and not G.jokers.cards[my_pos - 1].getting_sliced then
                local sliced_card1 = G.jokers.cards[my_pos + 1]
                local sliced_card2 = G.jokers.cards[my_pos - 1]
                if sliced_card1 ~= nil then
                    sliced_card1.getting_sliced = true -- Make sure to do this on destruction effects
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                end
                if sliced_card2 ~= nil then
                    sliced_card2.getting_sliced = true
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        if sliced_card1 then
                            sliced_card1:start_dissolve({ G.C.GREEN }, nil, 1.6)
                        end
                        if sliced_card2 then
                            sliced_card2:start_dissolve({ G.C.GREEN }, nil, 1.6)
                        end
                        return true
                        end
                        }))
                return {
                    message = localize('k_SM_radiations'),
                    colour = G.C.GREEN,
                    no_juice = true
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

---Marine Biologist joker
SMODS.Joker {
    ---joker's name and info
    key = 'MarineBiologist',
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 4, y = 0},
    config = { extra = { mult = 2, chips = 15 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.mult, card.ability.extra.chips }}
    end,
    ---Joker checks if the scoring cards rank's are above or lower than 6 in order to give chips or mult
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() <= 6 then
                return {
                    mult = card.ability.extra.mult
                }
            else
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

---Mathematician joker
SMODS.Joker {
    ---joker's name and info
    key = 'Mathematician',
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 5, y = 0},
    config = { extra = { mult = 2 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.mult }}
    end,
    ---Joker checks if the scoring card is not a face card and then makes it gain +2 Mult
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.other_card:is_face() and context.other_card:get_id() ~= 14 then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
    end
}

---Geometer joker
SMODS.Joker {
    ---joker's name and info
    key = 'Geometer',
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 6, y = 0},
    config = { extra = { Xchips = 1.5, Xmult = 1.3 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.Xchips, card.ability.extra.Xmult}}
    end,
    ---Joker checks if the scoring hand contains hearts/diamonds or spades/clubs and gives Xmult or Xchips
    calculate = function(self, card, context)

        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds") then
                return {
                    xmult = card.ability.extra.Xmult
                }
            elseif context.other_card:is_suit("Spades") or context.other_card:is_suit("Clubs")  then
                return {
                    xchips = card.ability.extra.Xchips
                }
            end
        end
    end
}

---Archaeologist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Archaeologist',
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 7, y = 0},
    config = { extra = { creates = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'SM_previously_owned', set = 'Other' }
        return{vars = { card.ability.extra.creates }}
    end,
    ---Joker checks if there's space in the joker slots and if so, creates a joker you previously sold or destroyed after the boss blind has been defeated
    calculate = function(self, card, context)
        
        local old_card_start_dissolve = Card.start_dissolve
        function Card:start_dissolve()
            --Do stuff here
            if self.ability.set == "Joker" then
                if not G.GAME.SM_previous_jokers then
                    G.GAME.SM_previous_jokers = {}
                end
                table.insert(G.GAME.SM_previous_jokers, self.config.center.key)
            end
            old_card_start_dissolve(self)
            --Or here
        end

        if G.GAME.SM_previous_jokers ~= nil then
            if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    local jokers_to_create = math.min(card.ability.extra.creates, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                    G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            for _ = 1, jokers_to_create do
                                SMODS.add_card {
                                    key = pseudorandom_element(G.GAME.SM_previous_jokers, 'SM_seed')
                                }
                                G.GAME.joker_buffer = 0
                            end
                            return true
                        end
                    }))
                    return {
                        message = localize('k_plus_joker'),
                        colour = G.C.BLUE,
                    }
            end
        end
    end 
}

---Paleontologist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Paleontologist',
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 8, y = 0},
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SM_Paleontologist')
        return{vars = { numerator, denominator }}
    end,
    ---Joker checks for if a stone card is played and each one played has a 1 in 4 chance to create a tarot card
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.has_enhancement(context.other_card, "m_stone") and SMODS.pseudorandom_probability(card, 'SM_Paleontologist', 1, card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {
                        message = localize('k_plus_tarot'),
                        message_card = card,
                        func = function() -- This is for timing purposes, everything here runs after the message
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card {
                                        set = 'Tarot'
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    },
                }
            end
        end
    end 
}

---Zoologist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Zoologist',
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 9, y = 0},
    config = { extra = { dollars = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return{vars = { card.ability.extra.dollars }}
    end,
    ---Joker checks for if a wild card is played and each one played gives 2$
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_wild") then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
            end
        end
    end 
}

---Anatomist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Anatomist',
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 0, y = 1},
    config = { extra = { mult = 0, mult_mod = 5 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.mult, card.ability.extra.mult_mod }}
    end,
    ---Joker checks for if a face card with heart suit is played, if so gains +5 Mult
    calculate = function(self, card, context)

        if context.individual and context.cardarea == G.play and context.other_card:is_face() and context.other_card:is_suit("Hearts") and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end

    end 
}

---Botanist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Botanist',
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 1, y = 1},
    config = { extra = { chips = 15, mult = 5 } },
    loc_vars = function(self, info_queue, card)

        info_queue[#info_queue + 1] = G.P_CENTERS.m_SM_bloom_card
        info_queue[#info_queue + 1] = { key = 'SM_secun', set = 'Other' }

        local bloom_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_SM_bloom_card') then bloom_tally = bloom_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.chips * bloom_tally, card.ability.extra.mult * bloom_tally } }
    end,
    ---Joker checks for if a card with the Bloom Enhancement is in the full deck, if so gives chips and mult
    calculate = function(self, card, context)
        if context.joker_main then
            local bloom_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_SM_bloom_card') then bloom_tally = bloom_tally + 1 end
            end
            return {
                chips = card.ability.extra.chips * bloom_tally,
                mult = card.ability.extra.mult * bloom_tally
            }
        end
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_stone'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_SM_bloom_card') then
                return true
            end
        end
        return false
    end
}

---Computer Scientist joker
SMODS.Joker {
    ---joker's name and info
    key = 'ComputerScientist',
    blueprint_compat = false,
    rarity = 3,
    cost = 8,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 2, y = 1},
    config = { extra = { reduce = 0.2, counter = 0 } },
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.reduce > 1 then card.ability.extra.reduce = 0.2 end -- catch.
        return { vars = { card.ability.extra.reduce } }
    end,
    ---Joker checks for if the first discard of the round has only 2 cards, reduce the current blind's requirement by 20%
    calculate = function(self, card, context)
        if card.ability.extra.reduce > 1 then card.ability.extra.reduce = 0.2 end -- catch.
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.discard and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 2 then
            
            card.ability.extra.counter = card.ability.extra.counter + 1 
            
            if card.ability.extra.counter == 2 then
                G.E_MANAGER:add_event(Event({func = function()
				G.GAME.blind.chips = math.floor(G.GAME.blind.chips-(G.GAME.blind.chips*card.ability.extra.reduce))
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
				G.HUD_blind:recalculate()
				G.hand_text_area.blind_chips:juice_up()
				card:juice_up()
                return true end }))
                card.ability.extra.counter = 0
                return {
                    nil, 
                    true,
                    message = localize('k_SM_debuff'),
                    sound = 'SM_HackedComputer_sfx',
                    pitch = 1,
                    colour = G.C.DARK_EDITION
                }
            end
        end

    end,
}

---Meteorologist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Meteorologist',
    blueprint_compat = false,
    rarity = 2,
    cost = 5,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 3, y = 1},
    config = { extra = {} },
    ---Joker reveals the next 5 cards that will be drawn
    loc_vars = function(self, info_queue, card)
        local main_end = nil
        if card.area and (card.area == G.jokers) then
            main_end = {
                {
                    n = G.UIT.R,
                    config = { align = "bm", minh = 0.4, colour = G.C.CLEAR},
                    nodes = {
                        G.deck.cards[1] and {n = G.UIT.O, config = {align = "cm", object = Card(0,0, 0.5*G.CARD_W, 0.5 *G.CARD_H, G.P_CARDS[G.deck.cards[#G.
                        deck.cards - 0].config.card_key], G.P_CENTERS[G.deck.cards[1].config.center_key])}} or nil,
                        G.deck.cards[2] and {n = G.UIT.O, config = {align = "cm", object = Card(0,0, 0.5*G.CARD_W, 0.5 *G.CARD_H, G.P_CARDS[G.deck.cards[#G.
                        deck.cards - 1].config.card_key], G.P_CENTERS[G.deck.cards[2].config.center_key])}} or nil,
                        G.deck.cards[3] and {n = G.UIT.O, config = {align = "cm", object = Card(0,0, 0.5*G.CARD_W, 0.5 *G.CARD_H, G.P_CARDS[G.deck.cards[#G.
                        deck.cards - 2].config.card_key], G.P_CENTERS[G.deck.cards[3].config.center_key])}} or nil,
                        G.deck.cards[4] and {n = G.UIT.O, config = {align = "cm", object = Card(0,0, 0.5*G.CARD_W, 0.5 *G.CARD_H, G.P_CARDS[G.deck.cards[#G.
                        deck.cards - 3].config.card_key], G.P_CENTERS[G.deck.cards[4].config.center_key])}} or nil,
                        G.deck.cards[5] and {n = G.UIT.O, config = {align = "cm", object = Card(0,0, 0.5*G.CARD_W, 0.5 *G.CARD_H, G.P_CARDS[G.deck.cards[#G.
                        deck.cards - 4].config.card_key],G.P_CENTERS[G.deck.cards[5].config.center_key])}} or nil,

                    }
                }
            }
        end
        return { main_end = main_end }
    end,
}

---Geologist joker
SMODS.Joker {
    ---joker's name and info
    key = 'Geologist',
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 4, y = 1},
    config = { extra = { repetitions = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return{vars = { card.ability.extra.repetitions }}
    end,
    ---Joker checks for if a stone card is played, if so retriggers it
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_stone") then
                 return {
                    repetitions = card.ability.extra.repetitions
                } 
            end
        end
    end 
}

---Assistant joker
SMODS.Joker {
    ---joker's name and info
    key = 'Assistant',
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 5, y = 1},
    config = { extra = { consumable_slot = 2 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.consumable_slot }}
    end,
    ---Joker gives +2 consumables slot
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumable_slot
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumable_slot
    end
}

---First law of inertia joker
SMODS.Joker {
    ---joker's name and info
    key = 'FirstLawOfInertia',
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 6, y = 1},
    config = { extra = { Xmult = 1, Xmult_mod = 0.1 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod }}
    end,

    ---Joker gains 0.1 Xmult per hand played, -0.1 Xmult per discard
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and context.other_card == context.full_hand[#context.full_hand] then
            if (card.ability.extra.Xmult ~= 1) then
                card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_mod
                return {
                    message = "-"..card.ability.extra.Xmult_mod,
                    colour = G.C.RED
                }
            end
        end
        if context.before and context.main_eval and not context.blueprint then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
            return {
                message = "+"..card.ability.extra.Xmult_mod,
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

---Discovery channel joker
SMODS.Joker {
    ---joker's name and info
    key = 'DiscoveryChannel',
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 7, y = 1},
    config = { extra = { chips = 30 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.chips, card.ability.extra.chips * (G.jokers and #G.jokers.cards or 0) }}
    end,

    ---Joker gives +30 Chips for each joker card
    calculate = function(self, card, context)
        if context.joker_main then
            local joker_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    joker_count = joker_count + 1 end
                end
            return {
                chips = card.ability.extra.chips * joker_count
            }
        end
    end
}

---Access Card joker
SMODS.Joker {
    ---joker's name and info
    key = 'AccessCard',
    blueprint_compat = false,
    rarity = 2,
    cost = 5,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 8, y = 1},
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return{vars = { }}
    end,
    ---Joker creates a random tag at the end of the round
    calculate = function(self, card, context)
        if context.end_of_round and not context.other_card then
            
            local tag_pool = get_current_pool('Tag')

            --local tag_pool = {'tag_uncommon', 'tag_rare', 'tag_double'} custom pool example
            
            local selected_tag = pseudorandom_element(tag_pool, 'SM_seed')
            local it = 1
            while selected_tag == 'UNAVAILABLE' do
                it = it + 1
                selected_tag = pseudorandom_element(tag_pool, 'SM_seed_resample'..it)
            end
            add_tag(Tag(selected_tag, false, 'Small'))
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    play_sound('generic1', 1, 0.4)
                    card:juice_up(0.4, 0.5)
                    return true
                end
            }))
            return true
        end
    end
}

---Concentric joker
SMODS.Joker {
    ---joker's name and info
    key = 'Concentric',
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 0, y = 2},
    config = { extra = { mult = 4, odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SM_Concentric')
        return{vars = { card.ability.extra.mult, card.ability.extra.mult * (G.jokers and #SMODS.Edition:get_edition_cards(G.jokers) or 0), numerator, denominator }}
    end,
    ---Joker gives +4 mult for each joker with an edition, after beating a boss blind 1 in a 3 chance to apply a random edition to a random joker
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and G.GAME.blind.boss and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'SM_Concentric', 1, card.ability.extra.odds) then
                local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
                
                local eligible_card = pseudorandom_element(editionless_jokers, pseudoseed("seed"))
                local edition = poll_edition('wheel_of_fortune', nil, false, true, { 'e_negative', 'e_polychrome', 'e_holo', 'e_foil', 'e_SM_definitive' })
                if eligible_card ~= nil then
                    eligible_card:set_edition(edition, true)
                    check_for_unlock({ type = 'have_edition' })
                    card:juice_up(0.6, 0.6)
                else
                    return{}
                end
            else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            end
        end

        if context.joker_main then
            local joker_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' and G.jokers.cards[i].edition then
                    joker_count = joker_count + 1 end
                end
            return {
                mult = card.ability.extra.mult * joker_count
            }
        end
    end
}

---Commutative property joker
SMODS.Joker {
    ---joker's name and info
    key = 'CommutativeProperty',
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 1, y = 2},
    config = { extra = { t_mult = 0, type = 'Two Pair' } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.t_mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,

    ---Makes the sum of chips and mult scored by playing cards, the total will be given in chips if the played hand contains a Two Pair
    calculate = function(self, card, context)

        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            local totalchips = 0
            local totalmult = 0
            
            for k, v in pairs(context.scoring_hand) do
                totalchips = totalchips + v:get_chip_bonus()
                totalmult = totalmult + v:get_chip_mult()
            end

            card.ability.extra.t_mult = totalchips + totalmult
            return {
                mult = card.ability.extra.t_mult,
            }
        end
    end
}

---Mysterious Concotion joker
SMODS.Joker {
    ---joker's name and info
    key = 'MysteriousConcotion',
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 9, y = 1},
    config = { extra = { mult = 10, chips = 50, Xmult = 3, xchips = 3, hands_left = 8 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.Xmult, card.ability.extra.xchips, card.ability.extra.hands_left }}
    end,

    ---Joker randomly chooses to give mult, chips, Xmult, Xchips or set Mult and Chips to 0 (ends after 8 hands)
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.hands_left - 1 <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        -- This replicates the food destruction effect
                        -- If you want a simpler way to destroy Jokers, you can do card:start_dissolve() for a dissolving animation
                        -- or just card:remove() for no animation
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_drank_ex'),
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.hands_left = card.ability.extra.hands_left - 1
                return {
                    message = card.ability.extra.hands_left .. '',
                    colour = G.C.FILTER
                }
            end
        end
        if context.final_scoring_step then
            local randomVar = pseudorandom('seed', 1, 5)
            if randomVar == 1 then
                return {
                    mult = card.ability.extra.mult
                }
            elseif randomVar == 2 then
                return {
                    chips = card.ability.extra.chips
                }
            elseif randomVar == 3 then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            elseif randomVar == 4 then
                return {
                    xchips = card.ability.extra.xchips
                }
            elseif randomVar == 5 then
                mult = 0
                hand_chips = 0

                update_hand_text({delay = 0, modded = true }, {mult = mult, chips = hand_chips})
                
                G.E_MANAGER:add_event(Event({
                        func = (function()
                            -- scored_card:juice_up()
                            ease_colour(G.C.UI_CHIPS, {0.0, 0.0, 0.0, 1})
                            ease_colour(G.C.UI_MULT, {0.0, 0.0, 0.0, 1})
                            card:juice_up(0.4, 0.4)

                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                blockable = false,
                                blocking = false,
                                delay =  0.8,
                                func = (function() 
                                    ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
                                    ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
                                    return true
                                end)
                            }))
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                blockable = false,
                                blocking = false,
                                no_delete = true,
                                delay =  1.3,
                                func = (function() 
                                    G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                                    G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                                    return true
                                end)
                            }))
                            return { attention_text({scale = 1.4, text = localize('k_SM_ohNo'), hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play}) }, true
                        end)
                    }))
                    delay(0.6)
                return true
            end
        end
    end
}

---Relativity formula joker
SMODS.Joker {
    ---joker's name and info
    key = 'RelativityFormula',
    blueprint_compat = false,
    rarity = 3,
    cost = 10,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 2, y = 2},
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return{vars = { }}
    end,

    ---If the total of Chips is superior to Mult, subtract the 10% of total Chips and add subtracted value to the Mult and raise it to ^2
    ---The same process happens but inverted if the total of Mult is superior to Chips
    calculate = function(self, card, context)
        local effect = {}
        if context.final_scoring_step then
            if hand_chips > mult then 
                local subtractor = math.ceil(hand_chips*(5/100))
                local addendum = subtractor^(2)
                hand_chips = mod_chips(hand_chips - subtractor)
                mult = mod_mult(mult + addendum)
                
                update_hand_text({ delay = 0, modded = true }, {mult = mult, chips = hand_chips})
                
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            -- scored_card:juice_up()
                            play_sound('gong', 0.94, 0.3)
                            play_sound('gong', 0.94*1.5, 0.2)
                            play_sound('tarot1', 1.5)
                            ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                            ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                            card:juice_up(0.4, 0.4)

                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                blockable = false,
                                blocking = false,
                                delay =  0.8,
                                func = (function() 
                                    ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
                                    ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
                                    return true
                                end)
                            }))
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                blockable = false,
                                blocking = false,
                                no_delete = true,
                                delay =  1.3,
                                func = (function() 
                                    G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                                    G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                                    return true
                                end)
                            }))
                            return { attention_text({scale = 1.4, text = localize('k_SM_relativity'), hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play}) }, true
                        end)
                    }))
                    delay(0.6)
                return true

                elseif mult > hand_chips then
                    local subtractor = math.ceil(mult*(5/100))
                    local addendum = subtractor^(2)
                    mult = mod_mult(mult - subtractor)
                    hand_chips = mod_chips(hand_chips + addendum)
                
                    update_hand_text({ delay = 0, modded = true }, {mult = mult, chips = hand_chips})
                
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            -- scored_card:juice_up()
                            play_sound('gong', 0.94, 0.3)
                            play_sound('gong', 0.94*1.5, 0.2)
                            play_sound('tarot1', 1.5)
                            ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                            ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                            card:juice_up(0.8, 0.8)
                        
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                blockable = false,
                                blocking = false,
                                delay =  0.8,
                                func = (function() 
                                    ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
                                    ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
                                    return true
                                end)
                            }))
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                blockable = false,
                                blocking = false,
                                no_delete = true,
                                delay =  1.3,
                                func = (function() 
                                    G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                                    G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                                    return true
                                end)
                            }))
                            return { attention_text({scale = 1.4, text = localize('k_SM_relativity'), hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play}) }, true
                        end)
                    }))
                    delay(0.6)
                return true
                else
                    G.E_MANAGER:add_event(Event({
                        func = function()
                        card:juice_up(0.8, 0.8)
                        play_sound('tarot1')
                        return { attention_text({scale = 1.4, text = localize('k_SM_aTie'), hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play}) }, true
                    end
                    }))
                return true
            end
        end
    end
}

---Teacher's pet joker
SMODS.Joker {
    ---joker's name and info
    key = 'TeachersPet',
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 3, y = 2},
    config = { extra = { chips = 5, mult = 1, Xmult = 1.2 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.Xmult } }
    end,

    ---Played 10's, 9's and 8's give +5 Chips, +1 Mult and  1.2X Xmult
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 10 or context.other_card:get_id() == 9 or context.other_card:get_id() == 8 then
                return {
                    chips = card.ability.extra.chips,
                    Xmult = card.ability.extra.Xmult
                }
            end
        end

    end
}

---Prime numbers joker
SMODS.Joker {
    ---joker's name and info
    key = 'PrimeNumbers',
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 4, y = 2},
    config = { extra = { chips = 37 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.chips } }
    end,

    ---Played Prime Number cards give +29 Chips when scored
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.other_card:is_face() then
            if context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 5 or context.other_card:get_id() == 7 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end

    end
}

---Bristlemouth joker
SMODS.Joker {
    ---joker's name and info
    key = 'BristleMouth',
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 5, y = 2},
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return{vars = {  } }
    end,

    ---Common Jokers and Tarot cards cards may appear in the shop multiple times
}

local smods_showman_ref = SMODS.showman
function SMODS.showman(card_key)
    if next(SMODS.find_card('j_SM_BristleMouth')) then
        if G.P_CENTERS[card_key].rarity == 1 or G.P_CENTERS[card_key].set == "Tarot" then
            return true  
        end
    end
    return smods_showman_ref(card_key)
end

---Trial and error joker
SMODS.Joker {
    ---joker's name and info
    key = 'TrialAndError',
    blueprint_compat = false,
    rarity = 1,
    cost = 5,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 6, y = 2},
    config = { extra = { odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SM_TrialAndError')
        return{vars = { numerator, denominator } }
    end,

    --- Unscored Playing Cards have a 1 in 2 chance to be destroyed
    calculate = function(self, card, context)
            if context.destroy_card and context.cardarea == "unscored" then
                    if SMODS.pseudorandom_probability(card, 'SM_TrialAndError', 1, card.ability.extra.odds) then
                        return {
                            message = localize('k_SM_fail'),
                            colour = G.C.RED,
                            remove = true
                        }
                    end
            end
    end,
    
}

---Tuna Sandwich joker
SMODS.Joker {
    ---joker's name and info
    key = 'TunaSandwich',
    blueprint_compat = false,
    rarity = 2,
    cost = 4,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 7, y = 2},
    config = { extra = { type = 'Three of a Kind', rounds_left = 8  } },
    loc_vars = function(self, info_queue, card)
        return{vars = { localize(card.ability.extra.type, 'poker_hands'), card.ability.extra.rounds_left } }
    end,

    --- 3oak's can appear more often 
    calculate = function(self, card, context)

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.rounds_left <= 1 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.RED
                }
            else
                card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
                return {
                    message = ''..card.ability.extra.rounds_left,
                    colour = G.C.ATTENTION
                }
            end

        end
        if context.hand_drawn then
            G.E_MANAGER:add_event(Event({
                func = function()  
                    -- This function makes the joker choose a random rank of the full deck and draw 3 cards of the same rank
                    -- If there are not 3 cards of the same rank the joker will try to get another randomRank
                    local valid_playing_cards = {}
                    for _, playing_card in ipairs(G.playing_cards) do
                        if not SMODS.has_no_rank(playing_card) then
                            valid_playing_cards[#valid_playing_cards + 1] = playing_card
                        end
                    end
                    local randomRank = pseudorandom_element(valid_playing_cards):get_id()
                    
                    local cards = {}
                    
                    for k, v in pairs(G.deck.cards) do
                        if v:get_id() == randomRank then
                            table.insert(cards, v)
                        end
                    end
                    
                    for i=1, 3 do
                        local card_to_draw, ii = pseudorandom_element(cards, 'seed')
                        table.remove(cards, ii)
                        draw_card(G.deck,G.hand, i*100/3,'up', true, card_to_draw)
                    end
                    return true
                end
            })) 
        end
    end,
    
}

---Fertilizer joker
SMODS.Joker {
    ---joker's name and info
    key = 'Fertilizer',
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 8, y = 2},
    config = { extra = { mult = 5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_SM_dirt_card
        return{vars = { card.ability.extra.mult } }
    end,

    ---Dirt cards give +5 Mult and after scoring turn them into Bloom cards
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.other_card:is_face() then
            if SMODS.has_enhancement(context.other_card, "m_SM_dirt_card") then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end

        if context.after and not context.blueprint then
            local dirtCards = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, "m_SM_dirt_card") then
                    dirtCards = dirtCards + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        func = function()
                            scored_card:set_ability('m_SM_bloom_card')
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if dirtCards > 0 then
                return {
                    message = localize('k_SM_fertilize'),
                    colour = G.C.GREEN
                }
            end
        end
    end
}

---Plutonium Rod joker
SMODS.Joker {
    ---joker's name and info
    key = 'PlutoniumRod',
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 9, y = 2},
    config = { extra = { poker_hand = 'High Card', repetitions = 4, odds = 20 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SM_PlutoniumRod')
        return{vars = { localize(card.ability.extra.poker_hand, 'poker_hands'), card.ability.extra.repetitions, numerator, denominator } }
    end,

    ---If played hand is a High Card level up the played hand and retrigger all the played cards 4 additional times.
    ---1 in 20 chance to set your total money to a negative value or immediately lose the run.
    ---(extra odds increase by 1 at the end of the round)
    calculate = function(self, card, context)
        if context.scoring_name == card.ability.extra.poker_hand then
            if context.before then
                return {
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
        if context.after and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'SM_PlutoniumRod', 1, card.ability.extra.odds) then

                local randomVar = pseudorandom('SM_seed', 1, 10)

                if randomVar <=5 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            card:juice_up(0.3, 0.5)
                            G.STATE = G.STATES.GAME_OVER
                            if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
                                G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
                            end
                            G:save_settings()
                            G.FILE_HANDLER.force = true
                            G.STATE_COMPLETE = false
                            return true
                            end
                        }))
                    delay(0.6) 
                else
                    if G.GAME.dollars > 0 then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                card:juice_up(0.3, 0.5)
                                G.GAME.dollars = G.GAME.dollars * -1
                                return true
                                end
                            }))
                        delay(0.6)
                        return {
                            message = localize('k_SM_radiations'),
                            colour = G.C.GREEN,
                        }
                    end
                end
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.odds = card.ability.extra.odds - pseudorandom('SM_seed', 1, 5)
            if card.ability.extra.odds <= 0 then
                card.ability.extra.odds = 1
                
                return {
                    message = localize('k_SM_careful'),
                    colour = G.C.GREEN,
                }
            else
                return {
                    message = localize('k_SM_careful'),
                    colour = G.C.GREEN,
                }
            end
            

        end
    end
}

---Prospective joker
SMODS.Joker {
    ---joker's name and info
    key = 'Prospective',
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    --- for the custom sprite to be applied to the joker and the local variables
    atlas = 'SciencefulJokers',
    pos = {x = 0, y = 3},
    config = { extra = { normalOdds = 1, oddsQuantity = 0 } },
    loc_vars = function(self, info_queue, card)
        return{vars = { card.ability.extra.normalOdds, card.ability.extra.oddsQuantity } }
    end,

    --- increase by 1 all listed probabilities when a blind is defeated in the 1st hand of the round, otherwise resets
    calculate = function(self, card, context)

        if context.after then
            if SMODS.last_hand_oneshot and G.GAME.current_round.hands_played == 0 then
                card.ability.extra.oddsQuantity = card.ability.extra.oddsQuantity + 1
                return
                {
                    message = "+1 probability",
                    colour = G.C.GREEN
                } 
            elseif card.ability.extra.oddsQuantity >= 1  then
                card.ability.extra.oddsQuantity = 0
                return
                {
                    message = localize('k_reset'),
                    sound = 'tarot1',
                    pitch = 1,
                    colour = G.C.attention
                }
            end
        end

        if context.mod_probability and not context.blueprint then
            return
            {
                numerator = context.numerator + (card.ability.extra.normalOdds * card.ability.extra.oddsQuantity)               
            }
        end
    end
}