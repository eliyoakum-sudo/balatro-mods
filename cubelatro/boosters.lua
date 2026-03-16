
SMODS.Booster {
    key = 'pool_pack',
    loc_txt = {
        name = "pool pack",
        text = {
            [1] = 'Choose {C:attention}1 of 5{} {C:blue}Pool Balls{}'
        },
        group_name = "Joker"
    },
    config = { extra = 5, choose = 1 },
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    kind = 'Joker',
    group_key = "Joker",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
            0.5,
            0.25
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('cueblatr_pool_pack_card') * total_weight
        local cumulative_weight = 0
        local selected_index = 1
        for j, weight in ipairs(weights) do
            cumulative_weight = cumulative_weight + weight
            if random_value <= cumulative_weight then
                selected_index = j
                break
            end
        end
        if selected_index == 1 then
            return {
                set = "cueblatr_cueblatr_jokers",
                rarity = "Common",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "cueblatr_pool_pack"
            }
        elseif selected_index == 2 then
            return {
                set = "cueblatr_cueblatr_jokers",
                rarity = "Uncommon",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "cueblatr_pool_pack"
            }
        elseif selected_index == 3 then
            return {
                set = "cueblatr_cueblatr_jokers",
                rarity = "Rare",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "cueblatr_pool_pack"
            }
        end
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("207c00"))
        ease_background_colour({ new_colour = HEX('207c00'), special_colour = HEX("00903f"), contrast = 2 })
    end,
    particles = function(self)
        -- No particles for joker packs
        end,
    }
    