-- The variable
SMODS.Blind {
    key = "the_variable",
    dollars = 5,
    mult = 2,
    atlas ="SciencefulBlinds",
    pos = { x = 0, y = 0 },
    boss = { min = 1 },
    boss_colour = HEX("46bfe8"),

    calculate = function(self, blind, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
                func = function()  
                    -- This function makes the boss blind choose a random rank of the full deck
                        local valid_playing_cards = {}
                        for _, playing_card in ipairs(G.playing_cards) do
                            if not SMODS.has_no_rank(playing_card) then
                                valid_playing_cards[#valid_playing_cards + 1] = playing_card
                            end
                        end
                        G.GAME.blind.effect.rank = pseudorandom_element(valid_playing_cards):get_id()
                        blind:wiggle()
                        for k, v in pairs(G.playing_cards) do
                            blind:debuff_card(v, true)
                        end
                    
                    return true 
                end
            }))
        end

        -- This function makes the boss debuff all the cards of with the corresponding rank of the full deck
        if context.debuff_card then
            if not G.GAME.blind.disabled and context.debuff_card.area ~= G.jokers and context.debuff_card.area ~= G.consumeables then
                if context.debuff_card:get_id() == G.GAME.blind.effect.rank then
                    return {debuff = true}
                end
            end
        end

    end,
}