SMODS.Tag{
    key = "scienceful_tag",
    atlas = "SciencefulTags",
    pos = { x = 0, y = 0},
    apply = function (self, tag, context)
        if context.type == 'store_joker_create' then
            local card = SMODS.create_card { set = "Scienceful", area = context.area, }
            create_shop_card_ui(card, 'Joker', context.area)
            card.states.visible = false
            tag:yep('+', G.C.GREEN, function()
                card:start_materialize()
                card.ability.couponed = true
                card:set_cost()
                return true
            end)
            tag.triggered = true
            return card
        end
    end
}

        --if context.type == 'new_blind_choice' then
            --local lock = tag.ID
            --G.CONTROLLER.locks[lock] = true
            --tag:yep("+",G.C.PURPLE,function ()
                --local key = 'p_SM_smart_pack_normal'
                --local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                --G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                --card.cost = 0
                --card.from_tag = true
                --G.FUNCS.use_card({config = {ref_table = card}})
                --card:start_materialize()
                --G.CONTROLLER.locks[lock] = nil
                --return true
            --end)
            --tag.triggered = true
            --return true
        --end 