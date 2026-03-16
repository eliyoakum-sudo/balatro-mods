
SMODS.Booster {
    key = 'unity_pack',
    loc_txt = {
        name = "Unity Pack",
        text = {
            [1] = 'Booster pack full of combined {C:gold}Joker Synergies.{}',
            [2] = 'Choose 1 of 2 jokers.'
        },
        group_name = "braysjokers_boosters"
    },
    config = { extra = 2, choose = 1 },
    cost = 20,
    weight = 0,
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    group_key = "braysjokers_boosters",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Joker",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("f8e71c"))
        ease_background_colour({ new_colour = HEX('f8e71c'), special_colour = HEX("f8e71c"), contrast = 2 })
    end,
    particles = function(self)
        -- No particles for joker packs
        end,
    }
    
    
    SMODS.Booster {
        key = 'jumbo_unity_pack',
        loc_txt = {
            name = "Jumbo Unity Pack",
            text = {
                [1] = 'Booster pack full of combined {C:gold}Joker Synergies.{}',
                [2] = 'Choose 1 of 4 jokers.'
            },
            group_name = "braysjokers_boosters"
        },
        config = { extra = 4, choose = 1 },
        cost = 30,
        weight = 0,
        atlas = "CustomBoosters",
        pos = { x = 1, y = 0 },
        group_key = "braysjokers_boosters",
        discovered = true,
        loc_vars = function(self, info_queue, card)
            local cfg = (card and card.ability) or self.config
            return {
                vars = { cfg.choose, cfg.extra }
            }
        end,
        create_card = function(self, card, i)
            return {
                set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true
            }
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, HEX("f8e71c"))
            ease_background_colour({ new_colour = HEX('f8e71c'), special_colour = HEX("f8e71c"), contrast = 2 })
        end,
        particles = function(self)
            -- No particles for joker packs
            end,
        }
        
        
        SMODS.Booster {
            key = 'mega_unity_pack',
            loc_txt = {
                name = "Mega Unity Pack",
                text = {
                    [1] = 'Booster pack full of combined {C:gold}Joker Synergies.{}',
                    [2] = 'Choose 1 of 4 jokers.'
                },
                group_name = "braysjokers_boosters"
            },
            config = { extra = 4, choose = 2 },
            cost = 40,
            weight = 0,
            atlas = "CustomBoosters",
            pos = { x = 2, y = 0 },
            group_key = "braysjokers_boosters",
            loc_vars = function(self, info_queue, card)
                local cfg = (card and card.ability) or self.config
                return {
                    vars = { cfg.choose, cfg.extra }
                }
            end,
            create_card = function(self, card, i)
                return {
                    set = "Joker",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true
                }
            end,
            ease_background_colour = function(self)
                ease_colour(G.C.DYN_UI.MAIN, HEX("f8e71c"))
                ease_background_colour({ new_colour = HEX('f8e71c'), special_colour = HEX("f8e71c"), contrast = 2 })
            end,
            particles = function(self)
                -- No particles for joker packs
                end,
            }
            