//Tranzit 2.0 Project Glassius//
//Mode: Coop / Solo
//Made by Ultimateman
////////////////////////////////

#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/zombies/_zm_stats;
#include maps/mp/zombies/_zm_buildables;
#include maps/mp/zm_transit_sq;
#include maps/mp/zm_transit_distance_tracking;
#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/gametypes_zm/_hud_message;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_net;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zm_alcatraz_utility;
#include maps/mp/zombies/_zm_afterlife;
#include maps/mp/zm_prison;
#include maps/mp/zombies/_zm;
#include maps/mp/gametypes_zm/_spawning;
#include maps/mp/zombies/_load;
#include maps/mp/zombies/_zm_clone;
#include maps/mp/zombies/_zm_ai_basic;
#include maps/mp/animscripts/shared;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_zonemgr;
#include maps/mp/zm_alcatraz_travel;
#include maps/mp/gametypes_zm/_zm_gametype;
#include maps/mp/zombies/_zm_equipment;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_perk_electric_cherry;
#include maps/mp/zombies/_zm_perks;
#include maps/mp/_visionset_mgr;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/gametypes_zm/_hud;
#include maps/mp/zombies/_zm_powerups;
#include maps/mp/zm_transit;


#include maps/mp/createfx/zm_transit_fx;

init()
{
    level thread onPlayerConnect();

    level.CurMap = getDvar( "mapname" );
    level.player_out_of_playable_area_monitor = 0; //Required for staging build r1390. Self notify stop player out of playable are monitor doesn't work anymore

    level.perk_purchase_limit = 7;

    
    level.explode_overheated_jetgun = false;
    level.unbuild_overheated_jetgun = false;
    level.take_overheated_jetgun = true;

    //level.equipment_etrap_needs_power = 0;
	//level.equipment_turret_needs_power = 0;

    

    level.limited_weapons = [];
    level._limited_equipment = [];

    level.power_local_doors_globally = 1;

    
    isTown(); //jezuslizards tomb fix 
	
    //setdvar( "sv_cheats", 1 );
	//setdvar( "developer_script", 1 );
	//setdvar( "developer", 2 );

	setdvar( "player_backSpeedScale", 1 );
	setdvar( "player_strafeSpeedScale", 1 );
	setdvar( "player_sprintStrafeSpeedScale", 1 );

	setdvar( "dtp_post_move_pause", 0 );
	setdvar( "dtp_exhaustion_window", 100 );
	setdvar( "dtp_startup_delay", 100 );	

    
    
    
    //DAY 1 PRECACHE MODELS
    preCacheModel("ch_water_fountain");
    preCacheModel( "zombie_vending_jugg" );
    preCacheModel( "t5_foliage_tree_burnt02" ); 
    preCacheModel( "t5_foliage_tree_burnt03" ); 
    preCacheModel( "t5_foliage_bush05" );
    preCacheModel( "p6_grass_wild_mixed_med" );
    preCacheModel( "foliage_red_pine_stump_lg" );
    preCacheModel( "t5_foliage_shrubs02" );
    preCacheModel( "p6_zm_quarantine_fence_01" );
    preCacheModel( "p6_zm_quarantine_fence_02" );
    preCacheModel( "p6_zm_quarantine_fence_03" );
    preCacheModel( "p6_zm_street_power_pole" );
    preCacheModel( "veh_t6_civ_bus_zombie" );
    preCacheModel( "veh_t6_civ_smallwagon_dead" );
    preCacheModel( "p6_zm_brick_clump_red_depot" );
    preCacheModel( "p_glo_street_light02_on_light" );
    preCacheModel( "p_glo_electrical_pipes_long_depot" );
    preCacheModel( "p_glo_powerline_tower_redwhite" );
    preCacheModel( "mp_m_trash_pile" );
    preCacheModel( "c_zom_avagadro_fb" );

    //DAY 2 PRECACHE MODELS

    preCacheModel( "com_payphone_america" );
    preCacheModel( "com_stepladder_large_closed" );
    preCacheModel( "dest_glo_powerbox_glass02_chunk03" );
    preCacheModel( "hanging_wire_01" );
    preCacheModel( "hanging_wire_02" );
    preCacheModel( "hanging_wire_03" );
    preCacheModel( "light_outdoorwall01_on" );
    preCacheModel( "lights_indlight_on_depot" );

    preCacheModel( "p_glo_lights_fluorescent_yellow" );
    preCacheModel( "p_glo_sandbags_green_lego_mdl" );
    preCacheModel( "p_glo_tools_chest_short" );
    preCacheModel( "p_glo_tools_chest_tall" );
    preCacheModel( "p_jun_caution_sign" );
    preCacheModel( "p_lights_cagelight02_red_off" );
    preCacheModel( "p_jun_rebar02_single_dirty" );

                //level.models[34] = ( "NEXT LIST = p6 MODELS / DNT SPAWN THIS" );
    preCacheModel( "p6_lights_club_recessed" );
    preCacheModel( "p6_garage_pipes_1x128" );
    preCacheModel( "p6_street_pole_sign_broken" );
    preCacheModel( "p6_zm_buildable_battery" );
    preCacheModel( "p6_zm_buildable_sq_scaffolding" );
    preCacheModel( "p6_zm_buildable_sq_transceiver" );
    preCacheModel( "p6_zm_building_rundown_01" );
    preCacheModel( "p6_zm_building_rundown_03" );
    preCacheModel( "p6_zm_chain_fence_piece_end" );
    preCacheModel( "p6_zm_outhouse" );
    preCacheModel( "p6_zm_power_station_railing_steps_labs" );
    preCacheModel( "p6_zm_raingutter_clamp" );
    preCacheModel( "p6_zm_rocks_large_cluster_01" );
    preCacheModel( "p6_zm_rocks_medium_05" );
    preCacheModel( "p6_zm_rocks_small_cluster_01" );
    preCacheModel( "p6_zm_sign_terminal" );
    preCacheModel( "p6_zm_sign_restrooms" );
    preCacheModel( "p6_zm_street_power_pole" );
    preCacheModel( "p6_zm_water_tower" );

    //( "NEXT LIST = CAR MODELS / DNT SPAWN THIS" );
    preCacheModel( "test_macbeth_chart_unlit" );
    preCacheModel( "test_sphere_lambert" );
    preCacheModel( "veh_t6_civ_60s_coupe_dead" );
    preCacheModel( "veh_t6_civ_microbus_dead" );
    preCacheModel( "veh_t6_civ_movingtrk_cab_dead" );

    //COLLISION
    precachemodel( "collision_wall_256x256x10_standard" );
	precachemodel( "collision_geo_32x32x10_standard" );
	precachemodel( "collision_wall_128x128x10_standard" );
	precachemodel( "collision_wall_64x64x10_standard" );
	precachemodel( "collision_wall_512x512x10_standard" );
	precachemodel( "collision_player_32x32x128" ); 
	precachemodel( "collision_player_256x256x256" );
    precachemodel( "collision_clip_sphere_32" );
    precachemodel( "collision_player_256x256x10" );
    precachemodel( "collision_geo_128x128x10_standard" );
    precachemodel( "collision_geo_64x64x128" );
    precachemodel( "collision_geo_64x64x256_standard" );
    //SEEMS TO WORK BEST FOR TREE////////////////
    precachemodel( "collision_player_64x64x256" );
    ////////////////////////////////////////////
    precachemodel( "collision_ai_64x64x10" );
    preCacheModel( "collision_clip_64x64x256" );
    precachemodel( "collision_clip_ramp" );
    
    precachemodel ( "collision_clip_sphere_64" );
    precachemodel ( "collision_physics_64x64x256" );
    
    if ( level.script == "zm_transit" )
    {
        //bus depot
        load_all_station_models();
        //diner
        load_all_diner_models();
        //bridge / forest before bus depot
        load_all_bridge_models();
        //farm exterior
        load_all_farm_models();
        //cornfield
        load_all_corn_models();
        //power tower all time
        load_tower_allTimeVisible();
        //second forest - town
        load_remaining();

        //prefx
        //precache_fx();

        //level thread dayNightCycle();
    }
    

    //load_fxsWOW();
    
    
}

onPlayerConnect()
{
    

    for(;;)
    {
       
        level waittill( "connected", player );

        player thread onPlayerSpawned();
        
        player thread set_transit_visuals();

        thread setCustomModel();

        thread setCustomTowers_AlwaysVisible();

        
        //thread playCustomFX();
        player thread sky_carousel();

        player thread dayNightCycle();

        //player thread enable_player_model_placement();

        player thread never_run_out_of_breath();

        player thread jetGun();

        player thread msg();

        //player thread toggle_hud_lui();

        //player thread disspawnzombahs();

        //thread player_carousel();
    }
}

toggle_hud_lui() //enable / disable all LUI HUD files, tho leaves cg_hud on 
{
	self endon( "disconnect" );
    level endon ( "game_ended" );
	toggle_hud = 0;

    for(;;)
    {
        if ( self actionslotfourbuttonpressed() && self adsbuttonpressed() && !toggle_hud )
	    {
		    self iprintln( "^1Disable HUD ^7Now!" );
			self iprintln( "^7 Hold ^1[{+activate}] ^7Key And Toggle The Function Off!" );
		    toggle_hud = 1;
		    self thread dotogglehud();
	    }
        else if( self actionslotfourbuttonpressed() && self adsbuttonpressed() && toggle_hud )
        {
            self iprintln( "HUD State: ^2Saved!" );
	        toggle_hud = 0;
	        self notify( "stop_toggle_hud" );
        }
	    wait( 0.05 );
    }
	
}

disspawnzombahs() //enable / disable new zombies from spawning in
{
	self endon( "disconnect" );

	self endon( "death" );

	level endon( "game_ended" );

	stop_spawning = 0;

    for (;;)
    {
        if ( self actionslotthreebuttonpressed() && self adsbuttonpressed() && !stop_spawning )
	    {
		    
		    stop_spawning = 1;
		    flag_clear( "spawn_zombies" );
			self iprintln( "^7Zombie Spawns: ^1Disabled" );
		    

			if( stop_spawning == 1 )
			{
				level specific_powerup_drop( "nuke", self.origin + VectorScale(AnglesToForward( self.angles ), 2 ) ); //spawn a nuke inside the player to make sure that all zombies that have spawned will die when disabling the spawns
			}

			wait 0.2;

			self iprintln( "^7Remaining Zombies Will Be ^2Killed ^7by The ^1Nuke!" );

			wait .5;

			self iprintln( "^7Make sure that every player in the match has ^1disabled ^7zombies spawns!" );
			
	    }
        else if( stop_spawning && self actionslotthreebuttonpressed() && self adsbuttonpressed() )
        {
            self iprintln( "^7Zombie Spawns: ^2Enabled" );
	        stop_spawning = 0;
	        flag_set( "spawn_zombies" );
        }
	    wait( 0.005 );
    }
	
}
dotogglehud() //do togglehud_lui function
{
	self endon( "stop_toggle_hud" );
	self endon( "disconnect" );
	level endon( "game_ended" );

	for(;;)
	{
		if ( self usebuttonpressed() )
		{
			self setclientuivisibilityflag( "hud_visible", 0 );
		}
    	else
    	{
        	self setclientuivisibilityflag( "hud_visible", 1 );
    	}
		wait 0.005;
	}
	
}
msg()
{
    self endon ( "disconnect" );
    level endon ( "game_ended" );
    
    if ( level.script == "zm_transit" )
    {
        self iPrintLn( "TranZit ^6Reimagined ^7loaded");
        wait 4.9;
        self iPrintLn( "Welcome ^6" + self.name );
        wait 5;
        self iPrintln( "Mod by ^1Ultimateman" );
        self iprintln( "Please make sure that you have Tranzit 2.0 Texture Pack ^2Installed! ");
    }
}
onPlayerSpawned()  //on player spawn
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    for(;;)
    {
        self waittill( "spawned_player" );
        self freezecontrols( false );

        self.score = 1750;
        self thread equipment_in_use();
        if ( level.script == "zm_transit" )
        {
            wait 1;

            level notify( "sq_stage_3complete" );
			level notify( "richtofen_c_complete" );
            level notify( "transit_sidequest_achieved" );
			clientnotify( "sq_kfx" );
			clientnotify( "sqr" );
			clientnotify( "sq_rich" );
            
        }

        
        never_run_out_of_breath();

        level thread after_quickie_do_these();

        

        
    }
}

after_quickie_do_these()
{
    level endon ( "game_ended" );

    flag_wait ( "start_zombie_round_logic" );
    wait 0.05;
    remove_eTrap_kill_limit();
    
    
}

remove_eTrap_kill_limit() //remove the health cap
{
	level.etrap_damage = maps/mp/zombies/_zm::ai_zombie_health( 255 );
}

equipment_in_use() //credit to Jbleezy
{
	self endon( "disconnect" );

	for ( ;; )
	{
		self waittill( "equipment_placed", weapon, weapname );

		if ( (IsDefined( level.turret_name) && weapname == level.turret_name ) || (IsDefined(level.electrictrap_name) && weapname == level.electrictrap_name )  )
		{
			weapon.local_power = maps/mp/zombies/_zm_power::add_local_power( weapon.origin, 16 );

			if ( IsDefined(level.electrictrap_name) && weapname == level.electrictrap_name )
			{
				self thread electrictrap_decay( weapon );
			}

			wait 0.05;

			weapon.power_on = 1;

		}
	}
}

electrictrap_decay( weapon )
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( !isDefined( self.electrictrap_health ) )
	{
		self.electrictrap_health = 180;
	}

	while ( isDefined( weapon ) )
	{
		if ( weapon.power_on )
		{
			self.electrictrap_health--;

			if ( self.electrictrap_health <= 0 )
			{
				self thread electrictrap_expired( weapon );
				return;
			}
		}
		wait 1;
	}
}

electrictrap_expired( weapon )
{
	maps/mp/zombies/_zm_equipment::equipment_disappear_fx( weapon.origin );
	self cleanupoldtrap();
	self maps/mp/zombies/_zm_equipment::equipment_release( level.electrictrap_name );
	self.electrictrap_health = undefined;
}

cleanupoldtrap()
{
	if ( isDefined( self.buildableelectrictrap ) )
	{
		if ( isDefined( self.buildableelectrictrap.stub ) )
		{
			thread maps/mp/zombies/_zm_unitrigger::unregister_unitrigger( self.buildableelectrictrap.stub );
			self.buildableelectrictrap.stub = undefined;
		}
		self.buildableelectrictrap delete();
	}
	if ( isDefined( level.electrap_sound_ent ) )
	{
		level.electrap_sound_ent delete();
		level.electrap_sound_ent = undefined;
	}
}

jetGun() //bandit
{
    level endon("game_ended");
    self endon("disconnect");

    for(;;)
    {
        if( self getcurrentweapon() == "jetgun_zm"  ) 
        {
            self setweaponoverheating( 0,0 );
            
        }
        wait 0.05;
    }
}

never_run_out_of_breath()
{
	
	self waittill ( "spawned_player" );
	self endon ( "disconnect" );
    level endon ( "game_ended" );

	self setperk( "specialty_unlimitedsprint" );
	self setperk( "specialty_fastmantle" );

	self setClientDvar( "player_backSpeedScale", 1 );
	self setClientDvar( "player_strafeSpeedScale", 1 );
	self setClientDvar( "player_sprintStrafeSpeedScale", 1 );

	self setClientDvar( "dtp_post_move_pause", 0 );
	self setClientDvar( "dtp_exhaustion_window", 100 );
	self setClientDvar( "dtp_startup_delay", 100 );

    self setClientDvar( "g_speed", 220 );		

}

sky_carousel() //spin the sky
{
    level endon ( "game_ended" );
    self endon ( "disconnect" );

    poopoo = 0;
    for( ;; )
    {
        poopoo += 0.05;

        if( poopoo >= 360 ) // sky box rotation == 360 so if the value = 360, return really close to the default value 0 ( this case 0.05 )
        {
            poopoo = 0.05;
        }
        self setClientDvar( "r_skyrotation", poopoo );

        wait 0.005; //might want to use 0.005 instead
    }
}
player_carousel() //spin the player for trailer
{
    level endon ( "game_ended" );
    self endon ( "disconnect" );

    poopoo = 0;
    for( ;; )
    {
        poopoo += 0.10;

        if( poopoo >= 360 ) // sky box rotation == 360 so if the value = 360, return really close to the default value 0 ( this case 0.05 )
        {
            poopoo = 0.05;
        }
        self setClientDvar( "cg_thirdpersonangle", poopoo );

        wait 0.005; //might want to use 0.005 instead
    }
}
dayNightCycle() // day & night cycle for Tranzit 2.0 with r_exposure; //move this to init if the game allows it
{
    level endon ( "game_ended" );
    self endon ( "disconnect" );

    
    exposure = 3.85;
    bleed = 3;
    light = 15;

    //player = getplayers();

    while ( 1 )
    {
        flag_wait ( "power_on" ); //wont turn on the day / night mode till power is set on
        players = getplayers();
        foreach( players in level.players )
        {
            
            nightnumber = randomIntRange( 1, 55 ); //1, 55
            if ( nightnumber == 24 && exposure == 3.85 && light == 15 && bleed == 3  )
            {
                self playLocalSound( "zmb_avogadro_thunder_overhead" ); //self
                self playlocalsound ( "zmb_avogadro_death" );
                
                
                for (;;)
                {
                    bleed += 0.08;
                    light += 0.08;
                    exposure += 0.05;
                    //yLow += 0.01;
                    
                    //
                    if ( exposure >= 5.723 )
                    {
                         exposure = 5.723;
                    }
                    self setClientDvar ( "r_exposureValue", exposure ); //self setClientDvar ( "r_exposureValue", exposure );
                    
                    //
                    if ( light >= 30 )
                    {
                        light = 30;
                    }
                    self setClientDvar ( "r_lightTweakSunLight", light ); //self setClientDvar ( "r_lightTweakSunLight", light );
                    
                    //
                    if ( bleed >= 5.7 )
                    {
                        bleed = 5.7;
                    }
                    self setClientDvar ( "r_sky_intensity_factor0", bleed ); //self setClientDvar ( "r_sky_intensity_factor0", bleed );

                    


                    if ( exposure == 5.723 && bleed == 5.7 && light == 30 )
                    {
                        self setClientDvar ( "vc_yl", "0 0 0.2 0 "  ); //self to all clients
                        wait 0.15;
                        self setClientDvar ( "vc_yl", "0 0 0.3 0 "  );
                        wait 0.15;
                        self setClientDvar ( "vc_yl", "0 0 0.4 0 "  );
                        wait 0.15;
                        self setClientDvar ( "vc_yl", "0 0 0.5 0 "  );
                        wait 0.15;
                        self setClientDvar ( "vc_yl", "0 0 0.6 0 "  );
                        wait 0.15;
                        self setClientDvar ( "vc_yl", "0 0 0.7 0 "  );
                        wait 0.15;
                        self setClientDvar ( "vc_yl", "0 0 0.8 0 "  );
                        wait 0.2;
                            //iprintln( "Daycycle ^6completed" );
                        break;
                    }
                        
                    wait 0.005;
                
                }    
                   
            }

            daynumber = randomIntRange ( 1, 39 ); // 1, 27

            if (  exposure == 5.723 && daynumber == 12 && bleed == 5.7 && light == 30  ) //need to fix, error due to yLow remove
            {
                
                
                for ( ;; )
                {
                    bleed -= 0.10;
                    light -= 0.10;
                    exposure -= 0.05;
                    //yLow -= 0.01;

                    if ( exposure <= 3.85 )
                    {
                        exposure = 3.85;
                    }
                    self setClientDvar ( "r_exposureValue", exposure );

                    //
                    if ( light <= 15 )
                    {
                        light = 15;
                    }
                    self setClientDvar ( "r_lightTweakSunLight", light );
                    
                    //
                    if ( bleed <= 3 )
                    {
                        bleed = 3;
                    }
                    self setClientDvar ( "r_sky_intensity_factor0", bleed );

                    //
                    

                    if ( exposure == 3.85 && bleed == 3 && light == 15 )
                    {
                        self setClientDvar ( "vc_yl", "0 0 0.8 0 "  );
                        wait 0.2;
                        self setClientDvar ( "vc_yl", "0 0 0.7 0 "  );
                        wait 0.2;
                        self setClientDvar ( "vc_yl", "0 0 0.6 0 "  );
                        wait 0.2;
                        self setClientDvar ( "vc_yl", "0 0 0.5 0 "  );
                        wait 0.2;
                        self setClientDvar ( "vc_yl", "0 0 0.4 0 "  );
                        wait 0.2;
                        self setClientDvar ( "vc_yl", "0 0 0.3 0 "  );
                        wait 0.2;
                        self setClientDvar ( "vc_yl", "0 0 0.2 0 "  );
                        wait 0.2;
                        self setClientDvar ( "vc_yl", "0 0 0.1 0 "  );
                        wait 0.2;
                        //iprintln( "Nightcycle ^6completed" );
                        //playsoundatposition( "", self.origin )
                        break;
                    }
                    wait 0.005;
                    
                
                }
            }
            
        }
        wait 8;
    }
}



set_transit_visuals() //Change setDvar to self setClientDvar, newest update will bring support for it. //latest update rollbacked, undo
{
	self waittill( "spawned_player" );

	self endon ( "disconnect" );

	level endon ( "game_ended" );

	if ( level.script == "zm_transit" )
	{
			//light
		self setClientDvar ( "r_fog", 0 );
		self setClientDvar ( "r_lightTweakSunLight", 15 ); //Sunlight intensity
		self setClientDvar ( "r_lightTweakSunColor", ( 0, 0.4, 0.9 )  ); //Sunlight colors in RGB
		self setClientDvar ( "r_lightTweakSunDirection", ( 300, 250, 12 ) ); //Sunlight sun directions x _ y _ z tho z seems to not do anything
		
            //advanced lighting
        self setClientDvar ( "r_bloomTweaks", 1 ); //Enable bloom tweaks, very useful for tranzit's snow color ( bloom tweaks 1 disabled pre deterrmined bloom tweaks set by developers )
		self setClientDvar ( "r_exposureTweak", 1 ); //Enable exposure tweak
		self setClientDvar ( "r_exposureValue", 3.85 ); // how dark / bright the screen is
        //MIGHT WANT TO USE 3.6 as the "base" exposure value instead of 3.3//////////////
        
			//lods
		self setClientDvar ( "r_lodBiasRigid", -1000 ); //Necessary for all maps, stops lowpolies showing up too early
		self setClientDvar ( "r_lodBiasSkinned", -1000 ); //Necessary for all maps, stops lowpolies showing up too early

			//sky
		self setClientDvar ( "r_sky_intensity_factor0", 3 ); //tweak sky's intensity ( light value )
		self setClientDvar ( "r_skyColorTemp", 25000 ); //name says it all
		self setClientDvar ( "r_skyRotation", 0 ); //put it to 0, the sky carousel will take care of rest... ;)
        self setClientDvar ( "r_skyTransition", 1 ); //Flip the sky upside down

			//wind
		self setClientDvar ( "wind_global_vector", ( 300, 220, 100 ) ); //wind scale for x_y_z for tranzit, check the trees & ropes .. 8)

            //shadows & sun
        self setClientDvar ( "sm_sunquality", 2 ); //shadow map quality for pre rendered shadows

            //vision data & filters
        self setClientDvar ( "r_filmUseTweaks", 1 ); //needs to be enabled to override fog vol vision banks
        self setClientDvar ( "r_dof_enable", 0 );
          
        self setClientDvar ( "vc_fgm", "1 1 1 1"  ); //Need the following 3 vcs otherwise screen doesnt show anything else than black when r_filmusetweaks is used.
        self setClientDvar ( "vc_fbm", "0 0 0 0"  );
        self setClientDvar ( "vc_fsm", "1 1 1 1" );

            //optional vision color hue filters
        self setClientDvar ( "vc_yh", "0 0 0.4 0"   );
        self setClientDvar ( "vc_yl", "0 0 0.1 0" );
        self setClientDvar ( "vc_rgbh", "0.1 0 0.489 0" );
        self setClientDvar ( "vc_rgbl", "0.1015 0 0.398 0" ); 
        

        /* // OLD SETTINGS, UPDATED TO HAVE MORE FROSTBITE LOOK
        self setClientDvar ( "vc_yh", "0 0 0.4 0"   ); //early versions
        self setClientDvar ( "vc_rgbh", "0 0 0.222 0" ); //early versions
        self setClientDvar ( "vc_rgbl", "0.1015 0 0.1475 0" ); //early versions
		*/
	}
}

// self = the model
monitorHide()
{
    level endon("game_ended");

    for(;;)
    { 
        player = get_players();//[0];//[];
        //models = getentarray("script_model", "targetname");     
        
        if ( distance2D(self.origin, player.origin) < 4500 )
        {
            self show();
            
        }
        else
        {
            self hide();
        }
        
        
        //player iprintln("monitorHide: " + player.name + " is " + distance2D(self.origin, player.origin ) + " from model" );
        wait 1;
    }
}

setCustomTowers_AlwaysVisible( pos, rot, opt, name )
{
    level endon ( "game_ended" );
    self endon ( "disconnect" );

    mtower = spawn ( "script_model", pos );
    mtower setModel ( name );
    mtower.angles = rot;

    if ( opt == 1 )
    {
        mtower delete();
    }
    else
    {

    }
}


setCustomModel( pos, rot, opt, name ) //required to spawn the models while player is spawning in
{
    level endon ( "game_ended" );
    self endon ( "disconnect" );

    model = spawn( "script_model", pos );
	model setModel( name );
	model.angles = rot;
    wait 1;

    //player = getplayers();

    
    
    //model monitorHide(); //monitor players distance from the spawned models
     
    
    


    if ( opt == 1 )
    {
        model DELETE(); //HIDE
    }
    else
    {
    }	
}

precache_fx()
{
    level._effect["gucci_mane"] = "sounds/raw/sound/zmb/level/zm_transit/alarams/airraid";
}

enable_player_model_placement()
{
    self endon ( "disconnect" );
    level endon ( "game_ended" );
    
    model_available = false;

    for ( ;; )
    {
        if ( self ActionSlotTwoButtonPressed() && self adsButtonPressed() && !model_available )
        {
            self sayAll( "^2Model spawning enabled." );
            model_available = true;

            //model spawn
            self thread player_carousel();
            self thread SpawnModel();
            //self thread load_fxsWOW();
            //self thread spawnFx();
            //PlaySoundAtPosition( "zmb_avogadro_spawn_3d", self.origin );
            //Soundobject waittill( "sound_done" );
            //self playLocalSound( "zmb_avogadro_death" ); //alright sound   vox_radi_distress_message_4 //quite nice == zmb_avogadro_death
            //Soundobject waittill( "sound_done" );
            
            //self playLocalSound( "zmb_avogadro_thunder_overhead" );
            
            //self playlocalsound ( "zmb_avogadro_death" );

            //wait 3;
            
            
            
            //self playSound( "zm_bus_shut_down_emp" );
            //playCustomFX(level.effect["gucci_mane"], self.origin );  
            //PlaySound( lovesong_for_a_deadman );
            //Soundobject waittill( "sound_done" );
            
            //fx spawn
            //self thread spawnFx();
            
            
        }
        else if ( model_available && self ActionSlotTwoButtonPressed() && self adsButtonPressed() )
        {
            self sayAll( "^1Model spawning disabled." );
            model_available = false;
            self notify ( "stop_models_from_placing_down" );
            //self notify ( "swiggety_swiggety_booty_stop_spw_fx" );
            //self notify ( "stop_fx_test" );
            //self useServerVisionSet( false );
        }
        wait 0.005;
    }
}

SpawnModel()
{
   
    self endon("death");
    self endon("disconnect");
    self endon("pause");

    self endon ( "stop_models_from_placing_down" );
    level.models = [];
    for(;;)
    {
        switch(level.CurMap) //PUT DOWN MODEL NAMES HERE!!
        {

            case "zm_transit":

                //DAY 1 MODELS
                //level.models[0] = ( "ch_water_fountain" );
                level.models[0] = ( "t5_foliage_tree_burnt03" );
                level.models[1] = ( "collision_player_64x64x256" );
                //level.models[1] = ( "collision_clip_sphere_64" );
                level.models[2] = ( "t5_foliage_tree_burnt02" ); 
                level.models[3] = ( "collision_player_32x32x128" ); 
                level.models[4] = ( "t5_foliage_bush05" );
                level.models[5] = ( "p6_grass_wild_mixed_med" );
                level.models[6] = ( "foliage_red_pine_stump_lg" );
                level.models[7] = ( "t5_foliage_shrubs02" );
                level.models[8] = ( "p6_zm_quarantine_fence_01" );
                level.models[9] = ( "p6_zm_quarantine_fence_02" );
                level.models[10] = ( "p6_zm_quarantine_fence_03" );
                level.models[11] = ( "p6_zm_street_power_pole" );
                level.models[12] = ( "veh_t6_civ_bus_zombie" );
                level.models[13] = ( "veh_t6_civ_smallwagon_dead" );
                level.models[14] = ( "p6_zm_brick_clump_red_depot" );
                level.models[15] = ( "p_glo_street_light02_on_light" );
                level.models[16] = ( "p_glo_electrical_pipes_long_depot" );
                level.models[17] = ( "p_glo_powerline_tower_redwhite" );
                level.models[18] = ( "mp_m_trash_pile" );

                //DAY 2 MODELS
                level.models[19] = ( "com_payphone_america" );
                level.models[20] = ( "com_stepladder_large_closed" );
                level.models[21] = ( "dest_glo_powerbox_glass02_chunk03" );
                level.models[22] = ( "hanging_wire_01" );
                level.models[23] = ( "hanging_wire_02" );
                level.models[24] = ( "hanging_wire_03" );
                level.models[25] = ( "light_outdoorwall01_on" );
                level.models[26] = ( "lights_indlight_on_depot" );

                level.models[27] = ( "p_glo_lights_fluorescent_yellow" );
                level.models[28] = ( "p_glo_sandbags_green_lego_mdl" );
                level.models[29] = ( "p_glo_tools_chest_short" );
                level.models[30] = ( "p_glo_tools_chest_tall" );
                level.models[31] = ( "p_jun_caution_sign" );
                level.models[32] = ( "p_lights_cagelight02_red_off" );
                level.models[33] = ( "p_jun_rebar02_single_dirty" );

                //level.models[34] = ( "NEXT LIST = p6 MODELS / DNT SPAWN THIS" );
                level.models[34] = ( "p6_lights_club_recessed" );
                level.models[35] = ( "p6_garage_pipes_1x128" );
                level.models[36] = ( "p6_street_pole_sign_broken" );
                level.models[37] = ( "p6_zm_buildable_battery" );
                level.models[38] = ( "p6_zm_buildable_sq_scaffolding" );
                level.models[39] = ( "p6_zm_buildable_sq_transceiver" );
                level.models[40] = ( "p6_zm_building_rundown_01" );
                level.models[41] = ( "p6_zm_building_rundown_03" );
                level.models[42] = ( "p6_zm_chain_fence_piece_end" );
                level.models[43] = ( "p6_zm_outhouse" );
                level.models[44] = ( "p6_zm_power_station_railing_steps_labs" );
                level.models[45] = ( "p6_zm_raingutter_clamp" );
                level.models[46] = ( "p6_zm_rocks_large_cluster_01" );
                level.models[47] = ( "p6_zm_rocks_medium_05" );
                level.models[48] = ( "p6_zm_rocks_small_cluster_01" );
                level.models[49] = ( "p6_zm_sign_terminal" );
                level.models[50] = ( "p6_zm_sign_restrooms" );
                level.models[51] = ( "p6_zm_street_power_pole" );
                level.models[52] = ( "p6_zm_water_tower" );

                level.models[53] = ( "NEXT LIST = CAR MODELS / DNT SPAWN THIS" );
                level.models[54] = ( "test_macbeth_chart_unlit" );
                level.models[55] = ( "test_sphere_lambert" );
                level.models[56] = ( "veh_t6_civ_60s_coupe_dead" );
                level.models[57] = ( "veh_t6_civ_microbus_dead" );
                level.models[58] = ( "veh_t6_civ_movingtrk_cab_dead" );

                level.models[59] = ( "NEXT LIST = DIFFERENT COLLISION HIT BOXES / DNT SPAWN THIS" );
                level.models[60] = ( "collision_wall_256x256x10_standard" );
                level.models[61] = ( "collision_geo_32x32x10_standard" );
                level.models[62] = ( "collision_wall_128x128x10_standard" );
                level.models[63] = ( "collision_wall_64x64x10_standard" );
                level.models[64] = ( "collision_wall_512x512x10_standard" );
                level.models[65] = ( "collision_player_32x32x128" );
                level.models[66] = ( "collision_player_256x256x256" );
                level.models[67] = ( "collision_clip_sphere_32" );
                level.models[68] = ( "collision_geo_128x128x10_standard" );
                level.models[69] = ( "collision_player_256x256x10" );
                
                
                level.models[70] = ( "collision_ai_64x64x10" );
                level.models[71] = ( "collision_clip_64x64x256" );
                level.models[72] = ( "collision_clip_ramp" );
                level.models[73] = ( "collision_clip_sphere_64" );
                level.models[74] = ( "collision_physics_64x64x256" );
                /*
                level.models[] = ( "" );
                level.models[] = ( "" );
                level.models[] = ( "" );
                level.models[] = ( "" );
                level.models[] = ( "" );
                level.models[] = ( "" );
                level.models[] = ( "" );
                level.models[] = ( "" );
                level.models[] = ( "" );
                level.models[] = ( "" );

                level.models[] = ( "" );
                */

                maxNum = level.models.size;
                break;
        }
   
        if (self adsButtonPressed()) // GO FORWARD ON THE LIST
        {
            checkNum = checkNum + 1;
            if (checkNum > maxNum - 1)
            {
                checkNum = 0;  
            }
            self iprintln("Selected Model: ^1" + level.models[checkNum - 1] + " ^7, press (and hold) ^1USE ^7to spawn");
            wait 0.02;
        }
        wait 0.2;

        if (self attackbuttonpressed()) //GO BACK ON THE LIST
        {
            checkNum = checkNum - 1;
            if (checkNum > maxNum - 1)
            {
                checkNum = 0;  
            }
            self iprintln("Selected Model: ^1" + level.models[checkNum - 1] + " ^7, press (and hold) ^1USE ^7to spawn");
            wait 0.02;
        }
        wait 0.2;
       
        wait 0.05;

        if (self useButtonPressed())
        {
            mTag = ("");
            model = spawn("script_model", self.origin);
            model.angles = (0, self.angles[1], 0);
            model.height = 2;
            model.width = 20;
            mTag = (level.models[checkNum - 1]);
            model setModel(level.models[checkNum - 1]);
           
            iprintln("^1" + level.models[checkNum - 1] + "^2 placed");
            iprintln("^1***" + level.models.size );

            logPrint("\nsetCustomTowers_AlwaysVisible(" + self.origin + ", " + self.angles + ", 0, \"" + mTag + "\");\n//");
            //logPrint( "\n\n{\n" + "\"origin\" " + "\"" + self.origin[0] + " " + self.origin[1] + " " + self.origin[2] + "\"\n" + "\"classname\" \"script_model\"\n" + "\"model\" " + "\"" + mTag + "\"\n" + "\"angles\" \"" + model.angles[0] + " " + model.angles[1] + " " + model.angles[2] + "\"\n" + "}\n\n");
            //logs to games_mp.log for future map saving
            wait 0.01;
        }
        wait 0.3;
        //FORGE
        /*while(self attackbuttonpressed())
        {
            trace=bulletTrace(self GetTagOrigin("j_head"),self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 1000000,true,self);
            while(self attackbuttonpressed())
            {
                trace["entity"] setOrigin(self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200);
                trace["entity"].origin=self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200;
            }
            wait 0.05;
        }*/
    }
}
solo_tombstone_removal() //jezus
{
	notify( "tombstone_on" );
}

turn_tombstone_on() //jezus
{
	while ( 1 )
	{
		machine = getentarray( "vending_tombstone", "targetname" );
		machine_triggers = getentarray( "vending_tombstone", "target" );
		i = 0;
		while ( i < machine.size )
		{
			machine[ i ] setmodel( level.machine_assets[ "tombstone" ].off_model );
			i++;
		}
		level thread do_initial_power_off_callback( machine, "tombstone" );
		array_thread( machine_triggers, ::set_power_on, 0 );
		level waittill( "tombstone_on" );
		i = 0;
		while ( i < machine.size )
		{
			machine[ i ] setmodel( level.machine_assets[ "tombstone" ].on_model );
			machine[ i ] vibrate( vectorScale( ( 0, -1, 0 ), 100 ), 0,3, 0,4, 3 );
			machine[ i ] playsound( "zmb_perks_power_on" );
			machine[ i ] thread perk_fx( "tombstone_light" );
			machine[ i ] thread play_loop_on_machine();
			i++;
		}
		level notify( "specialty_scavenger_power_on" );
		array_thread( machine_triggers, ::set_power_on, 1 );
		if ( isDefined( level.machine_assets[ "tombstone" ].power_on_callback ) )
		{
			array_thread( machine, level.machine_assets[ "tombstone" ].power_on_callback );
		}
		level waittill( "tombstone_off" );
		if ( isDefined( level.machine_assets[ "tombstone" ].power_off_callback ) )
		{
			array_thread( machine, level.machine_assets[ "tombstone" ].power_off_callback );
		}
		array_thread( machine, ::turn_perk_off );
		players = get_players();
		_a1718 = players;
		_k1718 = getFirstArrayKey( _a1718 );
		while ( isDefined( _k1718 ) )
		{
			player = _a1718[ _k1718 ];
			player.hasperkspecialtytombstone = undefined;
			_k1718 = getNextArrayKey( _a1718, _k1718 );
		}
	}
}

perk_machine_spawn_init()//jezus
{
	match_string = "";
	location = level.scr_zm_map_start_location;
	if ( location != "default" && location == "" && isDefined( level.default_start_location ) )
	{
		location = level.default_start_location;
	}
	match_string = ( level.scr_zm_ui_gametype + "_perks_" ) + location;
	pos = [];
	if ( isDefined( level.override_perk_targetname ) )
	{
		structs = getstructarray( level.override_perk_targetname, "targetname" );
	}
	else
	{
		structs = getstructarray( "zm_perk_machine", "targetname" );
	}
	_a3578 = structs;
	_k3578 = getFirstArrayKey( _a3578 );
	while ( isDefined( _k3578 ) )
	{
		struct = _a3578[ _k3578 ];
		if ( isDefined( struct.script_string ) )
		{
			tokens = strtok( struct.script_string, " " );
			_a3583 = tokens;
			_k3583 = getFirstArrayKey( _a3583 );
			while ( isDefined( _k3583 ) )
			{
				token = _a3583[ _k3583 ];
				if ( token == match_string )
				{
					pos[ pos.size ] = struct;
				}
				_k3583 = getNextArrayKey( _a3583, _k3583 );
			}
		}
		else pos[ pos.size ] = struct;
		_k3578 = getNextArrayKey( _a3578, _k3578 );
	}
	if ( !isDefined( pos ) || pos.size == 0 )
	{
		return;
	}
	precachemodel( "zm_collision_perks1" );
	i = 0;
	while ( i < pos.size )
	{
		perk = pos[ i ].script_noteworthy;
		if ( isDefined( perk ) && isDefined( pos[ i ].model ) )
		{
			use_trigger = spawn( "trigger_radius_use", pos[ i ].origin + vectorScale( ( 0, -1, 0 ), 30 ), 0, 40, 70 );
			use_trigger.targetname = "zombie_vending";
			use_trigger.script_noteworthy = perk;
			use_trigger triggerignoreteam();
			perk_machine = spawn( "script_model", pos[ i ].origin );
			perk_machine.angles = pos[ i ].angles;
			perk_machine setmodel( pos[ i ].model );
			if ( isDefined( level._no_vending_machine_bump_trigs ) && level._no_vending_machine_bump_trigs )
			{
				bump_trigger = undefined;
			}
			else
			{
				bump_trigger = spawn( "trigger_radius", pos[ i ].origin, 0, 35, 64 );
				bump_trigger.script_activated = 1;
				bump_trigger.script_sound = "zmb_perks_bump_bottle";
				bump_trigger.targetname = "audio_bump_trigger";
				if ( perk != "specialty_weapupgrade" )
				{
					bump_trigger thread thread_bump_trigger();
				}
			}
			collision = spawn( "script_model", pos[ i ].origin, 1 );
			collision.angles = pos[ i ].angles;
			collision setmodel( "zm_collision_perks1" );
			collision.script_noteworthy = "clip";
			collision disconnectpaths();
			use_trigger.clip = collision;
			use_trigger.machine = perk_machine;
			use_trigger.bump = bump_trigger;
			if ( isDefined( pos[ i ].blocker_model ) )
			{
				use_trigger.blocker_model = pos[ i ].blocker_model;
			}
			if ( isDefined( pos[ i ].script_int ) )
			{
				perk_machine.script_int = pos[ i ].script_int;
			}
			if ( isDefined( pos[ i ].turn_on_notify ) )
			{
				perk_machine.turn_on_notify = pos[ i ].turn_on_notify;
			}
			if ( perk == "specialty_scavenger" || perk == "specialty_scavenger_upgrade" )
			{
				use_trigger.script_sound = "mus_perks_tombstone_jingle";
				use_trigger.script_string = "tombstone_perk";
				use_trigger.script_label = "mus_perks_tombstone_sting";
				use_trigger.target = "vending_tombstone";
				perk_machine.script_string = "tombstone_perk";
				perk_machine.targetname = "vending_tombstone";
				if ( isDefined( bump_trigger ) )
				{
					bump_trigger.script_string = "tombstone_perk";
				}
			}
			if ( isDefined( level._custom_perks[ perk ] ) && isDefined( level._custom_perks[ perk ].perk_machine_set_kvps ) )
			{
				[[ level._custom_perks[ perk ].perk_machine_set_kvps ]]( use_trigger, perk_machine, bump_trigger, collision );
			}
		}
		i++;
	}
}

isTown() //jezus
{
	if (isDefined(level.zombiemode_using_tombstone_perk) && level.zombiemode_using_tombstone_perk)
	{
		level thread perk_machine_spawn_init();
		thread solo_tombstone_removal();
		thread turn_tombstone_on();
	}
}


load_all_station_models()
{
    level endon ( "game_ended" );


            thread busstation01();
            thread busstation02();
            thread busstation03();

            thread busstation1();
            thread busstation3();
            thread busstation4();
            
            thread busstation23();
            thread busstation24();
            thread busstation25();
            thread busstation26();
            thread busstation27();
            thread busstation28();
            thread busstation29();
            thread busstation30();

            thread busstation31();
            thread busstation32();
            thread busstation33();
            thread busstation34();
            thread busstation35();
            thread busstation36();
            thread busstation37();
            thread busstation38();
            thread busstation39();
            thread busstation40();

            thread busstation41();
            thread busstation42();
            thread busstation43();
            thread busstation44();
            thread busstation45();
            thread busstation46();
            thread busstation47();
            thread busstation48();
            thread busstation49();
            thread busstation50();

            thread busstation51();
            thread busstation52();
            thread busstation53();
            thread busstation54();
            thread busstation55();
            thread busstation56();
            thread busstation57();
            thread busstation58();
            thread busstation59();
            thread busstation60();

            thread busstation61();
            thread busstation62();
            thread busstation63();
            thread busstation64();
            thread busstation65();
            thread busstation66();
            thread busstation67();
            thread busstation68();
            thread busstation69();
            thread busstation70();  
}

load_all_diner_models()
{
    level endon ( "game_ended" );

    thread diner1(); 
    thread diner2();
    thread diner3();
    thread diner4();
    thread diner5();
    thread diner6();
    thread diner7();
    
    thread diner9();
    
    thread diner11();
    
    thread diner13();
    
    thread diner15();
    
    thread diner17();
    thread diner18();
    thread diner19();
    thread diner20();
            
    thread diner21();
    thread diner22();
    thread diner23();
    thread diner24();
    thread diner25();
    thread diner26();
    thread diner27();
    thread diner28();
    thread diner29();
    thread diner30();
    thread diner31();
    thread diner32();

    thread diner38();
    thread diner39();
    thread diner40();
    thread diner41();
    thread diner42();
    thread diner43();
    thread diner44();
    thread diner45();
    thread diner46();
    thread diner47();
    thread diner48();
    thread diner49();

    thread diner50();
    thread diner51();
    thread diner52();
    thread diner53();
    thread diner54();
    thread diner55();
    thread diner56();
    thread diner57();
    thread diner58();
    thread diner59();
    
    thread diner60();
    thread diner61();
    thread diner62();
    thread diner63();
    thread diner65();
    thread diner66();
    
            
}

load_all_bridge_models()
{
    level endon ("game_ended" );

    thread bridge1();
    thread bridge2();
    
    
    
    thread bridge6();
    
    thread bridge8();
    
    thread bridge10();
    
    
    thread bridge13();
    thread bridge14();
    
    thread bridge16();
    
    thread bridge18();
    
    thread bridge20();
    
    
    
    thread bridge24();
    thread bridge25();
    
    thread bridge27();
    
    thread bridge29();
    
    thread bridge31();
    
    thread bridge33();
    
    thread bridge35();
    thread bridge36();
    
    
    thread bridge39();
    thread bridge40();
    
    
    thread bridge43();
    thread bridge44();
    thread bridge45();
    thread bridge46();
    
    thread bridge48();
    
    thread bridge50();
    thread bridge51();
    
    thread bridge53();
    
    thread bridge55();
    thread bridge56();
    
    thread bridge58();
    
    thread bridge60();
    thread bridge61();
    
    thread bridge63();
    
    thread bridge68();
    
    thread bridge70();
    
    
    thread bridge73();
    thread bridge74();
    thread bridge75();
    
    thread bridge77();
    thread bridge78();
    
    thread bridge80();
    thread bridge81();
    
}

load_tower_allTimeVisible()
{
    level endon ( "game_ended" );

    thread tower1();
    thread tower2();
    thread tower3();
    thread tower4();
    thread tower5();
}

load_all_farm_models() //coop model amount = 29
{
    level endon ( "game_ended" );

    thread farm1();
    
    thread farm3();
    thread farm4();
    thread farm5();
    
    thread farm7();

    thread farm10();
    
    
    thread farm13();
    thread farm14();
    
    thread farm18();
    thread farm19();

    thread farm20();
    thread farm21();
    
    
    thread farm24();
    thread farm25();
    
    thread farm27();
    thread farm28();
    
    thread farm48();
    thread farm49();

    thread farm50();
    
    thread farm54();
    thread farm55();
    thread farm56();
    thread farm57();
    
    
    thread farm60();
    thread farm61();
    
    thread farm64();
    
    
    thread farm106();
    thread farm107();
    
    thread farm109();
}

load_all_corn_models() //total amount of models in cornfield = 52
{
    level endon ( "game_ended" );
    
    thread corn1();
    
    thread corn3();
    thread corn4();
    
    thread corn6();
    
    thread corn8();
    
    thread corn10();

    
    thread corn12();
    
    
    thread corn15();
    
    thread corn17();
    
    thread corn19();
    
    thread corn22();
    thread corn23();
    thread corn24();
    thread corn25();
    
    thread corn27();
    thread corn28();
    thread corn29();
    thread corn30();

    thread corn31();
    
    thread corn33();
    
    thread corn35();
    thread corn36();
    
    thread corn38();
    
    thread corn40();

    thread corn41();
    
    thread corn43();
    thread corn44();
    thread corn45();
    thread corn46();
    
    thread corn48();
    
    thread corn50();

    thread corn51();
    
    thread corn53();
    thread corn54();
    thread corn55();
    thread corn56();
    
    thread corn58();
    thread corn59();
    

    thread corn61();
    
    thread corn63();
    
    thread corn65();
    thread corn66();
    
    thread corn68();
    thread corn69();
    
    
    thread corn71();
    
    thread corn73();
    
    thread corn75();
    thread corn76();
    
    thread corn78();
    
    thread corn80();

    
    thread corn82();
    thread corn83();


}

load_remaining()
{
    level endon ( "game_ended" );

    thread remaining1();
    thread remaining2();
    thread remaining3();
    thread remaining4();
    thread remaining5();
    thread remaining6();
    thread remaining7();
    thread remaining8();
    thread remaining9();
    thread remaining10();
    thread remaining11();
    thread remaining12();
    thread remaining13();
    thread remaining14();
    thread remaining15();
    thread remaining16();
    thread remaining17();
    thread remaining18();
    thread remaining19();
    thread remaining20();
    thread remaining21();
    thread remaining22();
    thread remaining23();
    thread remaining24();
    thread remaining25();
    thread remaining26();
    thread remaining27();
    thread remaining28();
    thread remaining29();
    thread remaining30();
    thread remaining31();
}
/*
load_fxsWOW()
{
    self endon ( "disconnect" );
    level endon ( "game_ended" );
    //for(;;)
    
    //{
        thread fx1();
        thread fx2();
        thread fx3();
        thread fx4();
        thread fx5();
        thread fx6();
        thread fx7();
        thread fx8();
        thread fx9();

        thread fx10();
        thread fx11();
        thread fx13();
        thread fx14();
        thread fx15();
        thread fx16();
        thread fx17();
        thread fx18();
        thread fx19();

        thread fx20();
//thread fx21();
        thread fx22();
        thread fx23();
        thread fx24();
        thread fx25();
        thread fx26();
        thread fx27();
        thread fx28();
        thread fx29();

        thread fx30();
        thread fx31();
        thread fx32();
        thread fx33();
        thread fx34();
        thread fx35();
        thread fx36();
        thread fx37();
        thread fx38();
        thread fx39();

        thread fx40();
        thread fx41();
        thread fx42();
        thread fx43();
        thread fx44();
        thread fx45();
        thread fx46();
        thread fx47();
        thread fx48();
        thread fx49();

        thread fx50();
        thread fx51();
        thread fx52();
        thread fx53();
        thread fx54();
        thread fx55();
        thread fx56();
        thread fx57();
        thread fx58();
        thread fx59();

        thread fx60();
        thread fx61();
        thread fx62();
        thread fx64();  
        thread fx64();
        thread fx65();
        thread fx66();
        thread fx67();
        thread fx68();
        thread fx69();

        thread fx70();
        thread fx71();
        thread fx72();
        thread fx73();
        thread fx74();
        thread fx75();
        thread fx76();
        thread fx77();
        thread fx78();
        thread fx79();

        thread fx80();
        thread fx81();
        thread fx82();
        thread fx83();
        thread fx84();
        thread fx85();
        thread fx86();
        thread fx87();
        thread fx88();
        thread fx89();

        thread fx90();
        thread fx91();
        thread fx92();  
        thread fx93();
//thread fx94();
        thread fx95();
        thread fx96();
        thread fx97();
        thread fx98();
        thread fx99();

        thread fx100();
        thread fx101();
        thread fx102();
        thread fx103();
        thread fx104(); 
        thread fx105();
        thread fx106();
        thread fx107();
        thread fx108();
        thread fx109();

        thread fx110();
        thread fx110();
        //thread fx111();
        thread fx113();
        thread fx114();
        thread fx115();
        thread fx116();
        thread fx117();
        thread fx118();
        thread fx119();

        thread fx120();
        thread fx121();
        thread fx121();
        thread fx122();
        thread fx123();
        thread fx124();
        thread fx125();
        thread fx126();
        thread fx127();
        thread fx128();
        thread fx129();


        thread fx130();
        thread fx131();
        thread fx132();
        thread fx133();
        thread fx134();
        thread fx135();
        thread fx136();
        thread fx137();
        thread fx138();
        thread fx139();

        thread fx140();
        thread fx141();
        thread fx142();
        thread fx143();
        thread fx144();
        thread fx145();
        thread fx146();
        thread fx147();
        thread fx148();
        thread fx149();

        thread fx150();
        thread fx151();
        thread fx152();
        thread fx153();
        thread fx154();
        thread fx155();
        thread fx156();
        thread fx157();
        thread fx158();
        thread fx159();

        thread fx160();
        thread fx161();
        thread fx162();
        thread fx164();
        thread fx164();
        thread fx165();
        //thread fx166();
        thread fx167();
        thread fx168();
        thread fx169();

        thread fx170();
        thread fx171();
        thread fx172();
        thread fx173();
        thread fx174();
        //thread fx175();
        thread fx176();
        thread fx177();
        thread fx178();
        thread fx179();

        thread fx180();
        thread fx181();
        thread fx182();
        thread fx183();
        thread fx184();
        thread fx185();
        thread fx186();
        thread fx187();
        thread fx188();
        thread fx189();

        thread fx190();
        thread fx191();
        thread fx192();
        thread fx193();
        thread fx194();
        thread fx195();
        thread fx196();
        thread fx197();
        thread fx198();
        thread fx199();

        thread fx200();
        thread fx201();
        //thread fx202();
        thread fx203();
        thread fx204();
        thread fx205();
        thread fx206();
        thread fx207();
        thread fx208();
        thread fx209();

        thread fx210();
        thread fx211();
        thread fx213();
        thread fx214();
        thread fx215();
        thread fx216();
        thread fx217();
        thread fx218();
        thread fx219();

        thread fx220();
        thread fx221();
        thread fx222();
        thread fx223();
        thread fx224();
        thread fx225();
        thread fx226();
        thread fx227();
        thread fx228();
        thread fx229();

        thread fx230();
        thread fx231();
        thread fx232();
        thread fx233();
        thread fx234();
        thread fx235();
        thread fx236();
        thread fx237();
        thread fx238();
        thread fx239();

        thread fx240();
        thread fx241();
        thread fx242();
        thread fx243();
        thread fx244();
        thread fx245();
        thread fx246();
        thread fx247();
        thread fx248();
        thread fx249();

        thread fx250();
        thread fx251();
        thread fx252();
        thread fx253();
        thread fx254();
        thread fx255();
        thread fx256();
        thread fx257();
        thread fx258();
        thread fx259();

        thread fx260(); 
        thread fx261();
        thread fx262();
        thread fx264();
        thread fx264();
        thread fx265();
        thread fx266();
        thread fx267();
        thread fx268();
        thread fx269();

        thread fx270();
        thread fx271();
        thread fx272();
        thread fx273();
        thread fx274();
        thread fx275();
        thread fx276();
        thread fx277();
        thread fx278();
        thread fx279();

        thread fx280();
        thread fx281();
        thread fx282();
        thread fx283();
        thread fx284();
        thread fx285();
        thread fx286();
        thread fx287();
        thread fx288();
        thread fx289();

        thread fx290();
        thread fx291();
        thread fx292();
        thread fx293();
        thread fx294();
        thread fx295();
        thread fx296();
        thread fx297();
        thread fx298();
        thread fx299();

        thread fx301();
        thread fx302();
        thread fx303();
        thread fx304();
        thread fx305();
        thread fx306();
        thread fx307();
        thread fx308();
        thread fx309();

        thread fx310();
        thread fx311();
        thread fx313();
        thread fx314();
        thread fx315();
        thread fx316();
        thread fx317();
        //wait 0.5;
    //&}
    

}
*/
corn1()
{
    setCustomModel((6564.17, -2701.16, -98.5209), (0, -86.7412, 0), 0, "t5_foliage_tree_burnt03");
}



corn3()
{
    setCustomModel((7732.78, -1908.14, -215.462), (0, 55.2241, 0), 0, "t5_foliage_tree_burnt03");
}

corn4()
{
    setCustomModel((7732.78, -1908.14, -215.462), (0, -52.6287, 0), 0, "t5_foliage_tree_burnt03");
}



corn6()
{
    setCustomModel((6638.07, -2871.67, -91.2916), (0, 90.6495, 0), 0, "t5_foliage_bush05");
}



corn8()
{
    setCustomModel((6878.19, -2814.16, -116.007), (0, 133.985, 0), 0, "t5_foliage_bush05");
}



corn10()
{
    setCustomModel((6449.34, -2988.57, -60.8175), (0, -38.3464, 0), 0, "t5_foliage_bush05");
}



corn12()
{
    setCustomModel((6573.35, -2871.65, -88.3303), (0, -102.226, 0), 0, "t5_foliage_bush05");
}



corn15()
{
    setCustomModel((6600.74, -2924.72, -85.8131), (0, -122.2, 0), 0, "t5_foliage_shrubs02");
}



corn17()
{
    setCustomModel((6808.75, -2801.32, -124.449), (0, 128.651, 0), 0, "t5_foliage_shrubs02");
}



corn19()
{
    setCustomModel((10714.6, -1505.49, -210.327), (0, 18.4144, 0), 0, "t5_foliage_tree_burnt03");
}



corn22()
{
    setCustomModel((10301.7, -1944.58, -190.387), (0, 11.3337, 0), 0, "t5_foliage_tree_burnt03");
}

corn23()
{
    setCustomModel((10301.7, -1944.58, -190.387), (0, -175.544, 0), 0, "t5_foliage_tree_burnt03");
}

corn24()
{
    setCustomModel((10556.3, -2249.41, -189.418), (0, 30.6477, 0), 0, "t5_foliage_tree_burnt03");
}

corn25()
{
    setCustomModel((10556.3, -2249.41, -189.418), (0, 171.756, 0), 0, "t5_foliage_tree_burnt03");
}



corn27()
{
    setCustomModel((12328.4, -3211.12, 116.053), (0, 115.226, 0), 0, "t5_foliage_tree_burnt03");
}

corn28()
{
    setCustomModel((12328.4, -3211.12, 116.053), (0, -126.089, 0), 0, "t5_foliage_tree_burnt03");
}

corn29()
{
    setCustomModel((11723.5, -3346, 118.792), (0, 93.3632, 0), 0, "t5_foliage_tree_burnt03");
}


corn30()
{
    setCustomModel((11723.5, -3346, 118.792), (0, -138.767, 0), 0, "t5_foliage_tree_burnt03");
}

corn31()
{
    setCustomModel((9577.63, -1324.93, -206.003), (0, 152.673, 0), 0, "t5_foliage_tree_burnt03");
}




corn33()
{
    setCustomModel((11404.8, -287.468, -180.993), (0, 53.7355, 0), 0, "t5_foliage_tree_burnt03");
}




corn35()
{
    setCustomModel((11362.5, -253.571, -210.426), (0, -54.5183, 0), 0, "t5_foliage_shrubs02");
}

corn36()
{
    setCustomModel((11387.8, -231.419, -205.878), (0, -112.856, 0), 0, "t5_foliage_shrubs02");
}



corn38()
{
    setCustomModel((11451.4, -309.291, -190.317), (0, 101.46, 0), 0, "t5_foliage_shrubs02");
}



corn40()
{
    setCustomModel((9798.63, 137.7, -223.328), (0, 30.1918, 0), 0, "t5_foliage_tree_burnt03");
}

corn41()
{
    setCustomModel((9798.63, 137.7, -223.328), (0, -134.757, 0), 0, "t5_foliage_tree_burnt03");
}



corn43()
{
    setCustomModel((9800.28, 217.204, -223.975), (0, -92.5695, 0), 0, "t5_foliage_bush05");
}

corn44()
{
    setCustomModel((6702.02, -702.037, -180.827), (0, -136.377, 0), 0, "t5_foliage_bush05");
}

corn45()
{
    setCustomModel((6702.1, -702.202, -189.039), (0, 99.2409, 0), 0, "t5_foliage_tree_burnt03");
}

corn46()
{
    setCustomModel((6702.1, -702.202, -189.039), (0, 77.2352, 0), 0, "t5_foliage_tree_burnt03");
}



corn48()
{
    setCustomModel((6982.85, 1129.58, 589.476), (0, -46.4214, 0), 0, "t5_foliage_tree_burnt03");
}



corn50()
{
    setCustomModel((8178.35, -2672.16, -164.907), (0, 58.4926, 0), 0, "t5_foliage_tree_burnt03");
}

corn51()
{
    setCustomModel((8178.35, -2672.16, -164.907), (0, 119.664, 0), 0, "t5_foliage_tree_burnt03");
}



corn53()
{
    setCustomModel((8204.67, -2598.66, -192.104), (0, -110.988, 0), 0, "t5_foliage_bush05");
}

corn54()
{
    setCustomModel((8137.51, -2615.67, -190.478), (0, -59.0996, 0), 0, "t5_foliage_bush05");
}

corn55()
{
    setCustomModel((6082.34, -3353.57, -51.619), (0, -38.9232, 0), 0, "t5_foliage_bush05");
}


corn56()
{
    setCustomModel((6082.34, -3353.57, -51.619), (0, -159.597, 0), 0, "t5_foliage_bush05");
}



corn58()
{
    setCustomModel((5973.88, -3396.46, -38.0951), (0, -146.078, 0), 0, "t5_foliage_tree_burnt03");
}

corn59()
{
    setCustomModel((6007.74, -2300.85, -18.5567), (0, -178.735, 0), 0, "t5_foliage_tree_burnt03");
}



corn61()
{
    setCustomModel((7700.49, 1351.72, -116.664), (0, 13.0201, 0), 0, "t5_foliage_tree_burnt02");
}




corn63()
{
    setCustomModel((8060.51, 1311.09, -145.348), (0, 3.76417, 0), 0, "t5_foliage_tree_burnt03");
}



corn65()
{
    setCustomModel((8125.18, 1287.7, -149.39), (0, 112.908, 0), 0, "t5_foliage_shrubs02");
}

corn66()
{
    setCustomModel((10721.6, 447.741, -205.676), (0, -24.652, 0), 0, "t5_foliage_tree_burnt03");
}



corn68()
{
    setCustomModel((8603.73, 3466.22, -142.239), (0, 178.595, 0), 0, "t5_foliage_tree_burnt03");
}

corn69()
{
    setCustomModel((8631.39, 806.051, -190.959), (0, -96.92, 0), 0, "t5_foliage_tree_burnt03");
}



corn71()
{
    setCustomModel((8308.34, 5374.68, -514.54), (0, 42.4305, 0), 0, "t5_foliage_tree_burnt03");
}



corn73()
{
    setCustomModel((8308.31, 5375.36, -503.675), (0, -97.6671, 0), 0, "collision_player_64x64x256");
}



corn75()
{
    setCustomModel((8352.84, 5415.64, -483.659), (0, -132.73, 0), 0, "t5_foliage_shrubs02");
}

corn76()
{
    setCustomModel((8554.12, 2312.14, -77.8264), (0, -72.5139, 0), 0, "t5_foliage_tree_burnt03");
}



corn78()
{
    setCustomModel((8553.13, 2312.54, -54.4038), (0, -73.2555, 0), 0, "collision_player_64x64x256");
}


corn80()
{
    setCustomModel((8507.98, 2257.83, -93.7813), (0, 56.8611, 0), 0, "t5_foliage_shrubs02");
}



corn82()
{
    setCustomModel((8519.8, 2386.32, -98.1818), (0, -58.8304, 0), 0, "t5_foliage_shrubs02");
}

corn83()
{
    setCustomModel((8622.5, 2302.39, -86.3011), (0, 175.876, 0), 0, "t5_foliage_shrubs02");
}








farm1()
{
    setCustomModel((4560.94, -6359.86, -150.619), (0, 39.7145, 0), 0, "t5_foliage_tree_burnt03");
}



farm3()
{
    setCustomModel((4742.34, -6332.61, -178.001), (0, 109.34, 0), 0, "t5_foliage_tree_burnt03");
}

farm4()
{
    setCustomModel((4742.34, -6332.61, -178.001), (0, -104.761, 0), 0, "t5_foliage_tree_burnt02");
}

farm5()
{
    setCustomModel((4732.46, -6535.87, -221.979), (0, -76.4604, 0), 0, "t5_foliage_tree_burnt03");
}


farm7()
{
    setCustomModel((6952.21, -5493.72, -150.736), (0, -91.6215, 0), 0, "t5_foliage_tree_burnt03");
}



farm10()
{
    setCustomModel((6951.17, -6024.42, -162.081), (0, 154.56, 0), 0, "t5_foliage_tree_burnt03");
}







farm13()
{
    setCustomModel((7501.81, -5916.88, -19.4754), (0, -99.4163, 0), 0, "t5_foliage_tree_burnt03");
}


farm14()
{
    setCustomModel((7501.81, -5916.88, -19.4754), (0, 64.3679, 0), 0, "t5_foliage_tree_burnt02");
}





farm18()
{
    setCustomModel((7042.46, -5898.18, -98.3959), (0, -166.9, 0), 0, "t5_foliage_bush05");
}


farm19()
{
    setCustomModel((7120.98, -5919.99, -90.663), (0, 177.73, 0), 0, "t5_foliage_bush05");
}


farm20()
{
    setCustomModel((7210.79, -5911.54, -82.6208), (0, 84.8354, 0), 0, "t5_foliage_bush05");
}


farm21()
{
    setCustomModel((7700.28, -4377.14, 27.2939), (0, -96.6423, 0), 0, "t5_foliage_tree_burnt03");
}








farm24()
{
    setCustomModel((9611.74, -5735.82, 38.1291), (0, -160.264, 0), 0, "t5_foliage_tree_burnt03");
}


farm25()
{
    setCustomModel((9297.35, -6131, 69.2135), (0, 174.132, 0), 0, "t5_foliage_tree_burnt03");
}



farm27()
{
    setCustomModel((7421.88, -4814.52, -22.8138), (0, -163.302, 0), 0, "t5_foliage_bush05");
}

farm28()
{
    setCustomModel((7246.68, -4807.41, -63.4148), (0, 177.719, 0), 0, "t5_foliage_bush05");
}

farm48()
{
    setCustomModel((7353.54, -5198.1, -43.1589), (0, 20.9224, 0), 0, "t5_foliage_shrubs02");
}


farm49()
{
    setCustomModel((7631.33, -5488.99, -28.0143), (0, -72.0878, 0), 0, "t5_foliage_shrubs02");
}



farm50()
{
    setCustomModel((7566.54, -5452.98, -38.2987), (0, -156.809, 0), 0, "p6_grass_wild_mixed_med");
}





farm54()
{
    setCustomModel((7523.15, -5274.47, 16.7213), (0, 13.5726, 0), 0, "p6_grass_wild_mixed_med");
}



farm55()
{
    setCustomModel((7462.89, -5280.89, -3.45478), (0, -10.081, 0), 0, "p6_grass_wild_mixed_med");
}



farm56()
{
    setCustomModel((7523.47, -5276.44, 8.33194), (0, -16.0795, 0), 0, "p6_grass_wild_mixed_med");
}


farm57()
{
    setCustomModel((7622.61, -5287.35, 24.6879), (0, -61.0631, 0), 0, "p6_grass_wild_mixed_med");
}







farm60()
{
    setCustomModel((7630.88, -5542.23, -0.274568), (0, 162.481, 0), 0, "p6_grass_wild_mixed_med");
}


farm61()
{
    setCustomModel((7565.34, -5340.66, 7.10514), (0, 127.314, 0), 0, "p6_grass_wild_mixed_med");
}





farm64()
{
    setCustomModel((7331.42, -5382.02, -26.3738), (0, -152.123, 0), 0, "p6_grass_wild_mixed_med");
}

farm65()
{
    setCustomModel((7275.7, -5351.6, -27.4251), (0, 115.734, 0), 0, "p6_grass_wild_mixed_med");
}




farm106()
{
    setCustomModel((7276.62, -5107.18, -22.3117), (0, 147.353, 0), 0, "t5_foliage_bush05");
}


farm107()
{
    setCustomModel((7519.56, -5279.67, 7.02139), (0, -155.287, 0), 0, "t5_foliage_bush05");
}



farm109()
{
    setCustomModel((7571.58, -4796.23, 29.6721), (0, 19.7084, 0), 0, "t5_foliage_bush05");
}





bridge1()
{
    setCustomModel((-4223.1, 1142.75, 190.717), (0, -47.263, 0), 0, "t5_foliage_tree_burnt03");
}

bridge2()
{
    setCustomModel((-4223.1, 1142.75, 190.717), (0, -150.018, 0), 0, "t5_foliage_tree_burnt03");
}



bridge6()
{
    setCustomModel((-3669.44, 877.284, -2.50501), (0, -44.5988, 0), 0, "t5_foliage_tree_burnt03");
}    


bridge8()
{
    setCustomModel((-3694.54, 418.284, -11.3436), (0, 100.553, 0), 0, "t5_foliage_tree_burnt03");
}


bridge10()
{    
    setCustomModel((-3658.54, 359.23, -54.575), (0, 124.173, 0), 0, "t5_foliage_bush05");
}



bridge13()
{
    setCustomModel((-3564.63, 842.246, -56.709), (0, 163.878, 0), 0, "t5_foliage_bush05");
}

bridge14()
{
    setCustomModel((-3750.88, 395.714, -56.3194), (0, 40.4244, 0), 0, "t5_foliage_bush05");
}


bridge16()
{
    setCustomModel((-3365.49, 482.35, -92.5327), (0, -22.0274, 0), 0, "t5_foliage_shrubs02");
}



bridge18()
{
    setCustomModel((-3398, 418.687, -78.3112), (0, 50.9987, 0), 0, "t5_foliage_shrubs02");
}



bridge20()
{
    setCustomModel((-3521.67, 287.176, -50.7468), (0, 57.7883, 0), 0, "t5_foliage_shrubs02");
}







bridge24()
{
    setCustomModel((-3435.61, 493.924, -91.1827), (0, -19.962, 0), 0, "t5_foliage_bush05");
}

bridge25()
{
    setCustomModel((-4291.06, 1407.1, 217.09), (0, 24.1536, 0), 0, "t5_foliage_tree_burnt03");
}



bridge27()
{      
    setCustomModel((-4290.36, 1771.59, 345.172), (0, -172.095, 0), 0, "t5_foliage_bush05");
}



bridge29()
{
    setCustomModel((-3941.65, 1546.65, 602.171), (0, -114.439, 0), 0, "t5_foliage_bush05");
}



bridge31()
{
    setCustomModel((-4102.29, 1555.33, 569.856), (0, 167.586, 0), 0, "t5_foliage_bush05");
}

 

bridge33()
{
    setCustomModel((-4075.27, 1634.39, 562.746), (0, 161.433, 0), 0, "t5_foliage_bush05");
}



bridge35()
{
    setCustomModel((-4010.65, 1727.79, 607.976), (0, 165.147, 0), 0, "t5_foliage_bush05");
}

bridge36()
{
    setCustomModel((-5724.41, 1359.32, 176.249), (0, 2.74678, 0), 0, "t5_foliage_tree_burnt03");
}





bridge39()
{
    setCustomModel((-4986.62, 572.731, 145.293), (0, -37.4742, 0), 0, "t5_foliage_tree_burnt02");
}

bridge40()
{
    setCustomModel((-4963.78, -1274.49, 84.2256), (0, 66.819, 0), 0, "p6_zm_rocks_medium_05");
}

    



bridge43()
{
    setCustomModel((-4293.15, -1937.11, 86.3945), (0, 28.9162, 0), 0, "p6_zm_rocks_large_cluster_01");
}

bridge44()
{
    setCustomModel((-4789.64, -910.603, 68.7303), (0, 67.0443, 0), 0, "veh_t6_civ_60s_coupe_dead");
}

bridge45()
{
    setCustomModel((-4689.24, -886.451, 21.4933), (0, 96.9655, 0), 0, "t5_foliage_bush05");
}

bridge46()
{
    setCustomModel((-4732.65, -796.64, 0.42919), (0, -117.878, 0), 0, "t5_foliage_bush05");
}



bridge48()
{
    setCustomModel((-5717.86, 267.532, 129.263), (0, 13.7178, 0), 0, "t5_foliage_tree_burnt03" );
}



bridge50()
{
    setCustomModel((-6064.27, -758.759, 462.359), (0, 11.8831, 0), 0, "t5_foliage_tree_burnt03");
}

bridge51()
{
    setCustomModel((-6064.27, -758.759, 462.359), (0, -83.3354, 0), 0, "t5_foliage_tree_burnt03");
}



bridge53()
{
    setCustomModel((-6258.69, -166.285, 629.079), (0, -10.7872, 0), 0, "t5_foliage_tree_burnt03");
}



bridge55()
{
    setCustomModel((-6284.73, 328.835, 672.587), (0, -8.23833, 0), 0, "t5_foliage_tree_burnt03");
}      

bridge56()
{
    setCustomModel((-6282.71, 328.543, 672.37), (0, -140.008, 0), 0, "t5_foliage_tree_burnt03");
}



bridge58()
{
    setCustomModel((-6090.28, 1251.56, 562.342), (0, -51.3047, 0), 0, "t5_foliage_bush05");
}



bridge60()
{
    setCustomModel((-6196.13, 1120.08, 593.691), (0, 48.94, 0), 0, "t5_foliage_bush05");
}

bridge61()
{
    setCustomModel((-6284.63, 895.01, 670.314), (0, 70.0393, 0), 0, "t5_foliage_bush05");
}



bridge63()
{
    setCustomModel((-6311.54, 801.721, 666.044), (0, 156.035, 0), 0, "t5_foliage_bush05");
}



bridge68()
{
    setCustomModel((-6345.53, 1051.73, 678.717), (0, -15.5497, 0), 0, "t5_foliage_tree_burnt03");
}



bridge70()
{
    setCustomModel((-6335.46, 978.312, 671.959), (0, 111.315, 0), 0, "t5_foliage_shrubs02");
}





bridge73()
{
    setCustomModel((-6267.37, 976.87, 645.548), (0, -6.77166, 0), 0, "t5_foliage_shrubs02");
}

bridge74()
{
    setCustomModel((-5017.04, -994.101, 71.5109), (0, 4.20368, 0), 0, "veh_t6_civ_60s_coupe_dead");
}

bridge75()
{
    setCustomModel((-3656.24, -1079.36, 45.5098), (0, 9.87812, 0), 0, "t5_foliage_tree_burnt03");
}



bridge77()
{
    setCustomModel((-1981.97, -30.1783, -46.2209), (0, 171.223, 0), 0, "t5_foliage_tree_burnt03");
}

bridge78()
{
    setCustomModel((-1981.97, -30.1783, -46.2209), (0, -107.621, 0), 0, "t5_foliage_tree_burnt03");
}



bridge80()
{
    setCustomModel((-1981.97, -30.1783, -46.2209), (0, -19.5927, 0), 0, "t5_foliage_tree_burnt03");
}

bridge81()
{
    setCustomModel((-1981.97, -30.1783, -46.2209), (0, 81.2893, 0), 0, "t5_foliage_tree_burnt03");
}





tower1()
{
    setCustomTowers_AlwaysVisible((-361.77, -3295.51, 689.772), (0, -90.6907, 0), 0, "p_glo_powerline_tower_redwhite");
}

tower2()
{
    setCustomTowers_AlwaysVisible((-5314.63, -3306.74, 878.233), (0, -89.1636, 0), 0, "p_glo_powerline_tower_redwhite");
}

tower3()
{
    setCustomTowers_AlwaysVisible((-7661.7, -954.233, 769.686), (0, -164.816, 0), 0, "p_glo_powerline_tower_redwhite");
}

tower4()
{
    setCustomTowers_AlwaysVisible((-8265.76, 1480.97, 961.69), (0, 20.749, 0), 0, "p_glo_powerline_tower_redwhite");
}

tower5()
{
    setCustomTowers_AlwaysVisible((4305.39, -3328.49, 623.006), (0, -89.8777, 0), 0, "p_glo_powerline_tower_redwhite");
}




remaining1()
{
    setCustomModel((757.113, 4393.01, 321.408), (0, -45.1249, 0), 0, "t5_foliage_tree_burnt03");
}

remaining2()
{
    setCustomModel((1618.32, 4305.95, 146.669), (0, -164.294, 0), 0, "t5_foliage_tree_burnt03");
}

remaining3()
{
    setCustomModel((422.706, 2447.11, 346.621), (0, 3.65437, 0), 0, "t5_foliage_tree_burnt03");
}

remaining4()
{
    setCustomModel((2666.37, 2201.45, 117.567), (0, 43.6062, 0), 0, "t5_foliage_tree_burnt03");
}

remaining5()
{
    setCustomModel((2666.37, 2201.45, 117.567), (0, -166.288, 0), 0, "t5_foliage_tree_burnt03");
}

remaining6()
{
    setCustomModel((2608.94, 2300.52, 112.968), (0, 7.65888, 0), 0, "t5_foliage_tree_burnt03");
}

remaining7()
{
    setCustomModel((2615.44, 2250.8, 119.697), (0, 26.7037, 0), 0, "t5_foliage_tree_burnt03");
}

remaining8()
{
    setCustomModel((5471.86, 3205.79, 287.083), (0, 93.0666, 0), 0, "t5_foliage_tree_burnt03");
}

remaining9()
{
    setCustomModel((417.058, 3784.8, 408.645), (0, -4.84905, 0), 0, "t5_foliage_tree_burnt03");
}

remaining10()
{
    setCustomModel((-127.018, 3764.99, 780.752), (0, -6.12896, 0), 0, "t5_foliage_tree_burnt03");
}

remaining11()
{
    setCustomModel((-37.5383, 2840.51, 694.795), (0, -17.4888, 0), 0, "t5_foliage_tree_burnt03");
}

remaining12()
{
    setCustomModel((720.508, 2299.37, 177.628), (0, -0.547905, 0), 0, "t5_foliage_tree_burnt03");
}

remaining13()
{
    setCustomModel((8445.89, 9856.22, -484.029), (0, -104.731, 0), 0, "t5_foliage_tree_burnt03");
}

remaining14()
{
    setCustomModel((8132.12, 10024.1, -499), (0, -90.5259, 0), 0, "t5_foliage_tree_burnt03");
}

remaining15()
{
    setCustomModel((8947.27, 11932.8, -231.569), (0, 66.628, 0), 0, "t5_foliage_tree_burnt03");
}

remaining16()
{
    setCustomModel((8806.85, 11587.8, -349.715), (0, 66.7379, 0), 0, "t5_foliage_tree_burnt03");
}

remaining17()
{
    setCustomModel((11423.6, 4386.62, -435.702), (0, 122.982, 0), 0, "t5_foliage_tree_burnt03");
}

remaining18()
{
    setCustomModel((10899.8, 3326.39, 181.907), (0, 117.621, 0), 0, "t5_foliage_tree_burnt03");
}

remaining19()
{
    setCustomModel((10008.8, 3943.67, -131.873), (0, 118.11, 0), 0, "t5_foliage_tree_burnt03");
}

remaining20()
{
    setCustomModel((11569.8, 3563.66, 107.09), (0, -46.5477, 0), 0, "t5_foliage_tree_burnt03");
}

remaining21()
{
    setCustomModel((10015.9, 4506.65, -450.447), (0, 118.483, 0), 0, "t5_foliage_tree_burnt03");
}

remaining22()
{
    setCustomModel((-463.903, -588.599, -61.875), (0, -178.582, 0), 0, "t5_foliage_tree_burnt03");
}

remaining23()
{
    setCustomModel((-463.903, -588.599, -61.875), (0, -178.582, 0), 0, "collision_player_64x64x256"); //player clip
}

remaining24()
{
    setCustomModel((-706.382, -218.686, -110.161), (0, -133.181, 0), 0, "t5_foliage_tree_burnt03");
}


remaining25()
{
    setCustomModel((-706.382, -218.686, -110.161), (0, -133.181, 0), 0, "collision_player_64x64x256"); //player clip
}

remaining26()
{
    setCustomModel((-423.428, -590.588, -61.875), (0, 105.02, 0), 0, "t5_foliage_shrubs02");
}

remaining27()
{
    setCustomModel((-487.484, -639.605, -61.7362), (0, 177.152, 0), 0, "t5_foliage_shrubs02");
}

remaining28()
{
    setCustomModel((-514.176, -565.473, -60.1435), (0, 50.8204, 0), 0, "t5_foliage_shrubs02");
}

remaining29()
{
    setCustomModel((-701.033, -163.57, -48.875), (0, 146.264, 0), 0, "t5_foliage_shrubs02");
}

remaining30()
{
    setCustomModel((-666.085, -247.108, -49.8501), (0, -132.053, 0), 0, "t5_foliage_shrubs02");
}


remaining31()
{
    setCustomModel((-629.588, -268.44, -55.4091), (0, 161.672, 0), 0, "t5_foliage_shrubs02");
}


















diner1()
{
    setCustomModel((-8003.83, -7525.89, 109.39), (0, 130.968, 0), 0, "t5_foliage_tree_burnt03");
}

diner2()
{
    setCustomModel((-8003.83, -7525.89, 109.39), (0, -40.1663, 0), 0, "t5_foliage_tree_burnt03");
}

diner3()
{
    setCustomModel((-7404.52, -7695.12, 41.7818), (0, -15.1944, 0), 0, "t5_foliage_tree_burnt03");
}

diner4()
{
    setCustomModel((-7404.52, -7695.12, 41.7818), (0, 127.782, 0), 0, "t5_foliage_tree_burnt03");
}

diner5()
{
    setCustomModel((-6998, -7870.71, 37.3717), (0, 114.29, 0), 0, "t5_foliage_tree_burnt03");
}

diner6()
{
    setCustomModel((-6998, -7870.71, 37.3717), (0, 114.29, 0), 0, "t5_foliage_tree_burnt02");
}

diner7()
{
    setCustomModel((-7805.73, -5674.58, 470.505), (0, -43.4622, 0), 0, "t5_foliage_tree_burnt03");
}




diner9()
{
    setCustomModel((-8332.4, -5339.63, 839.054), (0, -58.4146, 0), 0, "t5_foliage_tree_burnt03");
}




diner11()
{
    setCustomModel((-7455.16, -5621.79, 357.846), (0, -47.1646, 0), 0, "t5_foliage_tree_burnt03");
}




diner13()
{
    setCustomModel((-8921.39, -6917.33, 189.044), (0, 143.195, 0), 0, "t5_foliage_tree_burnt03");
}



diner15()
{
    setCustomModel((-7920.35, -8049.54, 56.597), (0, -59.9198, 0), 0, "t5_foliage_tree_burnt03");
}



diner17()
{
    setCustomModel((-6319.25, -7105.3, -88.263), (0, -32.2507, 0), 0, "t5_foliage_tree_burnt02");
}

diner18()
{
    setCustomModel((-6319.25, -7105.3, -88.263), (0, -172.42, 0), 0, "t5_foliage_tree_burnt02");
}

diner19()
{
    setCustomModel((-5628.64, -4740.43, -1.89555), (0, -89.8575, 0), 0, "t5_foliage_tree_burnt03");
}

diner20()
{
    setCustomModel((-5313.63, -4262.63, 130.718), (0, -58.1784, 0), 0, "t5_foliage_tree_burnt03");
}

diner21()
{
    setCustomModel((-5313.63, -4262.63, 130.718), (0, -153.847, 0), 0, "t5_foliage_tree_burnt03");
}

diner22()
{
    setCustomModel((-7278.46, -7082.85, 4.88449), (0, 90.1974, 0), 0, "t5_foliage_tree_burnt03");
}

diner23()
{
    setCustomModel((-7278.46, -7082.85, 4.88449), (0, -42.5119, 0), 0, "t5_foliage_tree_burnt03");
}

diner23()
{
    setCustomModel((-8929.05, -6904.74, 173.372), (0, -33.3769, 0), 0, "t5_foliage_tree_burnt03");
}

diner24()
{
    setCustomModel((-7100.17, -9435.75, 222.094), (0, 68.9333, 0), 0, "t5_foliage_tree_burnt03");
}

diner25()
{
    setCustomModel((-7100.17, -9435.75, 222.094), (0, 59.4191, 0), 0, "t5_foliage_tree_burnt03");
}

diner26()
{
    setCustomModel((-4390.38, -6614.15, -75.5248), (0, 6.86049, 0), 0, "collision_player_64x64x256");
}

diner27()
{
    setCustomModel((-4390.52, -6615.74, -82.0079), (0, -107.441, 0), 0, "t5_foliage_tree_burnt03");
}

diner28()
{
    setCustomModel((-4390.52, -6615.74, -82.0079), (0, 6.30019, 0), 0, "t5_foliage_tree_burnt03");
}

diner29()
{
    setCustomModel((-4390.52, -6615.74, -82.0079), (0, 134.428, 0), 0, "t5_foliage_tree_burnt03");
}

diner30()
{
    setCustomModel((-3271.97, -4455.43, -134.851), (0, -103.728, 0), 0, "t5_foliage_tree_burnt03");
}

diner31()
{
    setCustomModel((-3177.97, -4737.14, -124.066), (0, -123.146, 0), 0, "t5_foliage_tree_burnt03");
}

diner32()
{
    setCustomModel((-3958.29, -5091.87, -135.419), (0, -107.287, 0), 0, "t5_foliage_tree_burnt03");
}   



diner38()
{
    setCustomModel((-5431.69, 4657.36, -47.531), (0, -107.237, 0), 0, "t5_foliage_tree_burnt03");
}

diner39()
{
    setCustomModel((-5431.69, 4657.36, -47.531), (0, 172.727, 0), 0, "t5_foliage_tree_burnt03");
}

diner40()
{
    setCustomModel((-5445.05, 4939.06, -38.5458), (0, -101.316, 0), 0, "t5_foliage_tree_burnt03");
}

diner41()
{
    setCustomModel((-5443.13, 4937.91, -62.7424), (0, 116.12, 0), 0, "t5_foliage_tree_burnt03");
}

diner42()
{
    setCustomModel((-7368.34, -10175.3, 326.494), (0, -148.76, 0), 0, "veh_t6_civ_bus_zombie");
}

diner43()
{
    setCustomModel((-7304.37, -9994.47, 311), (0, 165.02, 0), 0, "veh_t6_civ_bus_zombie");
}

diner44()
{
    setCustomModel((-7319.97, -9417.25, 230.75), (0, -123.305, 0), 0, "veh_t6_civ_bus_zombie");
}


diner45()
{
    setCustomModel((-7991.36, -9712.84, 276.655), (0, -16.9188, 0), 0, "veh_t6_civ_bus_zombie");
}

diner46()
{
    setCustomModel((-7513.44, -7907.17, 67.166), (0, 150.7, 0), 0, "veh_t6_civ_smallwagon_dead");
}

diner47()
{
    setCustomModel((-8109.3, -8178.8, 67.3403), (0, -56.3487, 0), 0, "veh_t6_civ_microbus_dead");
}


diner48()
{
    setCustomModel((-8121.81, -10016.2, 345.822), (0, -98.8768, 0), 0, "veh_t6_civ_microbus_dead");
}

diner49()
{
    setCustomModel((-8090.45, -9264.25, 319.511), (0, -95.2787, 0), 0, "veh_t6_civ_movingtrk_cab_dead");
}

diner50()
{
    setCustomModel((-7946.66, -9174.33, 179.694), (0, 149.711, 0), 0, "veh_t6_civ_microbus_dead");
}

diner51()
{
    setCustomModel((-7978.46, -9404.86, 214.768), (0, -113.082, 0), 0, "veh_t6_civ_microbus_dead");
}

diner52()
{
    setCustomModel((-8241.51, -9078.05, 227.842), (0, -42.83, 0), 0, "veh_t6_civ_microbus_dead");
}

diner53()
{
    setCustomModel((-7567.89, -9410.99, 210.307), (0, -85.413, 0), 0, "t5_foliage_bush05");
}

diner54()
{
    setCustomModel((-7530.99, -9064.53, 143.173), (0, -70.197, 0), 0, "t5_foliage_bush05");
}

diner55()
{
    setCustomModel((-8077.62, -9080.55, 149.964), (0, -96.9651, 0), 0, "t5_foliage_bush05");
}

diner56()
{
    setCustomModel((-8030.31, -8924.37, 96.0496), (0, -92.4278, 0), 0, "t5_foliage_bush05");
}

diner57()
{
    setCustomModel((-7644.13, -8778.21, 122.136), (0, -83.9189, 0), 0, "t5_foliage_bush05");
}

diner58()
{
    setCustomModel((-7688.91, -8472.85, 74.5805), (0, 103.75, 0), 0, "t5_foliage_bush05");
}

diner59()
{
    setCustomModel((-7736.76, -8097.24, 53.0842), (0, 111.319, 0), 0, "t5_foliage_bush05");
}

diner60()
{
    setCustomModel((-7113.82, -9261.12, 172.855), (0, -111.549, 0), 0, "t5_foliage_bush05");
}


diner61()
{
    setCustomModel((-7142.08, -9600.46, 235.912), (0, -84.9351, 0), 0, "t5_foliage_bush05");
}

diner62()
{
    setCustomModel((-7279.77, -9261.2, 177.899), (0, -128.271, 0), 0, "t5_foliage_bush05");
}


diner63()
{
    setCustomModel((-7215.45, -9226.67, 151.236), (0, -82.1995, 0), 0, "t5_foliage_shrubs02");
}

diner64()
{
    setCustomModel((-7215.95, -9223.05, 188.317), (0, -82.2709, 0), 0, "t5_foliage_shrubs02");
}

diner65()
{
    setCustomModel((-7174.49, -9238.04, 177.988), (0, -99.7776, 0), 0, "t5_foliage_shrubs02");
}

diner66()
{
    setCustomModel((-7241.18, -9682.42, 245.007), (0, 78.7392, 0), 0, "t5_foliage_bush05");
}







busstation01()
{
    setCustomModel((-7727.14, 6064.19, -69.6577), (0, -32.2782, 0), 0, "veh_t6_civ_bus_zombie");
}

busstation02()
{
    setCustomModel((-8018.28, 5862.9, -53.2876), (0, 115.12, 0), 0, "veh_t6_civ_smallwagon_dead");
}

busstation03()
{
    setCustomModel((-5826.63, 6046.58, -63.2757), (0, -57.163, 0), 0, "veh_t6_civ_bus_zombie");
}


busstation1()
{
   setCustomModel((-8253.58, 5872.98, -52.668), (0, -146.927, 0), 0, "veh_t6_civ_bus_zombie");
}
busstation2()
{
    setCustomModel((-9003.57, 7907.91, -73.2901), (0, -34.6409, 0), 0, "veh_t6_civ_bus_zombie");
}
busstation3()
{
    setCustomModel((-8801.54, 7778.41, -49.4984), (0, -35.8005, 0), 0, "veh_t6_civ_bus_zombie");  
}
busstation4()
{
    setCustomModel((-7785.08, 7173.3, -61.9243), (0, -154.019, 0), 0, "veh_t6_civ_smallwagon_dead");
}


busstation23()
{
    setCustomModel((-7687.79, 6240.15, -57.9351), (0, -107.953, 0), 0, "veh_t6_civ_smallwagon_dead");
}
busstation24()
{
    setCustomModel((-7637.66, 6037.63, -70.9925), (0, 27.5247, 0), 0, "veh_t6_civ_smallwagon_dead");
}
busstation25()
{
    setCustomModel((-7589.92, 5566.18, -63.1493), (0, -139.264, 0), 0, "veh_t6_civ_smallwagon_dead");
}
busstation26()
{
    setCustomModel((-8275.9, 6197.28, -55.85), (0, -91.0892, 0), 0, "t5_foliage_tree_burnt03");
}
busstation27()
{
    setCustomModel((-8275.9, 6197.28, -55.85), (0, -0.325684, 0), 0, "t5_foliage_tree_burnt03");
}
busstation28()
{
    setCustomModel((-8266.73, 6555.11, -63.4538), (0, -89.3534, 0), 0, "t5_foliage_tree_burnt03");
}
busstation29()
{
    setCustomModel((-8811.57, 6025.05, -66.0919), (0, -22.0786, 0), 0, "t5_foliage_tree_burnt03");
}
busstation30()
{
    setCustomModel((-8266.69, 6957.93, -50.5425), (0, -83.7174, 0), 0, "t5_foliage_tree_burnt03");
}
busstation31()
{
    setCustomModel((-8269.05, 6979.87, -50.4076), (0, -83.8328, 0), 0, "t5_foliage_tree_burnt03");
}
busstation32()
{
    setCustomModel((-6203.98, 5753.56, -43.0387), (0, -112.177, 0), 0, "t5_foliage_tree_burnt03");
}
busstation33()
{
    setCustomModel((-6203.98, 5753.56, -43.0387), (0, 154.137, 0), 0, "t5_foliage_tree_burnt03");
}
busstation34()
{
    setCustomModel((-4681.81, 6483.46, 95.5973), (0, -178.326, 0), 0, "t5_foliage_tree_burnt02");
}
busstation35()
{
    setCustomModel((-4681.81, 6483.46, 95.5973), (0, -26.6105, 0), 0, "t5_foliage_tree_burnt02");
}
busstation36()
{
    setCustomModel((-5586.5, 6094.63, -81.0404), (0, -112.557, 0), 0, "t5_foliage_tree_burnt02");
}
busstation37()
{
    setCustomModel((-5586.5, 6094.63, -81.0404), (0, 111.208, 0), 0, "t5_foliage_tree_burnt02");
}
busstation38()
{
    setCustomModel((-5779.05, 6158.45, -99.6991), (0, -157.699, 0), 0, "t5_foliage_tree_burnt02");
}
busstation39()
{
    setCustomModel((-5779.05, 6158.45, -99.6991), (0, -157.699, 0), 0, "t5_foliage_tree_burnt02");
}
busstation40()
{
    setCustomModel((-5469.84, 7261.89, -113.305), (0, -102.806, 0), 0, "t5_foliage_tree_burnt03");
}
busstation41()
{
    setCustomModel((-5469.84, 7261.89, -113.305), (0, 43.1692, 0), 0, "t5_foliage_tree_burnt03");
}
busstation42()
{
    setCustomModel((-5480.93, 7198.87, -109.069), (0, -100.147, 0), 0, "t5_foliage_tree_burnt03");
}
busstation43()
{
    setCustomModel((-4737.39, 6434.84, 264.71), (0, -121.137, 0), 0, "t5_foliage_bush05");
}
busstation44()
{
    setCustomModel((-7797.49, 4977.6, -92.1175), (0, -60.9664, 0), 0, "t5_foliage_bush05");
}
busstation45()
{
    setCustomModel((-7911.48, 5282.6, -99.5676), (0, -166.463, 0), 0, "t5_foliage_bush05");
}
busstation46()
{
    setCustomModel((-8445.78, 4842.02, -79.2976), (0, -20.2895, 0), 0, "t5_foliage_tree_burnt03");
}
busstation47()
{
    setCustomModel((-8445.7, 4841.97, -70.6798), (0, -20.2895, 0), 0, "collision_player_64x64x256");
}
busstation48()
{
    setCustomModel((-8445.7, 4841.97, -70.6798), (0, -20.2895, 0), 0, "collision_clip_cylinder_32x128");
}
busstation49()
{
    setCustomModel((-8484.26, 4874.45, -45.0461), (0, 35.6254, 0), 0, "p6_grass_wild_mixed_med");
}
busstation50()
{
    setCustomModel((-8458.73, 4796.23, -44.3172), (0, 10.8073, 0), 0, "p6_grass_wild_mixed_med");
}
busstation51()
{
    setCustomModel((-8419.05, 4885.93, -48.5525), (0, 75.0993, 0), 0, "p6_grass_wild_mixed_med");
}
busstation52()
{
    setCustomModel((-8403.68, 4818.25, -52.5306), (0, -148.478, 0), 0, "p6_grass_wild_mixed_med");
}
busstation53()
{
    setCustomModel((-8501.89, 4825.19, -42.4145), (0, -29.9904, 0), 0, "t5_foliage_shrubs02");
}
busstation54()
{
    setCustomModel((-8447.36, 4776.19, -47.1136), (0, 89.8209, 0), 0, "t5_foliage_shrubs02");
}
busstation55()
{
    setCustomModel((-8366.91, 4802.55, -52.7677), (0, 100.807, 0), 0, "t5_foliage_shrubs02");
}
busstation56()
{
    setCustomModel((-8420.52, 4901.4, -47.8913), (0, -94.5022, 0), 0, "t5_foliage_shrubs02");
}
busstation57()
{
    setCustomModel((-9535.12, 4600.45, 53.3986), (0, 8.67043, 0), 0, "t5_foliage_tree_burnt02");
}
busstation58()
{
    setCustomModel((-9535.12, 4600.45, 53.3986), (0, 141.303, 0), 0, "t5_foliage_tree_burnt02");
}
busstation59()
{
    setCustomModel((-9535.12, 4600.45, 53.3986), (0, -77.6656, 0), 0, "t5_foliage_tree_burnt02");
}
busstation60()
{
    setCustomModel((-8898.6, 4690.51, -50.3906), (0, -136.14, 0), 0, "t5_foliage_tree_burnt03");
}
busstation61()
{
    setCustomModel((-8898.6, 4690.51, -50.3906), (0, 65.7664, 0), 0, "t5_foliage_tree_burnt03");
}
busstation62()
{
    setCustomModel((-8898.14, 4690.6, -45.4872), (0, -166.77, 0), 0, "collision_player_64x64x256");
}
busstation63()
{
    setCustomModel((-8898.14, 4690.6, -45.4872), (0, -166.77, 0), 0, "collision_clip_cylinder_32x128");
}
busstation64()
{
    setCustomModel((-8932.52, 4731.11, -24.1036), (0, -140.941, 0), 0, "p6_grass_wild_mixed_med");
}
busstation65()
{
    setCustomModel((-8850.96, 4696.97, -25.6255), (0, -106.604, 0), 0, "p6_grass_wild_mixed_med");
}
busstation66()
{
    setCustomModel((-8940.24, 4663.29, -15.9679), (0, 25.5235, 0), 0, "t5_foliage_shrubs02");
}
busstation67()
{
    setCustomModel((-8845.79, 4654.37, -22.2974), (0, -27.1779, 0), 0, "t5_foliage_shrubs02");
}
busstation68()
{
    setCustomModel((-8934.34, 4730.62, -23.8941), (0, 69.8368, 0), 0, "t5_foliage_shrubs02");
}
busstation69()
{
    setCustomModel((-8843.04, 4738.06, -28.4217), (0, -120.633, 0), 0, "t5_foliage_shrubs02");
}
busstation70()
{
    setCustomModel((-7807.15, 3784.42, -40.9065), (0, 83.1907, 0), 0, "t5_foliage_bush05");
}
busstation71()
{
    setCustomModel((-7906.93, 3926.35, -31.6586), (0, 67.0353, 0), 0, "t5_foliage_bush05");
}

///EFFECTS///
////////////
///////////

