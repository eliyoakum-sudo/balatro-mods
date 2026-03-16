
SMODS.Booster {
    key = 'RGBPACK',
    loc_txt = {
        name = "R greeeen {C:blue}{} pack",
        text = {
            [1] = ''
        },
        group_name = "test_boosters"
    },
    config = { extra = 3, choose = 1 },
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    group_key = "test_boosters",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "test_RGB",
            rarity = "test_rgb",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "test_RGBPACK"
        }
    end,
    particles = function(self)
        -- No particles for joker packs
        end,
    }
    