SMODS.Atlas{  
    key = 'pvz_consumables',
    px = 71,
    py = 95,
    path = "pvz_consumables.png",
    prefix_config = {key = false},
}


SMODS.Consumable{ -- Sun
    key = 'sun', 
    set = 'Tarot', 
	cost = 3,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 1, y = 0},
    -- LOGIC GOES HERE
	use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 1 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        assert(SMODS.change_base(G.hand.highlighted[i], nil, 'Ace'))
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted == 1)
    end
}

SMODS.Consumable{ -- Car Key
    key = 'carkey', 
    set = 'Tarot', 
	cost = 3,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 2, y = 0},
    -- LOGIC GOES HERE
	config = { extra = {
        booster_slots_value = 1
    } },
	use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Booster Slots", colour = G.C.BLUE})
                    SMODS.change_booster_limit(1)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable{ -- Present
    key = 'present', 
    set = 'Tarot', 
	cost = 3,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 3, y = 0},
    -- LOGIC GOES HERE
	use = function(self, card, area, copier)
        local used_card = copier or card
            local voucher_key = pseudorandom_element(G.P_CENTER_POOLS.Voucher, "3365bd33").key
    local voucher_card = SMODS.create_card{area = G.play, key = voucher_key}
    voucher_card:start_materialize()
    voucher_card.cost = 0
    G.play:emplace(voucher_card)
    delay(0.8)
    voucher_card:redeem()

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
            voucher_card:start_dissolve()                
            return true
        end
    }))
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable{ -- Coin
    key = 'coin', 
    set = 'Tarot', 
	cost = 3,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 0, y = 1},
    -- LOGIC GOES HERE
	config = { extra = {
        dollars_value = 10
    } },
	use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(10).." $", colour = G.C.MONEY})
                    ease_dollars(10, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable{ -- Gold Coin
    key = 'goldcoin', 
    set = 'Tarot', 
	cost = 3,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 1, y = 1},
    -- LOGIC GOES HERE
	config = { extra = {
        dollars_value = 50
    } },
	use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(50).." $", colour = G.C.MONEY})
                    ease_dollars(50, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable{ -- Diamond
    key = 'diamond', 
    set = 'Tarot',
	in_pool = function(self) return false end,
	cost = 1000,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 2, y = 1},
    -- LOGIC GOES HERE
	config = { extra = {
        dollars_value = 1000
    } },
	use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(1000).." $", colour = G.C.MONEY})
                    ease_dollars(1000, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable{ -- Taco
    key = 'taco', 
    set = 'Tarot', 
	cost = 3,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 3, y = 1},
    -- LOGIC GOES HERE
	config = { extra = {
        consumable_count = 1
    } },
	use = function(self, card, area, copier)
        local used_card = copier or card
            for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            SMODS.add_card({ key = 'c_pvz_diamond' })
                            used_card:juice_up(0.3, 0.5)
                        end
                        return true
                    end
                }))
            end
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable{ -- Water Can
    key = 'watercan', 
    set = 'Tarot', 
	cost = 3,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 0, y = 2},
    -- LOGIC GOES HERE
	config = { extra = {
        hands_value = 1
    } },
	use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Hand", colour = G.C.GREEN})
                    
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
        ease_hands_played(1)
        
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable{ -- Shovel
    key = 'shovel', 
    set = 'Tarot', 
	cost = 3,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 1, y = 2},
    -- LOGIC GOES HERE
	config = { extra = {
        discards_value = 1
    } },
	use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Discard", colour = G.C.ORANGE})
                    
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
        ease_discard(1)
        
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable{ -- Fertilizer
    key = 'fertilizer', 
    set = 'Tarot', 
	cost = 3,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 2, y = 2},
    -- LOGIC GOES HERE
	use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted <= 2 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        assert(SMODS.modify_rank(G.hand.highlighted[i], 1))
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted <= 2)
    end
}

SMODS.Consumable{ -- Bug Spray
    key = 'bugspray', 
    set = 'Tarot',
	cost = 3,
	unlocked = true,
	discovered = false,
	hidden = false,
	can_repeat_soul = false,
    atlas = 'pvz_consumables', 
    pos = {x = 3, y = 2},
    -- LOGIC GOES HERE
	config = { extra = {
        edition_amount = 1
    } },
	use = function(self, card, area, copier)
        local used_card = copier or card
            local jokers_to_edition = {}
            local eligible_jokers = {}
            
            if 'any' == 'editionless' then
                eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
            else
                for _, joker in pairs(G.jokers.cards) do
                    if joker.ability.set == 'Joker' then
                        eligible_jokers[#eligible_jokers + 1] = joker
                    end
                end
            end
            
            if #eligible_jokers > 0 then
                local temp_jokers = {}
                for _, joker in ipairs(eligible_jokers) do 
                    temp_jokers[#temp_jokers + 1] = joker 
                end
                
                pseudoshuffle(temp_jokers, 76543)
                
                for i = 1, math.min(card.ability.extra.edition_amount, #temp_jokers) do
                    jokers_to_edition[#jokers_to_edition + 1] = temp_jokers[i]
                end
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            for _, joker in pairs(jokers_to_edition) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        local edition = poll_edition('edition_random_joker', nil, true, true, 
                            { 'e_polychrome', 'e_holo', 'e_foil' })
                        joker:set_edition(edition, true)
                        return true
                    end
                }))
            end
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}