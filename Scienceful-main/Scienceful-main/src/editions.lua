SMODS.Shader {
    key = "definitive",
    path = "definitive.fs",
}
SMODS.Edition {
    key = "definitive",
    shader = "definitive",
    config = { extra = {dollars = 1} },
    in_shop = true,
    weight = 14,
    extra_cost = 3,
    sound = { sound = "SM_definitive1", per = 1.0, vol = 0.3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.dollars, card.edition.extra.dollars } }
    end,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                dollars = card.edition.extra.dollars
            }
        end
        if context.end_of_round and context.game_over == false then
            card.edition.extra.dollars = card.edition.extra.dollars + 1
            return {
                message = 'Upgrade!',
                sound = 'SM_definitive2',
                volume = 0.4,
                pitch = 1,
                colour = G.C.MONEY
            }
        end
    end
}