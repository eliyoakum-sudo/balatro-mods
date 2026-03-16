
SMODS.Joker{ --Banking Joker
    key = "bankingjoker",
    config = {
        extra = {
            pb_mult_c3e48110 = 1,
            perma_mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Banking Joker',
        ['text'] = {
            [1] = 'Deposits {C:red}+1{} {C:red}Mult{} into each card played.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokerswip_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + 1
            return {
                extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT }, card = card
            }
        end
    end
}