-- Smart packs
SMODS.Booster{
    key = "SmartPack1",
    set = "Booster",
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_SM_smart_pack_normal"
        }
    end,
    atlas = 'SciencefulBoosterPack',
    pos = { x = 0, y = 0 },
    group_key = "k_SM_smart_pack",
    cost = 5,
    weight = 1.1,
    draw_hand = false,
    kind = "smart_pack",
    
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, lighten(G.C.BLUE, 0.2))
        ease_background_colour({ new_colour = lighten(G.C.BLUE, 0.2), special_colour = G.C.BLACK, contrast = 3 })
    end,

    create_card = function (self, card, i) 
        return SMODS.create_card{set = "Scienceful", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "SM"}
    end,
}

SMODS.Booster{
    key = "SmartPack2",
    set = "Booster",
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_SM_smart_pack_normal"
        }
    end,
    atlas = 'SciencefulBoosterPack',
    pos = { x = 1, y = 0 },
    group_key = "k_SM_smart_pack",
    cost = 5,
    weight = 1.1,
    draw_hand = false,
    kind = "smart_pack",

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, lighten(G.C.BLUE, 0.2))
        ease_background_colour({ new_colour = lighten(G.C.BLUE, 0.2), special_colour = G.C.BLACK, contrast = 3 })
    end,

    create_card = function (self, card, i) 
        return SMODS.create_card{set = "Scienceful", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "SM"}
    end,
}

-- Experimentum packs
SMODS.Booster{
    key = "ExperimentumPack1",
    set = "Booster",
    config = { extra = 3, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_SM_experimentum_pack_normal"
        }
    end,
    atlas = 'SciencefulBoosterPack',
    pos = { x = 0, y = 1 },
    group_key = "k_SM_experimentum_pack",
    cost = 5,
    weight = 4,
    draw_hand = true,
    kind = "experimentum_pack",
    
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.WHITE)
        ease_background_colour({ new_colour = G.C.PURPLE, special_colour = G.C.WHITE, contrast = 3 })
    end,

    --ease_background_colour = function(self)

    --    local choices = {
    --        G.C.WHITE,
    --        G.C.BLACK,
    --    }

    --    local color = pseudorandom_element(choices, 'SM_booster')
    --    ease_colour(G.C.DYN_UI.MAIN, color or G.C.WHITE)
    --    ease_background_colour({ new_colour = color, special_colour = G.C.PURPLE, contrast = 2 })
    --end,

    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.05,
            scale = 0.5,
            initialize = true,
            lifespan = 3,
            speed = 0.5,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.BLUE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,

    create_card = function (self, card, i) 
        return SMODS.create_card{set = "Experimentum", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "SM"}
    end,
}

SMODS.Booster{
    key = "ExperimentumPack2",
    set = "Booster",
    config = { extra = 3, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_SM_experimentum_pack_normal"
        }
    end,
    atlas = 'SciencefulBoosterPack',
    pos = { x = 1, y = 1 },
    group_key = "k_SM_experimentum_pack",
    cost = 5,
    weight = 4,
    draw_hand = true,
    kind = "experimentum_pack",

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.WHITE)
        ease_background_colour({ new_colour = G.C.PURPLE, special_colour = G.C.WHITE, contrast = 3 })
    end,

    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.05,
            scale = 0.5,
            initialize = true,
            lifespan = 3,
            speed = 0.5,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.BLUE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,

    create_card = function (self, card, i) 
        return SMODS.create_card{set = "Experimentum", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "SM"}
    end,
}

SMODS.Booster{
    key = "ExperimentumPack3",
    set = "Booster",
    config = { extra = 3, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_SM_experimentum_pack_normal"
        }
    end,
    atlas = 'SciencefulBoosterPack',
    pos = { x = 2, y = 1 },
    group_key = "k_SM_experimentum_pack",
    cost = 5,
    weight = 4,
    draw_hand = true,
    kind = "experimentum_pack",

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.WHITE)
        ease_background_colour({ new_colour = G.C.PURPLE, special_colour = G.C.WHITE, contrast = 3 })
    end,

    create_card = function (self, card, i) 
        return SMODS.create_card{set = "Experimentum", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "SM"}
    end,
}

SMODS.Booster{
    key = "ExperimentumPack4",
    set = "Booster",
    config = { extra = 3, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_SM_experimentum_pack_normal"
        }
    end,
    atlas = 'SciencefulBoosterPack',
    pos = { x = 3, y = 1 },
    group_key = "k_SM_experimentum_pack",
    cost = 5,
    weight = 4,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.WHITE)
        ease_background_colour({ new_colour = G.C.PURPLE, special_colour = G.C.WHITE, contrast = 3 })
    end,

    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.05,
            scale = 0.5,
            initialize = true,
            lifespan = 3,
            speed = 0.5,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.BLUE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,

    draw_hand = true,
    kind = "experimentum_pack",
    create_card = function (self, card, i) 
        return SMODS.create_card{set = "Experimentum", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "SM"}
    end,
}