local FILE_NAME_MAPPING = {
  ["binks\\abbot_angry.bik"] = "binks_abbot_angry",
  ["binks\\abbot_confident.bik"] = "binks_abbot_confident",
  ["binks\\abbot_natural.bik"] = "binks_abbot_natural",
  ["binks\\abbot_nervous.bik"] = "binks_abbot_nervous",
  ["binks\\action_apples_die.bik"] = "binks_action_apples_die",
  ["binks\\action_archers.bik"] = "binks_action_archers",
  ["binks\\action_bandits.bik"] = "binks_action_bandits",
  ["binks\\action_fair.bik"] = "binks_action_fair",
  ["binks\\action_fire.bik"] = "binks_action_fire",
  ["binks\\action_hops_die.bik"] = "binks_action_hops_die",
  ["binks\\action_jester.bik"] = "binks_action_jester",
  ["binks\\action_mad_cows.bik"] = "binks_action_mad_cows",
  ["binks\\action_marriage.bik"] = "binks_action_marriage",
  ["binks\\action_plague.bik"] = "binks_action_plague",
  ["binks\\action_rabbits.bik"] = "binks_action_rabbits",
  ["binks\\action_steal_bread.bik"] = "binks_action_steal_bread",
  ["binks\\action_trees_die.bik"] = "binks_action_trees_die",
  ["binks\\action_wheat_die.bik"] = "binks_action_wheat_die",
  ["binks\\arabian_lose.bik"] = "binks_arabian_lose",
  ["binks\\arabian_win.bik"] = "binks_arabian_win",
  ["binks\\bad_arab_anger.bik"] = "binks_bad_arab_anger",
  ["binks\\bad_arab_natural.bik"] = "binks_bad_arab_natural",
  ["binks\\bad_arab_nervous.bik"] = "binks_bad_arab_nervous",
  ["binks\\bad_arab_taunt.bik"] = "binks_bad_arab_taunt",
  ["binks\\bad_soldier_nevous.bik"] = "binks_bad_soldier_nevous",
  ["binks\\bad_soldier_taunt.bik"] = "binks_bad_soldier_taunt",
  ["binks\\crusader_lose.bik"] = "binks_crusader_lose",
  ["binks\\crusader_win.bik"] = "binks_crusader_win",
  ["binks\\demo_assassin.bik"] = "binks_demo_assassin",
  ["binks\\demo_skirmish_vignette.bik"] = "binks_demo_skirmish_vignette",
  ["binks\\emir_angry.bik"] = "binks_emir_angry",
  ["binks\\emir_natural.bik"] = "binks_emir_natural",
  ["binks\\emir_nervous.bik"] = "binks_emir_nervous",
  ["binks\\emir_taunt.bik"] = "binks_emir_taunt",
  ["binks\\fred_anger.bik"] = "binks_fred_anger",
  ["binks\\fred_natural.bik"] = "binks_fred_natural",
  ["binks\\fred_nervous.bik"] = "binks_fred_nervous",
  ["binks\\fred_taunt.bik"] = "binks_fred_taunt",
  ["binks\\good_soldier_nervous.bik"] = "binks_good_soldier_nervous",
  ["binks\\good_soldier_taunt.bik"] = "binks_good_soldier_taunt",
  ["binks\\intro.bik"] = "binks_intro",
  ["binks\\lose_screen.bik"] = "binks_lose_screen",
  ["binks\\ma_angry.bik"] = "binks_ma_angry",
  ["binks\\ma_natural.bik"] = "binks_ma_natural",
  ["binks\\ma_nervous.bik"] = "binks_ma_nervous",
  ["binks\\ma_taunt.bik"] = "binks_ma_taunt",
  ["binks\\nazir_angry.bik"] = "binks_nazir_angry",
  ["binks\\nazir_natural.bik"] = "binks_nazir_natural",
  ["binks\\nazir_nervous.bik"] = "binks_nazir_nervous",
  ["binks\\nazir_taunt.bik"] = "binks_nazir_taunt",
  ["binks\\pg_anger1.bik"] = "binks_pg_anger1",
  ["binks\\pg_plead1.bik"] = "binks_pg_plead1",
  ["binks\\pg_plead2.bik"] = "binks_pg_plead2",
  ["binks\\pg_taunt1.bik"] = "binks_pg_taunt1",
  ["binks\\pg_taunt2.bik"] = "binks_pg_taunt2",
  ["binks\\pg_vict1.bik"] = "binks_pg_vict1",
  ["binks\\pg_vict2.bik"] = "binks_pg_vict2",
  ["binks\\pg_vict3.bik"] = "binks_pg_vict3",
  ["binks\\philip_anger.bik"] = "binks_philip_anger",
  ["binks\\philip_natural.bik"] = "binks_philip_natural",
  ["binks\\philip_nervous.bik"] = "binks_philip_nervous",
  ["binks\\philip_taunt.bik"] = "binks_philip_taunt",
  ["binks\\richard_ambient.bik"] = "binks_richard_ambient",
  ["binks\\richard_anger.bik"] = "binks_richard_anger",
  ["binks\\richard_natural.bik"] = "binks_richard_natural",
  ["binks\\richard_nervous.bik"] = "binks_richard_nervous",
  ["binks\\richard_swordswing.bik"] = "binks_richard_swordswing",
  ["binks\\richard_taunting.bik"] = "binks_richard_taunting",
  ["binks\\rt_anger1.bik"] = "binks_rt_anger1",
  ["binks\\rt_plead1.bik"] = "binks_rt_plead1",
  ["binks\\rt_plead2.bik"] = "binks_rt_plead2",
  ["binks\\rt_plead3.bik"] = "binks_rt_plead3",
  ["binks\\rt_taunt1.bik"] = "binks_rt_taunt1",
  ["binks\\rt_taunt2.bik"] = "binks_rt_taunt2",
  ["binks\\rt_vict1.bik"] = "binks_rt_vict1",
  ["binks\\rt_vict2.bik"] = "binks_rt_vict2",
  ["binks\\saladin_angry.bik"] = "binks_saladin_angry",
  ["binks\\saladin_natural.bik"] = "binks_saladin_natural",
  ["binks\\saladin_nervous.bik"] = "binks_saladin_nervous",
  ["binks\\saladin_taunting.bik"] = "binks_saladin_taunting",
  ["binks\\shcx_intro3.bik"] = "binks_shcx_intro3",
  ["binks\\sheriff_anger.bik"] = "binks_sheriff_anger",
  ["binks\\sheriff_natural.bik"] = "binks_sheriff_natural",
  ["binks\\sheriff_nervous.bik"] = "binks_sheriff_nervous",
  ["binks\\sheriff_taunt.bik"] = "binks_sheriff_taunt",
  ["binks\\sn_anger1.bik"] = "binks_sn_anger1",
  ["binks\\sn_plead1.bik"] = "binks_sn_plead1",
  ["binks\\sn_plead2.bik"] = "binks_sn_plead2",
  ["binks\\sn_taunt1.bik"] = "binks_sn_taunt1",
  ["binks\\sn_taunt2.bik"] = "binks_sn_taunt2",
  ["binks\\sn_vict1.bik"] = "binks_sn_vict1",
  ["binks\\sn_vict2.bik"] = "binks_sn_vict2",
  ["binks\\st03_woodcutters_hut.bik"] = "binks_st03_woodcutters_hut",
  ["binks\\st07_hunters_hut.bik"] = "binks_st07_hunters_hut",
  ["binks\\st12_fletchers_workshop.bik"] = "binks_st12_fletchers_workshop",
  ["binks\\st13_blacksmiths_workshop.bik"] = "binks_st13_blacksmiths_workshop",
  ["binks\\st14_poleturners_workshop.bik"] = "binks_st14_poleturners_workshop",
  ["binks\\st15_armourers_workshop.bik"] = "binks_st15_armourers_workshop",
  ["binks\\st16_tanners_workshop.bik"] = "binks_st16_tanners_workshop",
  ["binks\\st17_bakers_workshop.bik"] = "binks_st17_bakers_workshop",
  ["binks\\st22_inn.bik"] = "binks_st22_inn",
  ["binks\\st26_tradepost.bik"] = "binks_st26_tradepost",
  ["binks\\st30_wheatfarm.bik"] = "binks_st30_wheatfarm",
  ["binks\\st32_applefarm.bik"] = "binks_st32_applefarm",
  ["binks\\st33_cattlefarm.bik"] = "binks_st33_cattlefarm",
  ["binks\\st34_mill.bik"] = "binks_st34_mill",
  ["binks\\st36_church1.bik"] = "binks_st36_church1",
  ["binks\\sultan_anger.bik"] = "binks_sultan_anger",
  ["binks\\sultan_natural.bik"] = "binks_sultan_natural",
  ["binks\\sultan_nervous.bik"] = "binks_sultan_nervous",
  ["binks\\sultan_taunt.bik"] = "binks_sultan_taunt",
  ["binks\\vizir_angry.bik"] = "binks_vizir_angry",
  ["binks\\vizir_natural.bik"] = "binks_vizir_natural",
  ["binks\\vizir_nervous.bik"] = "binks_vizir_nervous",
  ["binks\\vizir_taunt.bik"] = "binks_vizir_taunt",
  ["binks\\wf_anger1.bik"] = "binks_wf_anger1",
  ["binks\\wf_plead1.bik"] = "binks_wf_plead1",
  ["binks\\wf_plead2.bik"] = "binks_wf_plead2",
  ["binks\\wf_taunt1.bik"] = "binks_wf_taunt1",
  ["binks\\wf_taunt2.bik"] = "binks_wf_taunt2",
  ["binks\\wf_vict1.bik"] = "binks_wf_vict1",
  ["binks\\wf_vict2.bik"] = "binks_wf_vict2",
}

local NAME_FILE_MAPPING = {}
for k, v in pairs(FILE_NAME_MAPPING) do
  NAME_FILE_MAPPING[v] = k
end

return {
  FILE_NAME_MAPPING = FILE_NAME_MAPPING,
  NAME_FILE_MAPPING = NAME_FILE_MAPPING,
}