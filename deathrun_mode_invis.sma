#include <amxmodx>
#include <cstrike>
#include <fun>
#include <hamsandwich>
#include <deathrun_modes>

#pragma semicolon 1

#define PLUGIN "Deathrun Mode: Invis"
#define VERSION "0.2"
#define AUTHOR "Mistrick"

#define TERRORIST_HEALTH 150

new g_iModeInvis, g_iCurMode;

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR);
	register_event("HLTV", "Event_NewRound", "a", "1=0", "2=0");
	RegisterHam(Ham_Spawn, "player", "Ham_PlayerSpawn_Post", 1);
	
	g_iModeInvis = dr_register_mode
	(
		.Name = "Invis",
		.RoundDelay = 2,
		.CT_BlockWeapons = 0,
		.TT_BlockWeapons = 1,
		.CT_BlockButtons = 0,
		.TT_BlockButtons = 1,
		.Bhop = 1,
		.Usp = 1,
		.Hide = 0
	);
}
//***** Events *****//
public Event_NewRound()
{
	g_iCurMode = -1;
}
//***** Ham *****//
public Ham_PlayerSpawn_Post(id)
{
	if(is_user_alive(id))
	{
		if(g_iCurMode == g_iModeInvis && cs_get_user_team(id) == CS_TEAM_T)
		{
			set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, 0);
			set_user_health(id, TERRORIST_HEALTH);
		}
	}
}
//*****  *****//
public dr_selected_mode(id, mode)
{
	if(mode == g_iModeInvis)
	{
		set_user_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, 0);
		set_user_health(id, TERRORIST_HEALTH);
	}
	g_iCurMode = mode;
}
