-- Config Tab
SMODS.current_mod.config_tab = function()
  return {
    n = G.UIT.ROOT,
    config = { mxw = 4, align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = G.C.BLACK },
    nodes = {
		{
			n = G.UIT.R,
			config = {
			padding = 0.25,
			align = "cm"
			},
			nodes = {
				{
					n = G.UIT.T,
					config = {
					text = "Requires Restart",
					shadow = true,
					scale = 0.75 * 0.8,
					colour = HEX("d80007")
					},
				},
			},
		},
-- Reset Required Columns
		-- ROW
		{
			n = G.UIT.R, config = { padding = 0, align = "cm", -- colour = G.C.BLUE 
			},
			nodes = {
				-- COLUMN A
				{
					n = G.UIT.C, config = { padding = 0.1, emboss = 0.5, align = "cl", -- colour = G.C.RED 
					},
					nodes = {
						-- Consumables
						{
							n = G.UIT.R,
							config = { tooltip = {text = {"Adds new consumables."}},},
							nodes = {
								{
									n = G.UIT.C,
									nodes = {
									  create_toggle {
										label = "Add Consumables",
										ref_table = pvz_config,
										ref_value = 'pvzconsumables'
										},
									},
								},
							}
						},
						-- Quips
						{
							n = G.UIT.R,
							config = { tooltip = {text = {"Adds new quips."}},},
							nodes = {
								{
									n = G.UIT.C,
									nodes = {
									  create_toggle {
										label = "Add Quips",
										ref_table = pvz_config,
										ref_value = 'pvzquips'
										},
									},
								},
							}
						},
						-- Shop Sign
						{
							n = G.UIT.R,
							config = { tooltip = {text = {"Changes shop sign and text."}},},
							nodes = {
								{
									n = G.UIT.C,
									nodes = {
									  create_toggle {
										label = "Shop Sign",
										ref_table = pvz_config,
										ref_value = 'pvzshopsign'
										},
									},
								},
							}
						},
					},
				},
			},
		},
    }
  }
end

-- Credits Tab
SMODS.current_mod.extra_tabs = function()
  local scale = 0.75
  return {
    label = "Credits",
    tab_definition_function = function()
      return {
        n = G.UIT.ROOT,
        config = {
          align = "cm",
          padding = 0.05,
          colour = G.C.CLEAR,
        },
        nodes = {
			{
				n = G.UIT.R,
				config = {
				  padding = 0,
				  align = "cm"
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
						  text = "Thanks to",
						  shadow = true,
						  scale = scale * 0.8,
						  colour = G.C.UI.TEXT_LIGHT
						}
					}
				}
			},
			{
				n = G.UIT.R,
				config = {
				  padding = 0,
				  align = "cm"
            },
            nodes = {
				{
					n = G.UIT.T,
					config = {
					  text = "Lead Developer: ",
					  shadow = true,
					  scale = scale * 0.8,
					  colour = G.C.UI.TEXT_LIGHT
					}
				},
				{
					n = G.UIT.T,
					config = {
					  text = "V--R",
					  shadow = true,
					  scale = scale * 0.8,
					  colour = HEX("d80007")
					}
				}
            }
          },

				-- {
					-- n = G.UIT.R,
					-- config = {
					  -- padding = 0,
					  -- align = "cm"
					-- },
					-- nodes = {
						-- {
							-- n = G.UIT.T,
							-- config = {
							  -- text = "Joker Logic: ",
							  -- shadow = true,
							  -- scale = scale * 0.8,
							  -- colour = G.C.UI.TEXT_LIGHT
							-- }
						-- },
						-- {
							-- n = G.UIT.T,
							-- config = {
							  -- text = "seu pai",
							  -- shadow = true,
							  -- scale = scale * 0.8,
							  -- colour = HEX("d80007")
							-- }
						-- }
					-- },
				-- },
			{
				n = G.UIT.R,
				config = {
					padding = 0,
					align = "cm"
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = "Special Thanks: ",
							shadow = true,
							scale = scale * 0.8,
							colour = G.C.UI.TEXT_LIGHT
						}
					},
					{
						n = G.UIT.T,
						config = {
							text = "Crazy Dave & Superb",
							shadow = true,
							scale = scale * 0.8,
							colour = HEX("d80007")
						}
					}
				}
			},
		    {
				n = G.UIT.R,
				config = {
				  padding = 0,
				  align = "cm"
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
						  text = "",
						  shadow = true,
						  scale = scale * 0.8,
						  colour = G.C.UI.TEXT_LIGHT
						}
					},
					{
						n = G.UIT.T,
						config = {
							text = "...and you!",
							shadow = true,
							scale = scale * 0.8,
							colour = HEX("d80007")
						}
					}
				}
			},
			{
				n = G.UIT.R, config = { padding = 0, align = "cm", -- colour = G.C.BLUE 
				},
				nodes = {
					{
						n = G.UIT.C, config = { padding = 0.2, align = "cl", -- colour = G.C.RED 
						},
						nodes = {
							UIBox_button({
							-- minw = 3.85,
							colour = HEX("d80007"),
							button = "vrgithub",
							label = {"Github"}
							}),
						},
					},
					{
						n = G.UIT.C, config = { padding = 0.2, align = "cr", -- colour = G.C.YELLOW
						},
						nodes = {
						  UIBox_button({
							-- minw = 3.85,
							colour = HEX("f5d985"),
							button = "vrdonate",
							label = {"Donate"}
							})
						},
					},
				},
			},
		},
      }
    end
  }
end

-- Functions

function G.FUNCS.vrgithub(e)
	love.system.openURL("https://github.com/VRArt1/Plants-vs.-Zombies-vs.-Balatro")
end
function G.FUNCS.vrdonate(e)
  love.system.openURL("https://ko-fi.com/vrart1")
end