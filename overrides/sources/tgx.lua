local FILE_NAME_MAPPING = {
  ["gfx\\1280r.tgx"] = "gfx_1280r",
  ["gfx\\anim_stocks.tgx"] = "gfx_anim_stocks",
  ["gfx\\armourer_sketch.tgx"] = "gfx_armourer_sketch",
  ["gfx\\army.tgx"] = "gfx_army",
  ["gfx\\army2.tgx"] = "gfx_army2",
  ["gfx\\armybar.tgx"] = "gfx_armybar",
  ["gfx\\armylbd.tgx"] = "gfx_armylbd",
  ["gfx\\armyrbd.tgx"] = "gfx_armyrbd",
  ["gfx\\armys1.tgx"] = "gfx_armys1",
  ["gfx\\armys10.tgx"] = "gfx_armys10",
  ["gfx\\armys11.tgx"] = "gfx_armys11",
  ["gfx\\armys12.tgx"] = "gfx_armys12",
  ["gfx\\armys13.tgx"] = "gfx_armys13",
  ["gfx\\armys14.tgx"] = "gfx_armys14",
  ["gfx\\armys15.tgx"] = "gfx_armys15",
  ["gfx\\armys16.tgx"] = "gfx_armys16",
  ["gfx\\armys17.tgx"] = "gfx_armys17",
  ["gfx\\armys18.tgx"] = "gfx_armys18",
  ["gfx\\armys19.tgx"] = "gfx_armys19",
  ["gfx\\armys2.tgx"] = "gfx_armys2",
  ["gfx\\armys20.tgx"] = "gfx_armys20",
  ["gfx\\armys21.tgx"] = "gfx_armys21",
  ["gfx\\armys22.tgx"] = "gfx_armys22",
  ["gfx\\armys23.tgx"] = "gfx_armys23",
  ["gfx\\armys24.tgx"] = "gfx_armys24",
  ["gfx\\armys25.tgx"] = "gfx_armys25",
  ["gfx\\armys26.tgx"] = "gfx_armys26",
  ["gfx\\armys3.tgx"] = "gfx_armys3",
  ["gfx\\armys4.tgx"] = "gfx_armys4",
  ["gfx\\armys5.tgx"] = "gfx_armys5",
  ["gfx\\armys6.tgx"] = "gfx_armys6",
  ["gfx\\armys7.tgx"] = "gfx_armys7",
  ["gfx\\armys8.tgx"] = "gfx_armys8",
  ["gfx\\armys9.tgx"] = "gfx_armys9",
  ["gfx\\armysbar.tgx"] = "gfx_armysbar",
  ["gfx\\army_sketch.tgx"] = "gfx_army_sketch",
  ["gfx\\attacking_units.tgx"] = "gfx_attacking_units",
  ["gfx\\bakery_sketch.tgx"] = "gfx_bakery_sketch",
  ["gfx\\baker_sketch.tgx"] = "gfx_baker_sketch",
  ["gfx\\bink256.tgx"] = "gfx_bink256",
  ["gfx\\black.tgx"] = "gfx_black",
  ["gfx\\blacksmith_sketch.tgx"] = "gfx_blacksmith_sketch",
  ["gfx\\bmonk.tgx"] = "gfx_bmonk",
  ["gfx\\boiling_oil_help.tgx"] = "gfx_boiling_oil_help",
  ["gfx\\brazier.tgx"] = "gfx_brazier",
  ["gfx\\brewer_sketch.tgx"] = "gfx_brewer_sketch",
  ["gfx\\briefing_back0.tgx"] = "gfx_briefing_back0",
  ["gfx\\briefing_back1.tgx"] = "gfx_briefing_back1",
  ["gfx\\briefing_back10.tgx"] = "gfx_briefing_back10",
  ["gfx\\briefing_back11.tgx"] = "gfx_briefing_back11",
  ["gfx\\briefing_back12.tgx"] = "gfx_briefing_back12",
  ["gfx\\briefing_back2.tgx"] = "gfx_briefing_back2",
  ["gfx\\briefing_back3.tgx"] = "gfx_briefing_back3",
  ["gfx\\briefing_back4.tgx"] = "gfx_briefing_back4",
  ["gfx\\briefing_back5.tgx"] = "gfx_briefing_back5",
  ["gfx\\briefing_back6.tgx"] = "gfx_briefing_back6",
  ["gfx\\briefing_back7.tgx"] = "gfx_briefing_back7",
  ["gfx\\briefing_back8.tgx"] = "gfx_briefing_back8",
  ["gfx\\briefing_back9.tgx"] = "gfx_briefing_back9",
  ["gfx\\briefing_screen_background.tgx"] = "gfx_briefing_screen_background",
  ["gfx\\bsmith_sketch.tgx"] = "gfx_bsmith_sketch",
  ["gfx\\building_siege_equipment_help.tgx"] = "gfx_building_siege_equipment_help",
  ["gfx\\bullet.tgx"] = "gfx_bullet",
  ["gfx\\bullet2.tgx"] = "gfx_bullet2",
  ["gfx\\buyit_logo.tgx"] = "gfx_buyit_logo",
  ["gfx\\c1pic.tgx"] = "gfx_c1pic",
  ["gfx\\c2pic.tgx"] = "gfx_c2pic",
  ["gfx\\c3pic.tgx"] = "gfx_c3pic",
  ["gfx\\c4pic.tgx"] = "gfx_c4pic",
  ["gfx\\campfire_sketch.tgx"] = "gfx_campfire_sketch",
  ["gfx\\cess_pit_sketch.tgx"] = "gfx_cess_pit_sketch",
  ["gfx\\chartest.tgx"] = "gfx_chartest",
  ["gfx\\chicken_sketch.tgx"] = "gfx_chicken_sketch",
  ["gfx\\child_sketch.tgx"] = "gfx_child_sketch",
  ["gfx\\chimp00_null.tgx"] = "gfx_chimp00_null",
  ["gfx\\chimp05_tunneler.tgx"] = "gfx_chimp05_tunneler",
  ["gfx\\chimp22_archer.tgx"] = "gfx_chimp22_archer",
  ["gfx\\chimp23_xbowman.tgx"] = "gfx_chimp23_xbowman",
  ["gfx\\chimp24_spearman.tgx"] = "gfx_chimp24_spearman",
  ["gfx\\chimp25_pikeman.tgx"] = "gfx_chimp25_pikeman",
  ["gfx\\chimp26_maceman.tgx"] = "gfx_chimp26_maceman",
  ["gfx\\chimp27_swordsman.tgx"] = "gfx_chimp27_swordsman",
  ["gfx\\chimp28_knight.tgx"] = "gfx_chimp28_knight",
  ["gfx\\chimp29_ladderman.tgx"] = "gfx_chimp29_ladderman",
  ["gfx\\chimp30_engineer.tgx"] = "gfx_chimp30_engineer",
  ["gfx\\chimp37_monk.tgx"] = "gfx_chimp37_monk",
  ["gfx\\chimp39_catapult.tgx"] = "gfx_chimp39_catapult",
  ["gfx\\chimp40_trebuchet.tgx"] = "gfx_chimp40_trebuchet",
  ["gfx\\chimp41_mangonel.tgx"] = "gfx_chimp41_mangonel",
  ["gfx\\chimp55_lord.tgx"] = "gfx_chimp55_lord",
  ["gfx\\chimp58_siege_tower.tgx"] = "gfx_chimp58_siege_tower",
  ["gfx\\chimp59_battering_ram.tgx"] = "gfx_chimp59_battering_ram",
  ["gfx\\chimp60_portable_shield.tgx"] = "gfx_chimp60_portable_shield",
  ["gfx\\chimp61_ballista.tgx"] = "gfx_chimp61_ballista",
  ["gfx\\chimp70_arabian_bow.tgx"] = "gfx_chimp70_arabian_bow",
  ["gfx\\chimp71_slave.tgx"] = "gfx_chimp71_slave",
  ["gfx\\chimp72_slinger.tgx"] = "gfx_chimp72_slinger",
  ["gfx\\chimp73_assassin.tgx"] = "gfx_chimp73_assassin",
  ["gfx\\chimp74_horse_archer.tgx"] = "gfx_chimp74_horse_archer",
  ["gfx\\chimp75_arabian_swordman.tgx"] = "gfx_chimp75_arabian_swordman",
  ["gfx\\chimp75_arabian_swordsman.tgx"] = "gfx_chimp75_arabian_swordsman",
  ["gfx\\chimp76_fire_thrower.tgx"] = "gfx_chimp76_fire_thrower",
  ["gfx\\chimp77_fire_ballista.tgx"] = "gfx_chimp77_fire_ballista",
  ["gfx\\chopping_block_sketch.tgx"] = "gfx_chopping_block_sketch",
  ["gfx\\churchs.tgx"] = "gfx_churchs",
  ["gfx\\church_sketch.tgx"] = "gfx_church_sketch",
  ["gfx\\concept01_popularity.tgx"] = "gfx_concept01_popularity",
  ["gfx\\concept02_crowding.tgx"] = "gfx_concept02_crowding",
  ["gfx\\concept03_fear_factor.tgx"] = "gfx_concept03_fear_factor",
  ["gfx\\concept04_food.tgx"] = "gfx_concept04_food",
  ["gfx\\concept05_religion.tgx"] = "gfx_concept05_religion",
  ["gfx\\concept06_tax.tgx"] = "gfx_concept06_tax",
  ["gfx\\concept07_travelling_fairs.tgx"] = "gfx_concept07_travelling_fairs",
  ["gfx\\concept08_working_inns.tgx"] = "gfx_concept08_working_inns",
  ["gfx\\contents01_contents.tgx"] = "gfx_contents01_contents",
  ["gfx\\contents02_castle_buildings.tgx"] = "gfx_contents02_castle_buildings",
  ["gfx\\contents03_farm_buildings.tgx"] = "gfx_contents03_farm_buildings",
  ["gfx\\contents04_food_proc_buildings.tgx"] = "gfx_contents04_food_proc_buildings",
  ["gfx\\contents05_industry_buildings.tgx"] = "gfx_contents05_industry_buildings",
  ["gfx\\contents06_key_concepts.tgx"] = "gfx_contents06_key_concepts",
  ["gfx\\contents07_town_buildings.tgx"] = "gfx_contents07_town_buildings",
  ["gfx\\contents08_military_units.tgx"] = "gfx_contents08_military_units",
  ["gfx\\contents09_weapon_buildings.tgx"] = "gfx_contents09_weapon_buildings",
  ["gfx\\contents10_siege_engines.tgx"] = "gfx_contents10_siege_engines",
  ["gfx\\corpyright.tgx"] = "gfx_corpyright",
  ["gfx\\credits.tgx"] = "gfx_credits",
  ["gfx\\credits_1.tgx"] = "gfx_credits_1",
  ["gfx\\credits_2.tgx"] = "gfx_credits_2",
  ["gfx\\credits_3.tgx"] = "gfx_credits_3",
  ["gfx\\credits_4.tgx"] = "gfx_credits_4",
  ["gfx\\crenulated_walls_help.tgx"] = "gfx_crenulated_walls_help",
  ["gfx\\crossbowman_sketch.tgx"] = "gfx_crossbowman_sketch",
  ["gfx\\crusader_win.tgx"] = "gfx_crusader_win",
  ["gfx\\dairy_sketch.tgx"] = "gfx_dairy_sketch",
  ["gfx\\dancing_bear_sketch.tgx"] = "gfx_dancing_bear_sketch",
  ["gfx\\demo_assassin_last_frame.tgx"] = "gfx_demo_assassin_last_frame",
  ["gfx\\demo_back.tgx"] = "gfx_demo_back",
  ["gfx\\demo_big_richard.tgx"] = "gfx_demo_big_richard",
  ["gfx\\demo_big_saladin.tgx"] = "gfx_demo_big_saladin",
  ["gfx\\demo_saladin.tgx"] = "gfx_demo_saladin",
  ["gfx\\digging_moats_help.tgx"] = "gfx_digging_moats_help",
  ["gfx\\digging_tunnels_help.tgx"] = "gfx_digging_tunnels_help",
  ["gfx\\dog_cage_sketch.tgx"] = "gfx_dog_cage_sketch",
  ["gfx\\drunk_sketch.tgx"] = "gfx_drunk_sketch",
  ["gfx\\ducking_stool_sketch.tgx"] = "gfx_ducking_stool_sketch",
  ["gfx\\dungeon_sketch.tgx"] = "gfx_dungeon_sketch",
  ["gfx\\edge1024l.tgx"] = "gfx_edge1024l",
  ["gfx\\edge1024r.tgx"] = "gfx_edge1024r",
  ["gfx\\edge1280l.tgx"] = "gfx_edge1280l",
  ["gfx\\edge1280r.tgx"] = "gfx_edge1280r",
  ["gfx\\edge1360l.tgx"] = "gfx_edge1360l",
  ["gfx\\edge1360r.tgx"] = "gfx_edge1360r",
  ["gfx\\edge1366l.tgx"] = "gfx_edge1366l",
  ["gfx\\edge1366r.tgx"] = "gfx_edge1366r",
  ["gfx\\edge1440l.tgx"] = "gfx_edge1440l",
  ["gfx\\edge1440r.tgx"] = "gfx_edge1440r",
  ["gfx\\edge1600l.tgx"] = "gfx_edge1600l",
  ["gfx\\edge1600r.tgx"] = "gfx_edge1600r",
  ["gfx\\edge1680l.tgx"] = "gfx_edge1680l",
  ["gfx\\edge1680r.tgx"] = "gfx_edge1680r",
  ["gfx\\edge1920l.tgx"] = "gfx_edge1920l",
  ["gfx\\edge1920r.tgx"] = "gfx_edge1920r",
  ["gfx\\edge2560l.tgx"] = "gfx_edge2560l",
  ["gfx\\edge2560r.tgx"] = "gfx_edge2560r",
  ["gfx\\edge_military_1024l.tgx"] = "gfx_edge_military_1024l",
  ["gfx\\edge_military_1024r.tgx"] = "gfx_edge_military_1024r",
  ["gfx\\edge_military_1280l.tgx"] = "gfx_edge_military_1280l",
  ["gfx\\edge_military_1280r.tgx"] = "gfx_edge_military_1280r",
  ["gfx\\edge_military_1360l.tgx"] = "gfx_edge_military_1360l",
  ["gfx\\edge_military_1360r.tgx"] = "gfx_edge_military_1360r",
  ["gfx\\edge_military_1366l.tgx"] = "gfx_edge_military_1366l",
  ["gfx\\edge_military_1366r.tgx"] = "gfx_edge_military_1366r",
  ["gfx\\edge_military_1440l.tgx"] = "gfx_edge_military_1440l",
  ["gfx\\edge_military_1440r.tgx"] = "gfx_edge_military_1440r",
  ["gfx\\edge_military_1600l.tgx"] = "gfx_edge_military_1600l",
  ["gfx\\edge_military_1600r.tgx"] = "gfx_edge_military_1600r",
  ["gfx\\edge_military_1680l.tgx"] = "gfx_edge_military_1680l",
  ["gfx\\edge_military_1680r.tgx"] = "gfx_edge_military_1680r",
  ["gfx\\edge_military_1920l.tgx"] = "gfx_edge_military_1920l",
  ["gfx\\edge_military_1920r.tgx"] = "gfx_edge_military_1920r",
  ["gfx\\edge_military_2560l.tgx"] = "gfx_edge_military_2560l",
  ["gfx\\edge_military_2560r.tgx"] = "gfx_edge_military_2560r",
  ["gfx\\endframe1.tgx"] = "gfx_endframe1",
  ["gfx\\endframe2.tgx"] = "gfx_endframe2",
  ["gfx\\endframe3.tgx"] = "gfx_endframe3",
  ["gfx\\endframe4.tgx"] = "gfx_endframe4",
  ["gfx\\endframe5.tgx"] = "gfx_endframe5",
  ["gfx\\endframe6.tgx"] = "gfx_endframe6",
  ["gfx\\endframe7.tgx"] = "gfx_endframe7",
  ["gfx\\endframe8.tgx"] = "gfx_endframe8",
  ["gfx\\farmer_sketch.tgx"] = "gfx_farmer_sketch",
  ["gfx\\fearfactor_sketch.tgx"] = "gfx_fearfactor_sketch",
  ["gfx\\fearfneg.tgx"] = "gfx_fearfneg",
  ["gfx\\fearfpos.tgx"] = "gfx_fearfpos",
  ["gfx\\filling_moats_help.tgx"] = "gfx_filling_moats_help",
  ["gfx\\firefly-small.tgx"] = "gfx_firefly-small",
  ["gfx\\firefly_logo.tgx"] = "gfx_firefly_logo",
  ["gfx\\firewatch_sketch.tgx"] = "gfx_firewatch_sketch",
  ["gfx\\fletcher_building_sketch.tgx"] = "gfx_fletcher_building_sketch",
  ["gfx\\fletcher_sketch.tgx"] = "gfx_fletcher_sketch",
  ["gfx\\food_sketch.tgx"] = "gfx_food_sketch",
  ["gfx\\fred_natural0108.tgx"] = "gfx_fred_natural0108",
  ["gfx\\frontend_builder.tgx"] = "gfx_frontend_builder",
  ["gfx\\frontend_builder2.tgx"] = "gfx_frontend_builder2",
  ["gfx\\frontend_combat.tgx"] = "gfx_frontend_combat",
  ["gfx\\frontend_combat2.tgx"] = "gfx_frontend_combat2",
  ["gfx\\frontend_combat3.tgx"] = "gfx_frontend_combat3",
  ["gfx\\frontend_economics2.tgx"] = "gfx_frontend_economics2",
  ["gfx\\frontend_loading.tgx"] = "gfx_frontend_loading",
  ["gfx\\frontend_loading_ex.tgx"] = "gfx_frontend_loading_ex",
  ["gfx\\frontend_main.tgx"] = "gfx_frontend_main",
  ["gfx\\frontend_main2.tgx"] = "gfx_frontend_main2",
  ["gfx\\frontend_main_extreme.tgx"] = "gfx_frontend_main_extreme",
  ["gfx\\front_firefly_logo.tgx"] = "gfx_front_firefly_logo",
  ["gfx\\fruit_sketch.tgx"] = "gfx_fruit_sketch",
  ["gfx\\gallows_sketch.tgx"] = "gfx_gallows_sketch",
  ["gfx\\gardens_sketch.tgx"] = "gfx_gardens_sketch",
  ["gfx\\ghost_sketch.tgx"] = "gfx_ghost_sketch",
  ["gfx\\gibbet_sketch.tgx"] = "gfx_gibbet_sketch",
  ["gfx\\godgames_logo.tgx"] = "gfx_godgames_logo",
  ["gfx\\hand_lft.tgx"] = "gfx_hand_lft",
  ["gfx\\hand_lft_ro.tgx"] = "gfx_hand_lft_ro",
  ["gfx\\hand_rt.tgx"] = "gfx_hand_rt",
  ["gfx\\hand_rt_ro.tgx"] = "gfx_hand_rt_ro",
  ["gfx\\heads_on_spikes_sketch.tgx"] = "gfx_heads_on_spikes_sketch",
  ["gfx\\healers_sketch.tgx"] = "gfx_healers_sketch",
  ["gfx\\healer_sketch.tgx"] = "gfx_healer_sketch",
  ["gfx\\hop_sketch.tgx"] = "gfx_hop_sketch",
  ["gfx\\house_sketch.tgx"] = "gfx_house_sketch",
  ["gfx\\hunter_hut_sketch.tgx"] = "gfx_hunter_hut_sketch",
  ["gfx\\hunter_sketch.tgx"] = "gfx_hunter_sketch",
  ["gfx\\innkeeper_sketch.tgx"] = "gfx_innkeeper_sketch",
  ["gfx\\inn_sketch.tgx"] = "gfx_inn_sketch",
  ["gfx\\interface_edge1280r.tgx"] = "gfx_interface_edge1280r",
  ["gfx\\iron_miner_sketch.tgx"] = "gfx_iron_miner_sketch",
  ["gfx\\iron_sketch.tgx"] = "gfx_iron_sketch",
  ["gfx\\jester.tgx"] = "gfx_jester",
  ["gfx\\jesterlast.tgx"] = "gfx_jesterlast",
  ["gfx\\jester_sketch.tgx"] = "gfx_jester_sketch",
  ["gfx\\keep_sketch.tgx"] = "gfx_keep_sketch",
  ["gfx\\killing_pits_sketch.tgx"] = "gfx_killing_pits_sketch",
  ["gfx\\king.tgx"] = "gfx_king",
  ["gfx\\logo1.tgx"] = "gfx_logo1",
  ["gfx\\logo2.tgx"] = "gfx_logo2",
  ["gfx\\logo2_old.tgx"] = "gfx_logo2_old",
  ["gfx\\logo_280x100.tgx"] = "gfx_logo_280x100",
  ["gfx\\logo_bink.tgx"] = "gfx_logo_bink",
  ["gfx\\logo_bink_glow.tgx"] = "gfx_logo_bink_glow",
  ["gfx\\logo_bradygames.tgx"] = "gfx_logo_bradygames",
  ["gfx\\logo_bradygames_glow.tgx"] = "gfx_logo_bradygames_glow",
  ["gfx\\logo_buy_it.tgx"] = "gfx_logo_buy_it",
  ["gfx\\logo_buy_it_glow.tgx"] = "gfx_logo_buy_it_glow",
  ["gfx\\logo_crusader.tgx"] = "gfx_logo_crusader",
  ["gfx\\logo_crusader_glow.tgx"] = "gfx_logo_crusader_glow",
  ["gfx\\logo_firefly.tgx"] = "gfx_logo_firefly",
  ["gfx\\logo_firefly_glow.tgx"] = "gfx_logo_firefly_glow",
  ["gfx\\logo_gathering.tgx"] = "gfx_logo_gathering",
  ["gfx\\logo_gathering_glow.tgx"] = "gfx_logo_gathering_glow",
  ["gfx\\logo_godgames.tgx"] = "gfx_logo_godgames",
  ["gfx\\logo_miles.tgx"] = "gfx_logo_miles",
  ["gfx\\logo_miles_glow.tgx"] = "gfx_logo_miles_glow",
  ["gfx\\logo_ratings.tgx"] = "gfx_logo_ratings",
  ["gfx\\logo_teen.tgx"] = "gfx_logo_teen",
  ["gfx\\logo_teen_glow.tgx"] = "gfx_logo_teen_glow",
  ["gfx\\lose_screen_arab.tgx"] = "gfx_lose_screen_arab",
  ["gfx\\lose_screen_crusader.tgx"] = "gfx_lose_screen_crusader",
  ["gfx\\m10map.tgx"] = "gfx_m10map",
  ["gfx\\m11map.tgx"] = "gfx_m11map",
  ["gfx\\m12map.tgx"] = "gfx_m12map",
  ["gfx\\m13map.tgx"] = "gfx_m13map",
  ["gfx\\m14map.tgx"] = "gfx_m14map",
  ["gfx\\m15map.tgx"] = "gfx_m15map",
  ["gfx\\m16map.tgx"] = "gfx_m16map",
  ["gfx\\m17map.tgx"] = "gfx_m17map",
  ["gfx\\m18map.tgx"] = "gfx_m18map",
  ["gfx\\m19map.tgx"] = "gfx_m19map",
  ["gfx\\m1map.tgx"] = "gfx_m1map",
  ["gfx\\m1pic.tgx"] = "gfx_m1pic",
  ["gfx\\m1picb.tgx"] = "gfx_m1picb",
  ["gfx\\m20map.tgx"] = "gfx_m20map",
  ["gfx\\m2map.tgx"] = "gfx_m2map",
  ["gfx\\m2pic.tgx"] = "gfx_m2pic",
  ["gfx\\m3map.tgx"] = "gfx_m3map",
  ["gfx\\m3pic.tgx"] = "gfx_m3pic",
  ["gfx\\m4map.tgx"] = "gfx_m4map",
  ["gfx\\m4pic.tgx"] = "gfx_m4pic",
  ["gfx\\m5map.tgx"] = "gfx_m5map",
  ["gfx\\m6map.tgx"] = "gfx_m6map",
  ["gfx\\m7map.tgx"] = "gfx_m7map",
  ["gfx\\m8map.tgx"] = "gfx_m8map",
  ["gfx\\m9map.tgx"] = "gfx_m9map",
  ["gfx\\mapedge1024l.tgx"] = "gfx_mapedge1024l",
  ["gfx\\mapedge1024r.tgx"] = "gfx_mapedge1024r",
  ["gfx\\mapedge1280l.tgx"] = "gfx_mapedge1280l",
  ["gfx\\mapedge1280r.tgx"] = "gfx_mapedge1280r",
  ["gfx\\maypole_sketch.tgx"] = "gfx_maypole_sketch",
  ["gfx\\miles.tgx"] = "gfx_miles",
  ["gfx\\mill_sketch.tgx"] = "gfx_mill_sketch",
  ["gfx\\mother_sketch.tgx"] = "gfx_mother_sketch",
  ["gfx\\movie_frame.tgx"] = "gfx_movie_frame",
  ["gfx\\moving_units.tgx"] = "gfx_moving_units",
  ["gfx\\null_chimp_sketch.tgx"] = "gfx_null_chimp_sketch",
  ["gfx\\null_sketch.tgx"] = "gfx_null_sketch",
  ["gfx\\oil_smelter_sketch.tgx"] = "gfx_oil_smelter_sketch",
  ["gfx\\open_book.tgx"] = "gfx_open_book",
  ["gfx\\opp1.tgx"] = "gfx_opp1",
  ["gfx\\opp2.tgx"] = "gfx_opp2",
  ["gfx\\opp3.tgx"] = "gfx_opp3",
  ["gfx\\opp4.tgx"] = "gfx_opp4",
  ["gfx\\opp5.tgx"] = "gfx_opp5",
  ["gfx\\opp6.tgx"] = "gfx_opp6",
  ["gfx\\opp7.tgx"] = "gfx_opp7",
  ["gfx\\ox_tether_sketch.tgx"] = "gfx_ox_tether_sketch",
  ["gfx\\p1.tgx"] = "gfx_p1",
  ["gfx\\p2.tgx"] = "gfx_p2",
  ["gfx\\p3.tgx"] = "gfx_p3",
  ["gfx\\p4.tgx"] = "gfx_p4",
  ["gfx\\page1.tgx"] = "gfx_page1",
  ["gfx\\pbutt.tgx"] = "gfx_pbutt",
  ["gfx\\pbutt2.tgx"] = "gfx_pbutt2",
  ["gfx\\pc0.tgx"] = "gfx_pc0",
  ["gfx\\pc1.tgx"] = "gfx_pc1",
  ["gfx\\pc2.tgx"] = "gfx_pc2",
  ["gfx\\pc3.tgx"] = "gfx_pc3",
  ["gfx\\pc4.tgx"] = "gfx_pc4",
  ["gfx\\pc5.tgx"] = "gfx_pc5",
  ["gfx\\pc6.tgx"] = "gfx_pc6",
  ["gfx\\pc7.tgx"] = "gfx_pc7",
  ["gfx\\philip_taunt0150.tgx"] = "gfx_philip_taunt0150",
  ["gfx\\pick_opponent_large.tgx"] = "gfx_pick_opponent_large",
  ["gfx\\pick_opponent_normal.tgx"] = "gfx_pick_opponent_normal",
  ["gfx\\pig.tgx"] = "gfx_pig",
  ["gfx\\pitchworker_sketch.tgx"] = "gfx_pitchworker_sketch",
  ["gfx\\pitch_ditches.tgx"] = "gfx_pitch_ditches",
  ["gfx\\pitch_sketch.tgx"] = "gfx_pitch_sketch",
  ["gfx\\placement_guide.tgx"] = "gfx_placement_guide",
  ["gfx\\poleturner_sketch.tgx"] = "gfx_poleturner_sketch",
  ["gfx\\pole_sketch.tgx"] = "gfx_pole_sketch",
  ["gfx\\ponds_sketch.tgx"] = "gfx_ponds_sketch",
  ["gfx\\popgraph.tgx"] = "gfx_popgraph",
  ["gfx\\popularity_sketch.tgx"] = "gfx_popularity_sketch",
  ["gfx\\population_sketch.tgx"] = "gfx_population_sketch",
  ["gfx\\priest_sketch.tgx"] = "gfx_priest_sketch",
  ["gfx\\quarry_sketch.tgx"] = "gfx_quarry_sketch",
  ["gfx\\rat.tgx"] = "gfx_rat",
  ["gfx\\religion_sketch.tgx"] = "gfx_religion_sketch",
  ["gfx\\richard_taunt_end.tgx"] = "gfx_richard_taunt_end",
  ["gfx\\sand.tgx"] = "gfx_sand",
  ["gfx\\selecting_units.tgx"] = "gfx_selecting_units",
  ["gfx\\shcx_map.tgx"] = "gfx_shcx_map",
  ["gfx\\shc_back.tgx"] = "gfx_shc_back",
  ["gfx\\shield1.tgx"] = "gfx_shield1",
  ["gfx\\shield2.tgx"] = "gfx_shield2",
  ["gfx\\siege_engineer_guild_sketch.tgx"] = "gfx_siege_engineer_guild_sketch",
  ["gfx\\siege_engineer_sketch.tgx"] = "gfx_siege_engineer_sketch",
  ["gfx\\skirmish_background.tgx"] = "gfx_skirmish_background",
  ["gfx\\skirmish_trail.tgx"] = "gfx_skirmish_trail",
  ["gfx\\skirmish_trail2.tgx"] = "gfx_skirmish_trail2",
  ["gfx\\skirmish_trail_vignette.tgx"] = "gfx_skirmish_trail_vignette",
  ["gfx\\sktrail_win.tgx"] = "gfx_sktrail_win",
  ["gfx\\snake.tgx"] = "gfx_snake",
  ["gfx\\st02_house.tgx"] = "gfx_st02_house",
  ["gfx\\st03-woodcutters.tgx"] = "gfx_st03-woodcutters",
  ["gfx\\st03_woodcutters_hut.tgx"] = "gfx_st03_woodcutters_hut",
  ["gfx\\st04_oxen_base.tgx"] = "gfx_st04_oxen_base",
  ["gfx\\st05_iron_mine.tgx"] = "gfx_st05_iron_mine",
  ["gfx\\st06_pitch_digger.tgx"] = "gfx_st06_pitch_digger",
  ["gfx\\st07_hunters_hut.tgx"] = "gfx_st07_hunters_hut",
  ["gfx\\st08_barracks.tgx"] = "gfx_st08_barracks",
  ["gfx\\st08_mercenary_post.tgx"] = "gfx_st08_mercenary_post",
  ["gfx\\st105_bear_cave.tgx"] = "gfx_st105_bear_cave",
  ["gfx\\st10_goods_yard.tgx"] = "gfx_st10_goods_yard",
  ["gfx\\st11_armoury.tgx"] = "gfx_st11_armoury",
  ["gfx\\st12_fletchers_workshop.tgx"] = "gfx_st12_fletchers_workshop",
  ["gfx\\st13_blacksmiths_workshop.tgx"] = "gfx_st13_blacksmiths_workshop",
  ["gfx\\st14_poleturners_workshop.tgx"] = "gfx_st14_poleturners_workshop",
  ["gfx\\st15_armourers_workshop.tgx"] = "gfx_st15_armourers_workshop",
  ["gfx\\st16_tanners_workshop.tgx"] = "gfx_st16_tanners_workshop",
  ["gfx\\st17_bakers_workshop.tgx"] = "gfx_st17_bakers_workshop",
  ["gfx\\st18_brewers_workshop.tgx"] = "gfx_st18_brewers_workshop",
  ["gfx\\st19_granary.tgx"] = "gfx_st19_granary",
  ["gfx\\st20_quarry.tgx"] = "gfx_st20_quarry",
  ["gfx\\st22_inn.tgx"] = "gfx_st22_inn",
  ["gfx\\st23_healer.tgx"] = "gfx_st23_healer",
  ["gfx\\st24_engineers_guild.tgx"] = "gfx_st24_engineers_guild",
  ["gfx\\st25_tunnellers_guild.tgx"] = "gfx_st25_tunnellers_guild",
  ["gfx\\st26_tradepost.tgx"] = "gfx_st26_tradepost",
  ["gfx\\st27_well.tgx"] = "gfx_st27_well",
  ["gfx\\st28_oil_smelter.tgx"] = "gfx_st28_oil_smelter",
  ["gfx\\st30_wheatfarm.tgx"] = "gfx_st30_wheatfarm",
  ["gfx\\st31_hopsfarm.tgx"] = "gfx_st31_hopsfarm",
  ["gfx\\st32_applefarm.tgx"] = "gfx_st32_applefarm",
  ["gfx\\st33_cattlefarm.tgx"] = "gfx_st33_cattlefarm",
  ["gfx\\st34_mill.tgx"] = "gfx_st34_mill",
  ["gfx\\st35_stables.tgx"] = "gfx_st35_stables",
  ["gfx\\st36_church.tgx"] = "gfx_st36_church",
  ["gfx\\st40_keep_one.tgx"] = "gfx_st40_keep_one",
  ["gfx\\st41_keep_two.tgx"] = "gfx_st41_keep_two",
  ["gfx\\st42_keep_three.tgx"] = "gfx_st42_keep_three",
  ["gfx\\st43_keep_four.tgx"] = "gfx_st43_keep_four",
  ["gfx\\st44_keep_five.tgx"] = "gfx_st44_keep_five",
  ["gfx\\st45_gate_main.tgx"] = "gfx_st45_gate_main",
  ["gfx\\st47_gate_wood.tgx"] = "gfx_st47_gate_wood",
  ["gfx\\st49_drawbridge.tgx"] = "gfx_st49_drawbridge",
  ["gfx\\st50_tunnel_enterance.tgx"] = "gfx_st50_tunnel_enterance",
  ["gfx\\st52_signpost.tgx"] = "gfx_st52_signpost",
  ["gfx\\st54_killing_pit.tgx"] = "gfx_st54_killing_pit",
  ["gfx\\st62_gallows.tgx"] = "gfx_st62_gallows",
  ["gfx\\st65_maypole.tgx"] = "gfx_st65_maypole",
  ["gfx\\st68_pitch_ditch.tgx"] = "gfx_st68_pitch_ditch",
  ["gfx\\st70_water_pot.tgx"] = "gfx_st70_water_pot",
  ["gfx\\st74_tower1.tgx"] = "gfx_st74_tower1",
  ["gfx\\st74_tower2.tgx"] = "gfx_st74_tower2",
  ["gfx\\st74_tower3.tgx"] = "gfx_st74_tower3",
  ["gfx\\st74_tower4.tgx"] = "gfx_st74_tower4",
  ["gfx\\st74_tower5.tgx"] = "gfx_st74_tower5",
  ["gfx\\st74_towers.tgx"] = "gfx_st74_towers",
  ["gfx\\st80_seige_tents.tgx"] = "gfx_st80_seige_tents",
  ["gfx\\st80_siege_tent.tgx"] = "gfx_st80_siege_tent",
  ["gfx\\st85_tunnel_construction.tgx"] = "gfx_st85_tunnel_construction",
  ["gfx\\st99_dog_cage.tgx"] = "gfx_st99_dog_cage",
  ["gfx\\stables_sketch.tgx"] = "gfx_stables_sketch",
  ["gfx\\stairs_help.tgx"] = "gfx_stairs_help",
  ["gfx\\stake_sketch.tgx"] = "gfx_stake_sketch",
  ["gfx\\star.tgx"] = "gfx_star",
  ["gfx\\statue_sketch.tgx"] = "gfx_statue_sketch",
  ["gfx\\stockpile_sketch.tgx"] = "gfx_stockpile_sketch",
  ["gfx\\stocks_sketch.tgx"] = "gfx_stocks_sketch",
  ["gfx\\stone quarry.tgx"] = "gfx_stone quarry",
  ["gfx\\stonemason_sketch.tgx"] = "gfx_stonemason_sketch",
  ["gfx\\stretching_rack_sketch.tgx"] = "gfx_stretching_rack_sketch",
  ["gfx\\table.tgx"] = "gfx_table",
  ["gfx\\tanner_building_sketch.tgx"] = "gfx_tanner_building_sketch",
  ["gfx\\tanner_sketch.tgx"] = "gfx_tanner_sketch",
  ["gfx\\tower_sketch.tgx"] = "gfx_tower_sketch",
  ["gfx\\trader_sketch.tgx"] = "gfx_trader_sketch",
  ["gfx\\tslice1.tgx"] = "gfx_tslice1",
  ["gfx\\tslice1b.tgx"] = "gfx_tslice1b",
  ["gfx\\tslice2.tgx"] = "gfx_tslice2",
  ["gfx\\tslice2b.tgx"] = "gfx_tslice2b",
  ["gfx\\tslice3.tgx"] = "gfx_tslice3",
  ["gfx\\tslice3b.tgx"] = "gfx_tslice3b",
  ["gfx\\tslice4.tgx"] = "gfx_tslice4",
  ["gfx\\tslice4b.tgx"] = "gfx_tslice4b",
  ["gfx\\tslice5.tgx"] = "gfx_tslice5",
  ["gfx\\tslice5b.tgx"] = "gfx_tslice5b",
  ["gfx\\tslice6.tgx"] = "gfx_tslice6",
  ["gfx\\tslice6b.tgx"] = "gfx_tslice6b",
  ["gfx\\tslice7.tgx"] = "gfx_tslice7",
  ["gfx\\tslice7b.tgx"] = "gfx_tslice7b",
  ["gfx\\tslice8.tgx"] = "gfx_tslice8",
  ["gfx\\tslice8b.tgx"] = "gfx_tslice8b",
  ["gfx\\tunnelors_guild_sketch.tgx"] = "gfx_tunnelors_guild_sketch",
  ["gfx\\tunnelor_sketch.tgx"] = "gfx_tunnelor_sketch",
  ["gfx\\unit stances_aggressive.tgx"] = "gfx_unit stances_aggressive",
  ["gfx\\unit stances_defensive.tgx"] = "gfx_unit stances_defensive",
  ["gfx\\unit stances_standground.tgx"] = "gfx_unit stances_standground",
  ["gfx\\unit_stances_aggressive.tgx"] = "gfx_unit_stances_aggressive",
  ["gfx\\walls_help.tgx"] = "gfx_walls_help",
  ["gfx\\waterpot_sketch.tgx"] = "gfx_waterpot_sketch",
  ["gfx\\weapons_sketch.tgx"] = "gfx_weapons_sketch",
  ["gfx\\wedding.tgx"] = "gfx_wedding",
  ["gfx\\wedding_sketch.tgx"] = "gfx_wedding_sketch",
  ["gfx\\well_sketch.tgx"] = "gfx_well_sketch",
  ["gfx\\wheat_sketch.tgx"] = "gfx_wheat_sketch",
  ["gfx\\win_screen_arab.tgx"] = "gfx_win_screen_arab",
  ["gfx\\win_screen_crusader.tgx"] = "gfx_win_screen_crusader",
  ["gfx\\wolf.tgx"] = "gfx_wolf",
  ["gfx\\woodcutter_hut_sketch.tgx"] = "gfx_woodcutter_hut_sketch",
  ["gfx\\woodcutter_sketch.tgx"] = "gfx_woodcutter_sketch",
  ["gfx\\woolsack.tgx"] = "gfx_woolsack",
}

local NAME_FILE_MAPPING = {}
for k, v in pairs(FILE_NAME_MAPPING) do
  NAME_FILE_MAPPING[v] = k
end

return {
  FILE_NAME_MAPPING = FILE_NAME_MAPPING,
  NAME_FILE_MAPPING = NAME_FILE_MAPPING,
}