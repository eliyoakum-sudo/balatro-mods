
SMODS.Joker{ --Petroglyph Joker
    key = "petroglyphjoker",
    config = {
        extra = {
            ancientshift = 1
        }
    },
    loc_txt = {
        ['name'] = 'Petroglyph Joker',
        ['text'] = {
            [1] = 'Combines the effects of {C:green}Ancient Joker{}',
            [2] = 'and {C:green}Smeared Joker.{}',
            [3] = '(Current suit: )'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = "braysjokers_unified",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["braysjokers_braysjokerswip_jokers"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.ancientshift, localize((G.GAME.current_round.smearhearts_card or {}).suit or 'Spades', 'suits_singular'), localize((G.GAME.current_round.smearspades_card or {}).suit or 'Spades', 'suits_singular')}, colours = {G.C.SUITS[(G.GAME.current_round.smearhearts_card or {}).suit or 'Spades'], G.C.SUITS[(G.GAME.current_round.smearspades_card or {}).suit or 'Spades']}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.smearhearts_card = { suit = 'Hearts' }
        G.GAME.current_round.smearspades_card = { suit = 'Spades' }
    end
}