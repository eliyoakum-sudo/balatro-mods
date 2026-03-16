---Additional load
SMODS.Voucher {
    key = "additional_load",
    atlas = "SciencefulVouchers",
    pos = { x = 0, y = 0 },
    config = { extra = { booster_size = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.booster_size } }
    end,

    -- +1 booster pack in the shop
    redeem = function(self, card)
        SMODS.change_booster_limit(card.ability.extra.booster_size)
    end,
}

local old_card_set_cost = Card.set_cost
function Card:set_cost()
    --Original function
     local ret = old_card_set_cost(self)

    --Modified part
    if self.ability.set == "Booster" then
        self.cost = math.max(self.cost-1, 0)
    end
    return ret
end

---Additional load plus
SMODS.Voucher {
    key = "additional_load_plus",
    atlas = "SciencefulVouchers",
    pos = { x = 1, y = 0 },
    config = { extra = { booster_size = 1, subtractor = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.booster_size, card.ability.extra.subtractor } }
    end,
    requires = { 'v_SM_additional_load' },

    -- +1 booster pack in the shop and packs cost 1$ less
    redeem = function(self, card)
        SMODS.change_booster_limit(card.ability.extra.booster_size)
        
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
}