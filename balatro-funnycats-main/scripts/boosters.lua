
SMODS.Booster{
    key = 'gato_normal_1',
    loc_txt = {
        name = "Gato Pack",
        text= {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Cat{} cards",
        },
        group_name = {
            "Gato Pack"
        }
    },
    atlas = 'catboosters',
    pos = {x = 0,y = 0},
    discovered = false,
    weight = 0.8,
    cost = 4,
    config = {
        extra = 2,
        choose = 1
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        } --#1# is replaced with card.ability.extra.Xmult
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.BUFFOON_PACK)
    end,
    create_card = function(self, card)
        return { 
            set = "catjokers", 
            area = G.pack_cards,
        }
    end,
}

SMODS.Booster{
    key = 'gato_normal_2',
    loc_txt = {
        name = "Gato Pack",
        text= {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Cat{} cards",
        },
        group_name = {
            "Gato Pack"
        }
    },
    atlas = 'catboosters',
    pos = {x = 1,y = 0},
    discovered = false,
    weight = 0.8, 
    cost = 4,
    config = {
        extra = 2,
        choose = 1
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        } --#1# is replaced with card.ability.extra.Xmult
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.BUFFOON_PACK)
    end,
    create_card = function(self, card)
        return { 
            set = "catjokers", 
            area = G.pack_cards,
        }
    end,
}

SMODS.Booster{
    key = 'gato_jumbo_1',
    loc_txt = {
        name = "Jumbo Gato Pack",
        text= {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Cat{} cards",
        },
        group_name = {
            "Gato Pack"
        }
    },
    atlas = 'catboosters',
    pos = {x = 0,y = 1},
    discovered = false,
    weight = 0.8,
    cost = 6,
    config = {
        extra = 3,
        choose = 1
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        } --#1# is replaced with card.ability.extra.Xmult
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.BUFFOON_PACK)
    end,
    create_card = function(self, card)
        return { 
            set = "catjokers", 
            area = G.pack_cards,
        }
    end,
}

SMODS.Booster{
    key = 'gato_mega_1',
    loc_txt = {
        name = "Mega Gato Pack",
        text= {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Cat{} cards",
        },
        group_name = {
            "Gato Pack"
        }
    },
    atlas = 'catboosters',
    pos = {x = 1,y = 1},
    discovered = false,
    weight = 0.45,
    cost = 10,
    config = {
        extra = 4,
        choose = 2
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        } --#1# is replaced with card.ability.extra.Xmult
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.BUFFOON_PACK)
    end,
    create_card = function(self, card)
        return { 
            set = "catjokers", 
            area = G.pack_cards,
        }
    end,
}
