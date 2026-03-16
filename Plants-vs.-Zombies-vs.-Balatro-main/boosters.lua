loc_colour()
G.ARGS.LOC_COLOURS.pvz_greeny = HEX('aedd25')

SMODS.Booster {
    key = 'twiddy_dinkies',
    loc_txt = {
        name = "Twiddy Dinkies",
        text = {
            "Choose {C:attention}1{} of up to",
			"{C:attention}3{} {C:pvz_greeny}PvZ{} cards to",
			"be used immediately",
        },
        group_name = "Twiddy Dinkies"
    },
    config = { extra = 3, choose = 1 },
    cost = 6,
    atlas = "pvz_consumables",
    pos = { x = 0, y = 0 },
	draw_hand = true,				 
    select_card = "consumeables",
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local weights = {
            1,
            1,
            1,
            0.8,
            0.5,
            0.1,
            0.6,
            1,
            1,
            1,
            1
        }
        local total_weight = 0
        for _, weight in ipairs(weights) do
            total_weight = total_weight + weight
        end
        local random_value = pseudorandom('mycustom_twiddy_dinkies_card') * total_weight
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
            key = "c_pvz_sun",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        elseif selected_index == 2 then
            return {
            key = "c_pvz_carkey",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        elseif selected_index == 3 then
            return {
            key = "c_pvz_present",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        elseif selected_index == 4 then
            return {
            key = "c_pvz_coin",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        elseif selected_index == 5 then
            return {
            key = "c_pvz_goldcoin",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        elseif selected_index == 6 then
            return {
            key = "c_pvz_diamond",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        elseif selected_index == 7 then
            return {
            key = "c_pvz_taco",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        elseif selected_index == 8 then
            return {
            key = "c_pvz_watercan",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        elseif selected_index == 9 then
            return {
            key = "c_pvz_shovel",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        elseif selected_index == 10 then
            return {
            key = "c_pvz_fertilizer",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        elseif selected_index == 11 then
            return {
            key = "c_pvz_bugspray",
            set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "mycustom_twiddy_dinkies"
            }
        end
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}
