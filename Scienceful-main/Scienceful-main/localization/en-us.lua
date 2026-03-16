return {
    descriptions = {
        Back = {

        },
        Blind = {
            bl_SM_the_variable= {
                name = "The Variable",
                text = {
                    "One random rank of the entire",
                    "deck disabled every hand"
                }
            },
        },
        Edition = {
            e_SM_definitive = {
                name = "Definitive",
                text = {
                    "Earn {C:money}$#2#{}",
                    "{C:inactive}(Gold value increases{}",
                    "{C:inactive}after the end of the round){}",
                },
            },
        },
        Enhanced = {
            m_SM_bloom_card = {
                name = "Bloom Card",
                text = {
                    "{C:green}#1# in #2#{} chance to copy",
                    "this card with a chance",
                    "of a random {C:attention}Edition{}/{C:attention}Seal{}"
                },
            },
            m_SM_cyber_card = {
                name = "Cyber Card",
                text = {
                    "Allows to {C:attention}increase{}/{C:attention}decrease{}",
                    "this card's rank by {C:attention}1{}",
                    "{C:inactive}(Can be used {C:attention}only once{} {C:inactive}per hand){}"
                }
            },
            m_SM_dirt_card = {
                name = "Dirt Card",
                text = {
                    "This card becomes",
                    "a {C:green}Bloom Card{} if held",
                    "in hand at end of round",
                    "no rank or suit"
                }
            },
            m_SM_electro_card = {
                name = "Electro Card",
                text = {
                    "{C:green}#1#{} in {C:green}#2#{} chance to retrigger",
                    "the {C:attention}adjacent{} scoring cards"
                }
            },
            m_SM_blue_chemical_card = {
                name = "Blue Chemical Card",
                text = {
                    "Gives a random amount",
                    "of {C:blue}Chips{} {C:inactive}(1-100){}",
                    "or {X:chips,C:white}XChips{} {C:inactive}(1-5){}",
                    "no rank or suit"
                }
            },
            m_SM_red_chemical_card = {
                name = "Red Chemical Card",
                text = {
                    "Gives a random amount",
                    "of {C:red}Mult{} {C:inactive}(1-15){}",
                    "or {X:mult,C:white}XMult{} {C:inactive}(1-5){}",
                    "no rank or suit"
                }
            },
            m_SM_green_chemical_card = {
                name = "Green Chemical Card",
                text = {
                    "Gives a random amount",
                    "of {C:money}${} {C:inactive}(1-15){}",
                    
                }
            },
            m_SM_purple_chemical_card = {
                name = "Purple Chemical Card",
                text = {
                    "While this card stays in",
                    "hand, gains a random amount",
                    "of {X:chips,C:white}XChips{} {C:inactive}(0.5-1.5){}",
                    "or {X:mult,C:white}XMult{} {C:inactive}(0.5-1.5){}",
                    "{C:green}#3# in #4#{} chance this card",
                    "is destroyed when played",
                    "no rank or suit",
                    "{C:inactive}(Currently{} {X:chips,C:white}X#1#{} {C:blue}Chips{}{C:inactive},{} {X:mult,C:white}X#2#{} {C:red}Mult{}{C:inactive}){}",
                }
            },
            m_SM_cyan_chemical_card = {
                name = "Cyan Chemical Card",
                text = {
                    "Gives {X:chips,C:white}Xchips{} of the half",
                    "of the current total {C:money}${}",
                    "While this card stays in hand",
                    "gives {C:money}${} equal to the {C:attention}#2#%{}",
                    "of the played hand's total {C:blue}Chips{}",
                    "{C:green}#3# in #4#{} chance this card is",
                    "destroyed at the end of the round",
                    "no rank or suit",
                    "{C:inactive}(Currently{} {X:chips,C:white}X#1#{} {C:blue}Chips{}{C:inactive}){}",
                }
            },
            m_SM_brown_chemical_card = {
                name = "Brown Chemical Card",
                text = {
                    "Drains {X:mult,C:white}Xmult{} of the {C:attention}#2#%{}",
                    "of the current total {C:money}${}",
                    "While this card stays in hand",
                    "gives {C:money}${} equal to the {C:attention}#2#%{}",
                    "of the played hand's total {C:red}Mult{}",
                    "{C:green}#3# in #4#{} chance this card",
                    "resets after being played",
                    "no rank or suit",
                    "{C:inactive}(Currently{} {X:mult,C:white}X#1#{} {C:red}Mult{}{C:inactive}){}",
                }
            },
            m_SM_test_card = {
                name = "Test Card",
                text = {
                    "Creates {C:attention}#1#{} random ",
                    "{C:dark_edition}Negative{} {C:attention}consumables{}",
                    "when this card is destroyed"
                }
            }
        },
        Joker = {
            j_SM_Scientist = {
                name = 'Scientist',
                text = {
                    "Gains {C:blue,s:1.1}+#1#{} Chips {C:green}or{} {C:red,s:1.1}+#2#{} Mult",
                    "for every {C:attention}consecutive poker{}",
                    "{C:attention}hand type{} played that was different",
                    "{C:attention}from the last{}, otherwise resets",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips and {C:mult}+#4#{C:inactive} Mult)",
                    "{C:inactive}(Previous hand:{} {C:attention}#5#{}{C:inactive}){}"
                },
            },
            j_SM_Chemist = {
                name = "Chemist",
                text = {
                    "Gives {C:green}a random number{}",
                    "between {C:blue}-10{} and {C:blue}+90{} Chips",
                    "if the scored hand {C:attention}has at least{}",
                    "{C:attention}2 cards with different suits{}",
                    "{C:inactive}(Previously given {C:chips}#1#{}{C:inactive} Chips)"
                },
            },
            j_SM_Physicist = {
                name = "Physicist",
                text = {
                    "Played cards give {X:chips,C:white}X1.3{} Chips when scored,",
                    "{C:red}loses{} {X:chips,C:white}X#2#{} Chips per {C:attention}card{} discarded.",
                    "Resets after {C:attention}the next played hand{}",
                    "{C:inactive}(Currently{} {X:chips,C:white}X#1#{} {C:inactive}){}"

                },
            },
            j_SM_Toxicologist = {
                name = "Toxicologist",
                text = {
                    "{C:red,s:1.1}+#1#{} Mult,",
                    "{C:attention}destroy{} adjacent jokers",
                    "on {C:attention}final hand{} of the round",
                    "Gives {C:red,s:1.1}+#2#{} Mult for",
                    "every joker {C:attention}destroyed{}",
                    "Resets at {C:attention}end{} of the round"
                },
            },
            j_SM_MarineBiologist = {
                name = "Marine biologist",
                text = {
                    "{C:red,s:1.1}+#1#{} Mult for every",
                    "scoring card with {C:attention}rank{}",
                    "{C:attention}less or equal than 6{},",
                    "otherwise {C:blue,s:1.1}+#2#{} Chips"
                },
            },
            j_SM_Mathematician = {
                name = "Mathematician",
                text = {
                    "Every played {C:attention}number card{}",
                    "permanently gains",
                    "{C:mult}+#1#{} Mult when scored",
                },
            },
            j_SM_Geometer = {
                name = "Geometer",
                text = {
                    "Played cards with {C:hearts}Heart{} or",
                    "{C:diamonds}Diamond{} suit give {X:mult,C:white}X#2#{} Mult,",
                    "played cards with {C:spades}Spade{} or",
                    "{C:clubs}Club{} suit give {X:chips,C:white}X#1#{} Chips",
                },
            },
            j_SM_Archaeologist = {
                name = "Archaeologist",
                text = {
                    "Create a {C:attention}random joker{}",
                    "{C:attention}previously owned{} when",
                    "{C:attention}boss blind{} is defeated",
                    "{C:inactive}(Must have room)",
                },
            },
            j_SM_Paleontologist = {
                name = "Paleontologist",
                text = {
                    "Played {C:attention}Stone Cards{} have",
                    "a {C:green}#1# in #2#{} chance to",
                    "create a {C:tarot}Tarot{} card",
                    "when scored",
                    "{C:inactive}(Must have room)",
                },
            },
            j_SM_Zoologist = {
                name = 'Zoologist',
                text = {
                    "Played {C:attention}Wild Cards{}",
                    "earn {C:money}$#1#{} when scored",
                },
            },
            j_SM_Anatomist = {
                name = "Anatomist",
                text = {
                    "This joker gains {C:red}+#2#{} Mult",
                    "for each played {C:attention}face card{}",
                    "with {C:red}heart{} suit after scoring",
                    "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)"
                },
            },
            j_SM_Botanist = {
                name = "Botanist",
                text = {
                    "Gives {C:blue}+#1#{} Chips and",
                    "{C:red}+#2#{} Mult for each",
                    "{C:attention}Bloom Card{} in your {C:attention}full deck{}",
                    "{C:inactive}(Currently {C:blue}+#3#{C:inactive} Chips, {C:red}+#4#{C:inactive} Mult)"
                },
            },
            j_SM_ComputerScientist = {
                name = "Computer Scientist",
                text = {
                    "If {C:attention}first discard{} of round",
                    "has only {C:attention}2{} cards, reduce",
                    "the current boss blind's",
                    "requirement by {C:attention}20%{}"
                },
            },
            j_SM_Meteorologist = {
                name = "Meteorologist",
                text = {
                    "Reveals the next drawn 5 cards"
                },
            },
            j_SM_Geologist = {
                name = "Geologist",
                text = {
                    "Retriggers {C:attention}Stone cards{}"
                },
            },
            j_SM_Assistant = {
                name = "Assistant",
                text = {
                    "{C:attention}+#1#{} consumable slots"
                },
            },
            j_SM_FirstLawOfInertia = {
                name = "First law of Inertia",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult per hand played",
                    "loses {X:mult,C:white}X#2#{} Mult per discard",
                    "{C:inactive}(Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult){}"
                },
            },
            j_SM_DiscoveryChannel = {
                name = "Discovery Channel",
                text = {
                    "{C:blue}+#1#{} Chips for",
                    "each {C:attention}Joker{} card",
                    "{C:inactive}(Currently{} {C:blue}+#2#{} {C:inactive}Chips){}"
                },
            },
            j_SM_AccessCard = {
                name = "Access Card",
                text = {
                    "Creates a random {C:attention}tag{}",
                    "at the end of the round",
                },
            },
            j_SM_Concentric = {
                name = "Concentric Joker",
                text = {
                    "{C:red}+#1#{} Mult for each {C:attention}Joker{}",
                    "card with an {C:attention}Edition{}",
                    "{C:green}#3#{} in {C:green}#4#{} chance to",
                    "apply a random {C:attention}Edition{} to",
                    "a random {C:attention}Joker{} card",
                    "when {C:attention}Boss Blind{} is defeated",
                    "{C:inactive}(Currently{} {C:red}+#2#{} {C:inactive}Mult){}",
                },
            },
            j_SM_CommutativeProperty = {
                name = "Commutative Property",
                text = {
                    "Makes the sum of {C:blue}Chips{} and",
                    "{C:red}Mult{} scored by {C:attention}Playing cards{}",
                    "and gives the total in {C:red}Mult{}",
                    "if played hand contains a {C:attention}Two Pair{}"
                },
            },
            j_SM_MysteriousConcotion = {
                name = "Mysterious concotion",
                text = {
                    "For the next {C:attention}#5#{} hands",
                    "{C:green}randomly picks{} from",
                    "{C:red,s:1.1}+#1#{} Mult, {C:blue,s:1.1}+#2#{} Chips,",
                    "{X:mult,C:white}X#3#{} Mult, {X:chips,C:white}X#4#{} Chips,",
                    "or sets {C:red}Mult{} and {C:blue}chips{} to 0"
                },
            },
            j_SM_RelativityFormula = {
                name = "Relativity formula",
                text = {
                    "If the total of {C:blue}Chips{} is superior to",
                    "{C:red}Mult{} subtract the {C:attention}5%{} of total",
                    "{C:blue}Chips{}, raise subtracted value to {X:mult,C:white}^2{}",
                    "and add it to the {C:red}Mult{}",
                    "{C:inactive}(The same process happens but Chips and Mult{}",
                    "{C:inactive}inverted if the total of Mult is superior to Chips){}",

                },
            },
            j_SM_TeachersPet = {
                name = "Teacher's pet",
                text = {
                    "Each played {C:attention}10{}, {C:attention}9{} or {C:attention}8{}",
                    "give {C:blue}+#1#{} Chips, {C:red}+#2#{} Mult",
                    "and {X:mult,C:white}X#3#{} Mult"

                },
            },
            j_SM_PrimeNumbers = {
                name = "Prime Numbers",
                text = {
                    "Played cards with",
                    "{C:attention}prime number{} rank",
                    "give {C:blue}+#1#{} Chips when scored",
                    "{C:inactive}(7, 5, 3, 2){}"

                },
            },
            j_SM_BristleMouth = {
                name = "Bristlemouth",
                text = {
                    "{C:blue}Common{} {C:attention}Jokers{} and",
                    "{C:tarot}Tarot{} cards may appear",
                    "in the shop multiple times"

                },
            },
            j_SM_TrialAndError = {
                name = "Trial and Error",
                text = {
                    "Unscored {C:attention}Playing Cards{} have",
                    "a {C:green}#1# in #2#{} chance to",
                    "be {C:attention}destroyed{}"
                },
            },
            j_SM_TunaSandwich = {
                name = "Tuna Sandwich",
                text = {
                    "For the next {C:attention}#2#{} rounds,",
                    "draw {C:attention}3{} more cards of",
                    "the same rank if possible",
                },
            },
            j_SM_Fertilizer = {
                name = "Fertilizer",
                text = {
                    "{C:attention}Dirt{} Cards",
                    "give {C:red}+#1#{} Mult,",
                    "and become {C:green}Bloom{}",
                    "Cards after scoring"
                },
            },
            j_SM_PlutoniumRod = {
                name = "Plutonium Rod",
                text = {
                    "Level up played {C:attention}#1#s{} and {C:attention}retrigger{}",
                    "all played cards {C:attention}#2#{} times",
                    "{C:green}#3#{} in {C:green}#4#{} chance to set money to be ",
                    "negative or {C:red}lose immediately the run{}",
                    "{C:inactive,s:0.8}I hope you'll check the odds{}",
                    "{C:inactive,s:0.8}at the end of each round...{}"
                },
            },
            j_SM_Prospective = {
                name = "Prospective Joker",
                text = {
                    "When a blind is defeated",
                    "in the {C:attention}first{} hand of",
                    "the round, increase by {C:attention}1{}",
                    " all {C:attention}listed{} {C:green,E:1,S:1.1}probabilities{}",
                    "otherwise resets",
                    "{C:inactive}(ex:{} {C:green}1 in 3{} {C:inactive}->{} {C:green}2 in 3{}{C:inactive}){}"
                },
            },
        },
        Other = {
            SM_credits = {
                name = "",
                text = {
                    " ",
                    "Special thanks to:",
                    " ",
                    "For additional help in lua coding",
                    "@N'",
                    "@BepisFever",
                    "@Somethingcom",
                    "@Revo",
                    "@Toga",
                    "@Aikoyori",
                    " ",
                    "For respriting Botanist joker's sprite",
                    "@Secun",
                },
            },
            SM_secun = {
                name = "Resprite",
                text = {
                    "made by @secun",
                },
            },
            SM_previously_owned = {
                name = "Previosly owned",
                text = {
                    "{C:attention}destroyed{} or {C:attention}sold{}"
                },
            },
            p_SM_smart_pack_normal = {
                name="Smart Pack",
                text={
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:purple}Scienceful{} cards",
                },
            },
            p_SM_experimentum_pack_normal = {
                name="Experimentum Pack",
                text={
                    "Choose {C:attention}#1#{} of up to {C:attention}#2#{} ",
                    "{C:purple}Experimentum{} cards",
                    "to be used immediately",
                },
            },
            undiscovered_experimentum = {
                name="Not Discovered",
                text={
                    "Purchase or use",
                    "this card in an",
                    "unseeded run to",
                    "learn what it does",
                },
            },
        },
        Planet = {

        },
        Spectral = {

        },
        Stake = {

        },
        Tag = {
            tag_SM_scienceful_tag={
                name="Scienceful Tag",
                text={
                    "Shop has a free",
                    "{C:purple}Scienceful{} Joker",
                },
            },
        },        
        Tarot = {

        },
        Voucher = {
            v_SM_additional_load={
                name="Additional Load",
                text={
                    "{C:attention}+#1#{} Booster pack slot"
                },
            },
            v_SM_additional_load_plus={
                name="Additional Load Plus",
                text={
                    "{C:attention}+#1#{} Booster pack slot",
                    "packs in the shop cost {C:money}#2#${} less"
                },
            },
        },
        Experimentum = {
            c_SM_soil_genesis = {
                name="Soil Genesis",
				text = {
                    "Enhances {C:attention}#1#{} selected cards",
                    "into {C:attention}Dirt{} Cards"
				},
            },
            c_SM_technology = {
                name="Technology",
				text = {
                    "Enhances {C:attention}#1#{} selected card",
                    "into a {C:attention}Cyber{} Card"
				},
            },
            c_SM_charge = {
                name="Charge",
				text = {
                    "Enhances {C:attention}#1#{} selected card",
                    "into an {C:attention}Electro{} Card"
				},
            },
            c_SM_substance = {
                name="Substance",
				text = {
                    "Enhances {C:attention}#1#{} selected card",
                    "into a random {C:attention}Chemical{} Card"
				},
            },
            c_SM_check = {
                name="Check",
				text = {
                    "Enhances {C:attention}#1#{} selected card",
                    "into a {C:attention}Test{} Card"
				},
            },
            c_SM_traits = {
                name="Traits",
				text = {
                    "Select up to 3 {C:attention}playing{} cards,",
                    "all selected cards copy the",
                    "{C:attention}leftmost{} card's {C:attention}enhancement{}"
				},
            },
            c_SM_mix = {
                name="Mix",
				text = {
                    "Mix 2 {C:attention}Chemical{} cards,",
                    "to get 1 better {C:attention}Chemical{} card",
				},
            },
        }
    },
    misc = {
        challenge_names = {

        },
        dictionary = {

            k_SM_author = "Pumpkin man",
            k_SM_credits = "Credits",

            b_experimentum_cards = "Experimentum Cards",
            k_experimentum = "Experimentum Card",

            k_SM_scienceful = "Scienceful",
            k_SM_smart_pack = "Smart Pack",
            k_SM_experimentum_pack = "Experimentum Pack",

            -- joker messages
            k_SM_upgrade_chips = "Upgrade chips!",
            k_SM_upgrade_mult = "Upgrade mult!",
            k_SM_nah = "Nah...",
            k_SM_recharge = "Recharge!",
            k_SM_radiations = "Radiations!",
            k_SM_debuff = "Debuff!",
            k_SM_ohNo = "Oh no!",
            k_SM_relativity = "Relativity!",
            k_SM_fertilize = "Fertilize!",
            k_SM_aTie = "A tie!?!'",
            k_SM_fail = "FAIL",
            k_SM_careful = "Careful...",

            --enhancements messages
            k_SM_bloom = "Bloom!",
            k_SM_dissolved = "Dissolved!",
        },
        labels = {
            SM_definitive = "Definitive",
            Experimentum = "Experimentum"
        },
        ranks = {

        },
        suits_plural = {

        },
        suits_singular = {

        },
    },
}