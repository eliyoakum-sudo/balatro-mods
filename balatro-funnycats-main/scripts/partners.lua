if SMODS.find_mod('partner') and Partner_API and 'partners.lua' then
    Partner_API.Partner{
        key = "dapper_partner",
        name = "dapper_partner",
        unlocked = false,
        discovered = true,
        pos = {x = 0, y = 0},
        loc_txt = {
            name = "Dapper",
            text = {
                "Gains {C:mult}+#2#{} Mult",
                "per hand played",
                "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
            },
        },
        atlas = "catpartner",
        config = {extra = {mult = 0, mult_mod = 0.5}},
        link_config = {j_funnycats_dapper_cat = 1},
        loc_vars = function(self, info_queue, card)
            local link_level = self:get_link_level()
            local benefits = 1
            if link_level == 1 then benefits = 2 end
            return { vars = {card.ability.extra.mult, card.ability.extra.mult_mod*benefits} }
        end,
        calculate = function(self, card, context)
            if context.joker_main and card.ability.extra.mult >= 1 then
                return {
                    message = localize{type = "variable", key = "a_mult", vars = {card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
            if context.before then
                local link_level = self:get_link_level()
                local benefits = 1
                if link_level == 1 then benefits = 2 end
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod*benefits
                card_eval_status_text(card, "extra", nil, nil, nil, {message = localize("k_upgrade_ex"), colour = G.C.MULT})
            end
        end,
        check_for_unlock = function(self, args)
            for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
                if v.key == "dapper_cat" then
                    if get_joker_win_sticker(v, true) >= 8 then
                        return true
                    end
                    break
                end
            end
        end,
    }
end