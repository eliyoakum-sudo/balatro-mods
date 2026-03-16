SMODS.Back{
    name = "Uni Deck",
    atlas = "catdecks",
    key = "unideck",
    pos = {x = 0, y = 0},
    config = { ante_scaling = 2 },
    loc_txt = {
        name = "Uni Deck",
        text ={
            "Start with an {C:purple,E:1}Eternal{} {C:attention}Uni{}",
            "{C:red}X#1#{} base Blind size",
        },
    },
    loc_vars = function(self, info_queue, back)
        return { vars = { 
            self.config.ante_scaling 
            } 
        }
    end,
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
                        local new_card = create_card('Joker', G.jokers, nil,nil,nil,nil,'j_funnycats_uni',nil,true)
                        new_card:start_materialize()
                        new_card:add_to_deck()
                        new_card:set_eternal(true)
                        G.jokers:emplace(new_card)
					return true
				end
			end,
		}))
	end,
}