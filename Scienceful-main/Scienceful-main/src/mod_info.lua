SMODS.current_mod.extra_tabs = function()
	return {
		{
			label = localize("k_SM_credits"),
			
			tab_definition_function = function()

                local modNodes = {}

                modNodes[#modNodes + 1] = {}
				
                local loc_vars = { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2, shadow = true }
                localize { type = 'descriptions', key = "SM_credits", set = 'Other', nodes = modNodes[#modNodes], vars = loc_vars.vars,
				scale = loc_vars.scale, text_colour = loc_vars.text_colour, shadow = loc_vars.shadow }

                modNodes[#modNodes] = desc_from_rows(modNodes[#modNodes])
                modNodes[#modNodes].config.colour = loc_vars.background_colour or modNodes[#modNodes].config.colour

				return {
					n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tm", emboss = 0.05, padding = 0.2, colour = G.C.BLACK, shadow = true },
					nodes = {
						{n = G.UIT.C, config = {},
						nodes= {
							{n = G.UIT.R, config = {},
							nodes = {
								{n = G.UIT.T, config = {text = "developer / artist / programmer: " ..localize("k_SM_author"), align = "tm", scale = 0.4, shadow = true }},
							}},
							{n = G.UIT.R, config = {align = "cm"},
							nodes = modNodes},
						}},

					},
				}
			end,
		},
		-- insert more tables with the same structure here
	}
end