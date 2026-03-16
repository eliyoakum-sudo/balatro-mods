--- STEAMODDED HEADER
--- MOD_NAME: Big Pile of Jokers
--- MOD_ID: BigPileOfJokers
--- MOD_AUTHOR: Wes
--- MOD_DESCRIPTION: Adds a big pile of themed jokers with unique abilities

----------------------------------------------
------------MOD CODE -------------------------

-- Register sprite atlas
SMODS.Atlas{
    key = 'ChipBonusJokers',
    path = 'ChipBonusJokers.png',
    px = 71,
    py = 95
}

-- Register Roland sprite atlas
SMODS.Atlas{
    key = 'Roland',
    path = 'Roland.png',
    px = 71,
    py = 95
}

-- Register Distorted Bamboo-Hatted Kim sprite atlas
SMODS.Atlas{
    key = 'DistortedBambooHattedKim',
    path = 'toclaimtheirbones.png',
    px = 71,
    py = 95
}

-- Register Diagram sprite atlas
SMODS.Atlas{
    key = 'Diagram',
    path = 'Blueprint.png',
    px = 71,
    py = 95
}

-- Register Purple Card sprite atlas
SMODS.Atlas{
    key = 'PurpleCard',
    path = 'Purple Card.png',
    px = 71,
    py = 95
}

-- Register Gone Angels sprite atlas
SMODS.Atlas{
    key = 'GoneAngels',
    path = 'GoneAngelsAB.png.png',
    px = 71,
    py = 95
}

-- Register The Black Silence sprite atlas
SMODS.Atlas{
    key = 'BlackSilence',
    path = 'BlackSilence.png',
    px = 71,
    py = 95
}

-- Register Angelica sprite atlas
SMODS.Atlas{
    key = 'Angelica',
    path = 'Angelica.png',
    px = 71,
    py = 95
}

-- Register Angela sprite atlas
SMODS.Atlas{
    key = 'Angela',
    path = 'Angela.png',
    px = 71,
    py = 95
}

-- Register The Red Mist sprite atlas
SMODS.Atlas{
    key = 'TheRedMist',
    path = 'TheRedMist.png',
    px = 71,
    py = 95
}

-- Register Jevil sprite atlas
SMODS.Atlas{
    key = 'Jevil',
    path = 'Jevil.png',
    px = 71,
    py = 95
}

-- Register Terry sprite atlas
SMODS.Atlas{
    key = 'Terry',
    path = 'Terry.png',
    px = 71,
    py = 95
}


-- Joker 1: Mockingjay
SMODS.Joker{
    key = 'mockingjay',
    loc_txt = {
        name = 'Mockingjay',
        text = {
            "{C:chips}+15{} Chips",
            "Symbol of rebellion"
        }
    },
    config = {extra = {chips = 15}},
    rarity = 1,
    atlas = 'ChipBonusJokers',
    pos = {x = 0, y = 0},
    cost = 2,  -- Reduced from 4 to 2 to make it affordable early
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize{type='variable', key='a_chips', vars={card.ability.extra.chips}}
            }
        end
    end
}

-- Joker 2: District 12
SMODS.Joker{
    key = 'district_12',
    loc_txt = {
        name = 'District 12',
        text = {
            "{C:mult}+4{} Mult",
            "Mining district strength"
        }
    },
    config = {extra = {mult = 4}},
    rarity = 1,
    atlas = 'ChipBonusJokers',
    pos = {x = 1, y = 0},
    cost = 3,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
            }
        end
    end
}

-- Joker 3: Cornucopia
SMODS.Joker{
    key = 'cornucopia',
    loc_txt = {
        name = 'Cornucopia',
        text = {
            "Gains {C:chips}+3{} Chips",
            "per round survived",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
        }
    },
    config = {extra = {chips = 5, chip_gain = 3}},
    rarity = 2,
    atlas = 'ChipBonusJokers',
    pos = {x = 2, y = 0},
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize{type='variable', key='a_chips', vars={card.ability.extra.chips}}
            }
        elseif context.end_of_round and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
            return {
                message = localize('k_upgrade_ex'),
                card = card
            }
        end
    end
}

-- Joker 4: Capitol
SMODS.Joker{
    key = 'capitol',
    loc_txt = {
        name = 'Capitol',
        text = {
            "Earn {C:money}$2{} at",
            "end of round",
            "Wealth of the Capitol"
        }
    },
    config = {extra = {money = 2}},
    rarity = 1,
    atlas = 'ChipBonusJokers',
    pos = {x = 3, y = 0},
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint then
            ease_dollars(card.ability.extra.money)
            return {
                message = localize('$')..card.ability.extra.money,
                dollars = card.ability.extra.money,
                colour = G.C.MONEY
            }
        end
    end
}

-- Joker 5: Arena
SMODS.Joker{
    key = 'arena',
    loc_txt = {
        name = 'Arena',
        text = {
            "{X:mult,C:white} X2 {} Mult if played",
            "hand contains a {C:attention}Pair{}",
            "Only the strong survive"
        }
    },
    config = {extra = {Xmult = 2}},
    rarity = 2,
    atlas = 'ChipBonusJokers',
    pos = {x = 4, y = 0},
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and context.poker_hands ~= nil and context.poker_hands["Pair"] then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.Xmult}}
            }
        end
    end
}

-- Joker 6: Roland
SMODS.Joker{
    key = 'roland',
    loc_txt = {
        name = 'Roland',
        text = {
            "Creates a {C:dark_edition}Negative{} joker",
            "when blind is defeated",
            "If {C:attention}Angelica{} is present,",
            "gives {X:mult,C:white} X1.5 {} Mult instead"
        }
    },
    config = {extra = {Xmult = 1.5}},
    rarity = 3,
    atlas = 'Roland',
    pos = {x = 0, y = 0},
    cost = 12,
    blueprint_compat = false, -- Shouldn't work with blueprint to avoid abuse
    calculate = function(self, card, context)
        if context.joker_main then
            -- Check if Angelica is present for mult bonus
            local has_angelica = false
            if G.jokers and G.jokers.cards then
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.config and joker.config.center and 
                       joker.config.center.key == 'j_bpj_angelica' then
                        has_angelica = true
                        break
                    end
                end
            end
            
            if has_angelica then
                return {
                    Xmult_mod = card.ability.extra.Xmult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.Xmult}}
                }
            end
        elseif context.end_of_round and context.game_over == false and not context.blueprint then
            -- Check if Angelica is present to prevent negative joker creation
            local has_angelica = false
            if G.jokers and G.jokers.cards then
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.config and joker.config.center and 
                       joker.config.center.key == 'j_bpj_angelica' then
                        has_angelica = true
                        break
                    end
                end
            end
            
            -- Only create negative joker if Angelica is NOT present
            if not has_angelica then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'roland_negative')
                        new_card:set_edition({negative = true}, true)
                        new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize('k_plus_joker'),
                            colour = G.C.BLUE
                        })
                        return true
                    end
                }))
            end
        end
    end
}

-- Joker 7: Diagram
SMODS.Joker{
    key = 'diagram',
    loc_txt = {
        name = 'Diagram',
        text = {
            "Copies ability of",
            "Joker in the {C:attention}middle{}"
        }
    },
    config = {extra = {}},
    rarity = 2, -- Uncommon like Blueprint
    atlas = 'Diagram',
    pos = {x = 0, y = 0},
    cost = 10,
    blueprint_compat = false, -- Don't want blueprint copying another blueprint-like effect
    calculate = function(self, card, context)
        -- Find the joker in the middle position
        if G.jokers and #G.jokers.cards > 0 then
            local middle_index = math.ceil(#G.jokers.cards / 2)
            local middle_joker = G.jokers.cards[middle_index]
            
            -- Don't copy self or other blueprint-like jokers
            if middle_joker and middle_joker ~= card and 
               middle_joker.config and middle_joker.config.center and
               middle_joker.config.center.key ~= 'j_bpj_diagram' and
               middle_joker.config.center.key ~= 'j_blueprint' and
               middle_joker.config.center.key ~= 'j_brainstorm' then
                
                -- Copy the middle joker's calculate function with blueprint context
                if middle_joker.config.center.calculate then
                    context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
                    context.blueprint_card = context.blueprint_card or card
                    
                    local other_joker_ret = middle_joker.config.center:calculate(middle_joker, context)
                    if other_joker_ret then 
                        other_joker_ret.card = context.blueprint_card or card
                        other_joker_ret.colour = G.C.BLUE
                        return other_joker_ret
                    end
                end
            end
        end
    end
}

-- Joker 8: Purple Card
SMODS.Joker{
    key = 'purple_card',
    loc_txt = {
        name = 'Purple Card',
        text = {
            "Gains {X:mult,C:white} X0.25 {} Mult",
            "when a {C:purple}Tarot{} card is used",
            "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)"
        }
    },
    config = {extra = {Xmult = 1, Xmult_gain = 0.25}},
    rarity = 2, -- Uncommon
    atlas = 'PurpleCard',
    pos = {x = 0, y = 0},
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.Xmult > 1 then
                return {
                    Xmult_mod = card.ability.extra.Xmult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.Xmult}}
                }
            end
        elseif context.consumeable and context.consumeable.ability.set == 'Tarot' and not context.blueprint then
            -- Trigger when a tarot card is used
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "Upgrade!",
                        colour = G.C.PURPLE
                    })
                    return true
                end
            }))
        end
    end
}

-- Joker 9: Gone Angels
SMODS.Joker{
    key = 'gone_angels',
    loc_txt = {
        name = 'Gone Angels',
        text = {
            "Once {C:attention}5{} {C:dark_edition}Negative{} jokers",
            "have been sold, destroy this",
            "and {C:attention}Roland{} joker",
            "{C:inactive}(Currently #1#/5)"
        }
    },
    config = {extra = {negative_sold = 0, target = 5}},
    rarity = 3, -- Rare for such a specific and powerful effect
    atlas = 'GoneAngels',
    pos = {x = 0, y = 0},
    cost = 8,
    blueprint_compat = false, -- Don't want this copied
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.negative_sold}}
    end,
    calculate = function(self, card, context)
        -- This joker doesn't need calculate function for selling detection
        -- We'll use a different approach with a hook
    end
}

-- Hook to track negative joker sales for Gone Angels
local Card_sell_card_ref = Card.sell_card
function Card:sell_card()
    -- Check if this is a negative joker being sold
    if self.ability and self.ability.set == 'Joker' and 
       self.edition and self.edition.negative then
        
        -- Find Gone Angels joker and increment counter
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config and joker.config.center and 
                   joker.config.center.key == 'j_bpj_gone_angels' then
                    
                    joker.ability.extra.negative_sold = joker.ability.extra.negative_sold + 1
                    
                    -- Show progress message
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            card_eval_status_text(joker, 'extra', nil, nil, nil, {
                                message = joker.ability.extra.negative_sold .. "/5",
                                colour = G.C.RED
                            })
                            return true
                        end
                    }))
                    
                    -- Check if we've reached the target
                    if joker.ability.extra.negative_sold >= joker.ability.extra.target then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.5,
                            func = function()
                                -- Find and destroy Roland joker
                                local roland_destroyed = false
                                if G.jokers and G.jokers.cards then
                                    for _, target_joker in ipairs(G.jokers.cards) do
                                        if target_joker.config and target_joker.config.center and 
                                           target_joker.config.center.key == 'j_bpj_roland' then
                                            target_joker:start_dissolve()
                                            roland_destroyed = true
                                            break
                                        end
                                    end
                                end
                                
                                -- Show final message
                                card_eval_status_text(joker, 'extra', nil, nil, nil, {
                                    message = roland_destroyed and "Gone!" or "Roland not found!",
                                    colour = G.C.RED
                                })
                                
                                -- Destroy Gone Angels joker after a short delay
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.3,
                                    func = function()
                                        joker:start_dissolve()
                                        
                                        -- Create The Black Silence joker after Gone Angels is destroyed
                                        G.E_MANAGER:add_event(Event({
                                            trigger = 'after',
                                            delay = 0.5,
                                            func = function()
                                                local black_silence = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_bpj_the_black_silence')
                                                black_silence:add_to_deck()
                                                G.jokers:emplace(black_silence)
                                                
                                                play_sound('holo1')
                                                
                                                return true
                                            end
                                        }))
                                        
                                        return true
                                    end
                                }))
                                
                                return true
                            end
                        }))
                    end
                    break
                end
            end
        end
    end
    
    -- Call original function
    return Card_sell_card_ref(self)
end

-- Joker 10: The Black Silence
SMODS.Joker{
    key = 'the_black_silence',
    loc_txt = {
        name = 'The Black Silence',
        text = {
            "All jokers become {C:dark_edition}Negative{}",
            "{X:mult,C:white} X5 {} Mult",
            "{C:inactive}(Created from Gone Angels)"
        }
    },
    config = {extra = {Xmult = 5}},
    rarity = 4, -- Legendary
    atlas = 'BlackSilence',
    pos = {x = 0, y = 0},
    cost = 20,
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        -- When The Black Silence is added, make all other jokers negative
        if G.jokers and G.jokers.cards then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    for _, joker in ipairs(G.jokers.cards) do
                        if joker ~= card and not joker.edition then
                            joker:set_edition({negative = true}, true)
                        elseif joker ~= card and joker.edition and not joker.edition.negative then
                            joker:set_edition({negative = true}, true)
                        end
                    end
                    
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "Silence...",
                        colour = G.C.BLACK
                    })
                    
                    return true
                end
            }))
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.Xmult}}
            }
        end
    end
}

-- Joker 11: Angelica
SMODS.Joker{
    key = 'angelica',
    loc_txt = {
        name = 'Angelica',
        text = {
            "All cards in deck become",
            "{C:attention}Glass{} cards",
            "If {C:attention}Roland{} is present,",
            "also gives {X:mult,C:white} X1.5 {} Mult"
        }
    },
    config = {extra = {Xmult = 1.5, glass_applied = false}},
    rarity = 3, -- Rare
    atlas = 'Angelica',
    pos = {x = 0, y = 0},
    cost = 10,
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        -- When Angelica is added, make all cards in deck glass
        if not card.ability.extra.glass_applied then
            card.ability.extra.glass_applied = true
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    -- Make all cards in deck glass
                    local cards_to_glass = {}
                    
                    -- Add all cards from deck
                    if G.deck and G.deck.cards then
                        for _, c in ipairs(G.deck.cards) do
                            table.insert(cards_to_glass, c)
                        end
                    end
                    
                    -- Add all cards from hand
                    if G.hand and G.hand.cards then
                        for _, c in ipairs(G.hand.cards) do
                            table.insert(cards_to_glass, c)
                        end
                    end
                    
                    -- Add all cards from discard
                    if G.discard and G.discard.cards then
                        for _, c in ipairs(G.discard.cards) do
                            table.insert(cards_to_glass, c)
                        end
                    end
                    
                    -- Apply glass enhancement to all cards
                    for _, c in ipairs(cards_to_glass) do
                        c:set_ability(G.P_CENTERS.m_glass)
                    end
                    
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "Memories..",
                        colour = G.C.WHITE
                    })
                    
                    return true
                end
            }))
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            -- Check if Roland is present
            local has_roland = false
            if G.jokers and G.jokers.cards then
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.config and joker.config.center and 
                       joker.config.center.key == 'j_bpj_roland' then
                        has_roland = true
                        break
                    end
                end
            end
            
            if has_roland then
                return {
                    Xmult_mod = card.ability.extra.Xmult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.Xmult}}
                }
            end
        end
    end
}

-- Joker 12: Angela
SMODS.Joker{
    key = 'angela',
    loc_txt = {
        name = 'Angela',
        text = {
            "After completing a {C:attention}Boss Blind{},",
            "give all cards in hand",
            "random {C:attention}Seals{}"
        }
    },
    config = {extra = {}},
    rarity = 3, -- Rare
    atlas = 'Angela',
    pos = {x = 0, y = 0},
    cost = 10,
    blueprint_compat = false, -- Don't want this copied multiple times
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and not context.blueprint then
            -- Check if we just defeated a boss blind
            if G.GAME.blind and G.GAME.blind.boss then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        -- Apply random seals to all cards in hand
                        if G.hand and G.hand.cards then
                            local seal_types = {'Red', 'Blue', 'Gold', 'Purple'}
                            
                            for _, hand_card in ipairs(G.hand.cards) do
                                if not hand_card.seal then
                                    local random_seal = seal_types[math.random(#seal_types)]
                                    hand_card:set_seal(random_seal, true)
                                end
                            end
                            
                            -- Show message
                            card_eval_status_text(card, 'extra', nil, nil, nil, {
                                message = "Sealed!",
                                colour = G.C.PURPLE
                            })
                        end
                        
                        return true
                    end
                }))
            end
        end
    end
}

-- Joker 13: The Red Mist
SMODS.Joker{
    key = 'the_red_mist',
    loc_txt = {
        name = 'The Red Mist',
        text = {
            "All played cards become",
            "{C:hearts}Ace of Hearts{}",
            "Gains {X:mult,C:white} X0.25 {} Mult for",
            "each {C:hearts}Ace of Hearts{} played",
            "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)"
        }
    },
    config = {extra = {Xmult = 1, Xmult_gain = 0.25}},
    rarity = 4, -- Legendary for such a powerful transformation effect
    atlas = 'TheRedMist',
    pos = {x = 0, y = 0},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.Xmult > 1 then
                return {
                    Xmult_mod = card.ability.extra.Xmult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.Xmult}}
                }
            end
        elseif context.cardarea == G.jokers and context.before and not context.blueprint then
            -- Transform all played cards to Ace of Hearts and count them
            local aces_played = 0
            for _, played_card in ipairs(G.play.cards) do
                -- Transform card to Ace of Hearts
                played_card:set_base(G.P_CARDS.H_A)
                aces_played = aces_played + 1
            end
            
            -- Gain mult for each Ace of Hearts played
            if aces_played > 0 then
                card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.Xmult_gain * aces_played)
                
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "Red Mist!",
                    colour = G.C.RED
                })
            end
        end
    end
}

-- Joker 14: Jevil
SMODS.Joker{
    key = 'jevil',
    loc_txt = {
        name = 'Jevil',
        text = {
            "If played hand contains only",
            "the chosen suit, gives",
            "{C:chips}+500{} Chips and {C:mult}+500{} Mult",
            "Chosen suit: {C:attention}#1#{}",
            "{C:inactive}(Changes after each blind)"
        }
    },
    config = {extra = {chips = 500, mult = 500, chosen_suit = 'Hearts'}},
    rarity = 4, -- Legendary for such high bonuses
    atlas = 'Jevil',
    pos = {x = 0, y = 0},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chosen_suit}}
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            -- Check if all played cards are of the chosen suit
            local all_same_suit = true
            local target_suit = nil
            
            -- Convert chosen suit name to suit string used in Balatro
            local suit_map = {
                ['Hearts'] = 'Hearts',
                ['Diamonds'] = 'Diamonds', 
                ['Clubs'] = 'Clubs',
                ['Spades'] = 'Spades'
            }
            target_suit = suit_map[card.ability.extra.chosen_suit]
            
            if target_suit and context.scoring_hand and #context.scoring_hand > 0 then
                for _, played_card in ipairs(context.scoring_hand) do
                    if played_card:is_suit(target_suit) ~= true then
                        all_same_suit = false
                        break
                    end
                end
                
                if all_same_suit then
                    return {
                        chip_mod = card.ability.extra.chips,
                        mult_mod = card.ability.extra.mult,
                        message = "CHAOS!",
                        colour = G.C.PURPLE
                    }
                end
            end
        elseif context.end_of_round and context.game_over == false and not context.blueprint then
            -- Change chosen suit after each blind
            local suits = {'Hearts', 'Diamonds', 'Clubs', 'Spades'}
            local new_suit = suits[math.random(#suits)]
            card.ability.extra.chosen_suit = new_suit
            
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = "New suit: " .. new_suit,
                colour = G.C.PURPLE
            })
        end
    end
}

-- Joker 15: Terry
SMODS.Joker{
    key = 'terry',
    loc_txt = {
        name = 'Terry',
        text = {
            "Summons a random {C:legendary}Legendary{}",
            "joker when {C:attention}Flush Five{} is played",
            "{C:attention}+5{} hand size"
        }
    },
    config = {extra = {hand_size = 5}},
    rarity = 4, -- Legendary for such a powerful effect
    atlas = 'Terry',
    pos = {x = 0, y = 0},
    cost = 20,
    blueprint_compat = false, -- Don't want this copied multiple times
    add_to_deck = function(self, card, from_debuff)
        -- Increase hand size when Terry is added
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        -- Decrease hand size when Terry is removed
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.poker_hands and context.poker_hands["Flush Five"] and not context.blueprint then
            -- Summon a random legendary joker
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    -- Get all legendary jokers
                    local legendary_jokers = {}
                    for k, v in pairs(G.P_CENTERS) do
                        if v.set == 'Joker' and v.rarity == 4 and k ~= 'j_bpj_terry' then -- Don't summon another Terry
                            table.insert(legendary_jokers, k)
                        end
                    end
                    
                    if #legendary_jokers > 0 then
                        local random_legendary = legendary_jokers[math.random(#legendary_jokers)]
                        local new_joker = create_card('Joker', G.jokers, nil, 4, nil, nil, random_legendary) -- 4 = legendary rarity
                        new_joker:add_to_deck()
                        G.jokers:emplace(new_joker)
                        
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "Chicken Sandwich!",
                            colour = G.C.LEGENDARY
                        })
                    end
                    
                    return true
                end
            }))
        end
    end
}

-- Joker 16: Distorted Bamboo-Hatted Kim
SMODS.Joker{
    key = 'distorted_bamboo_hatted_kim',
    loc_txt = {
        name = 'Distorted Bamboo-Hatted Kim',
        text = {
            "{C:green}1 in 50{} chance when playing",
            "a {C:attention}High Card{} to destroy",
            "a random {C:dark_edition}Negative{} joker",
            "and {C:attention}instantly win{} the blind"
        }
    },
    config = {extra = {chance = 50}}, -- 1 in 50 chance (2%)
    rarity = 4, -- Legendary rarity for such a powerful effect
    atlas = 'DistortedBambooHattedKim',
    pos = {x = 0, y = 0},
    cost = 20,
    blueprint_compat = false, -- Too powerful for blueprint
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            -- Check if the played hand is High Card
            if context.poker_hands ~= nil and context.poker_hands["High Card"] then
                -- Check if we have any negative jokers to potentially destroy
                local negative_jokers = {}
                for _, joker in ipairs(G.jokers.cards) do
                    if joker.edition and joker.edition.negative and joker ~= card then
                        table.insert(negative_jokers, joker)
                    end
                end
                
                if #negative_jokers > 0 then
                    -- 1 in 50 chance to trigger
                    if pseudorandom('bamboo_kim') < G.GAME.probabilities.normal / card.ability.extra.chance then
                        -- Destroy a random negative joker
                        local target_joker = negative_jokers[math.random(#negative_jokers)]
                        
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.2,
                            func = function()
                                -- Remove the negative joker
                                target_joker:start_dissolve()
                                
                                -- Show message
                                card_eval_status_text(card, 'extra', nil, nil, nil, {
                                    message = "To Claim Their Bones!",
                                    colour = G.C.GOLD
                                })
                                
                                -- Instantly win the blind
                                G.GAME.blind.chips = 0
                                G.GAME.blind.chip_text = "0"
                                
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}



-- Add all HG jokers to starting deck for easy testing
local Game_start_run_ref = Game.start_run
function Game:start_run(args)
    Game_start_run_ref(self, args)
    
    -- Add all HG jokers to the player's deck at start
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 1.0,
        func = function()
            if G.jokers then
                local hg_jokers = {
                    'j_bpj_roland',
                    'j_bpj_gone_angels'
                }
                
                -- Add each HG joker to the player's collection
                for _, joker_key in ipairs(hg_jokers) do
                    local card = create_card('Joker', G.jokers, nil, nil, nil, nil, joker_key)
                    
                    -- Make Roland always holographic
                    if joker_key == 'j_bpj_roland' then
                        card:set_edition({holo = true}, true)
                    end
                    
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end
            end
            return true
        end
    }))
end

-- Alternative: Console commands for spawning jokers (if Steamodded supports it)
if G and G.FUNCS then
    G.FUNCS.spawn_hg_joker = function(joker_name)
        if not G.jokers then return end
        
        local joker_key = 'j_bpj_' .. (joker_name or 'mockingjay')
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, joker_key)
        
        -- Make Roland always polychrome
        if joker_key == 'j_bpj_roland' then
            card:set_edition({polychrome = true}, true)
        end
        
        card:add_to_deck()
        G.jokers:emplace(card)
    end
end

-- Simple function to add a random HG joker (can be called from debug console)
function add_random_hg_joker()
    if not G.jokers then return end
    
    local hg_jokers = {
        'j_bpj_mockingjay',
        'j_bpj_district_12',
        'j_bpj_cornucopia', 
        'j_bpj_capitol',
        'j_bpj_arena',
        'j_bpj_roland',
        'j_bpj_diagram',
        'j_bpj_purple_card',
        'j_bpj_gone_angels',
        'j_bpj_angelica',
        'j_bpj_angela',
        'j_bpj_the_red_mist',
        'j_bpj_jevil',
        'j_bpj_terry',
        'j_bpj_distorted_bamboo_hatted_kim'
    }
    
    local random_joker = hg_jokers[math.random(#hg_jokers)]
    local card = create_card('Joker', G.jokers, nil, nil, nil, nil, random_joker)
    
    -- Make Roland always holographic
    if random_joker == 'j_bpj_roland' then
        card:set_edition({holo = true}, true)
    end
    
    card:add_to_deck()
    G.jokers:emplace(card)
    
    return "Added " .. random_joker .. " to your collection!"
end

-- Make HG jokers cost $1 so they're super affordable when they do appear
for _, joker in ipairs({'j_bpj_mockingjay', 'j_bpj_district_12', 'j_bpj_cornucopia', 'j_bpj_capitol', 'j_bpj_arena', 'j_bpj_roland', 'j_bpj_diagram', 'j_bpj_purple_card', 'j_bpj_gone_angels', 'j_bpj_angelica', 'j_bpj_angela', 'j_bpj_the_red_mist', 'j_bpj_jevil', 'j_bpj_terry', 'j_bpj_distorted_bamboo_hatted_kim'}) do
    if G.P_CENTERS and G.P_CENTERS[joker] then
        G.P_CENTERS[joker].cost = 1
    end
end