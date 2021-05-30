#include maps/mp/animscripts/zm_death;
#include maps/mp/_visionset_mgr;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/_utility;
#include common_scripts/utility;

//#namespace zm_transit_lava;
//#namespace ultimateman_zm_transit_lava_disable


object_touching_lava()
{
	if( isdefined( level.lava ) )
	{
		level.lava = getentarray( "lava_damage", "targetname" );
	}
	if( !isdefined( level.lava ) || level.lava.size < 1 )
	{
		return 0;
	}
	if( isdefined( self.lasttouching ) && self istouching( self.lasttouching ) )
	{
		return 0; //OG VALUE: return 1;
	}
	for( i = 0; i < level.lava.size; i++ ) //Can't use continue; in for & for each loops. Will need to comment out now and make a while ( 1 ) loop instead
	{
		if( distancesquared( self.origin, level.lava[ i ].origin) < 2250000 )
		{
			if( isdefined( level.lava[ i ].target ) )
			{
				if( self istouching( level.lava[ i ].volume ) )
				{
					if( isdefined(level.lava[ i ].script_float ) && level.lava[ i ].script_float <= 0.1 )
					{
						return 0;
					}
					self.lasttouching = level.lava[ i ].volume;
					return 0; //OG VALUE: return 1;
				}
				//continue;
			}
			if( self istouching( level.lava[ i ] ) )
			{
				self.lasttouching = level.lava[ i ];
				return 0; //OG VALUE: return 1;
			}
		}
	}
	self.lasttouching = undefined;
	return 0;
}


lava_damage_init()
{
	lava = getentarray( "lava_damage", "targetname" );
	if( isdefined( lava ) )
	{
		return;
	}
	array_thread( lava, ::lava_damage_think ); //fixed syntax
}


lava_damage_think()
{
	self._trap_type = "";
	if( isdefined( self.script_noteworthy ) )
	{
		self._trap_type = self.script_noteworthy;
	}
	if( isdefined( self.target ) )
	{
		self.volume = getent( self.target, "targetname" );
/*
		/#
			assert(isdefined(self.volume), "No volume found for lava target " + self.target);
		#/
*/
	}

	while( 1 )
	{
		self waittill( "trigger" );
		
		if( isdefined( ent.ignore_lava_damage ) && ent.ignore_lava_damage )
		{
			continue;
		}
		if( isdefined( ent.is_burning ) )
		{
			continue;
		}
		if( isdefined( self.target ) && !ent istouching( self.volume ) )
		{
			continue;
		}
		/*
		if( isplayer( ent ) )
		{
			switch( self._trap_type )
			{
				case "fire":
				case default:
				{
					if( !isdefined( self.script_float ) || self.script_float >= 0.1 )
					{
						//ent thread player_lava_damage( self ); //Commented out to not break equipments while in lava
						break;
					}
				}
			}
			break;
		}
		
		if( isdefined( ent.marked_for_death ) )
		{
			switch( self._trap_type )
			{
				case "fire":
				case default:
				{
					if( !isdefined(self.script_float ) || self.script_float >= 0.1 )
					{
						//ent thread zombie_lava_damage(self); /Commented out to not break equipments while in lava
						break;
					}
				}
			}
		}
		*/
	}
}

player_lava_damage( trig )
{
	self endon( "zombified" );
	self endon( "death" );
	self endon( "disconnect" );
	//All can be changed to 0
	max_dmg = 0;    //OGvalue 15
	min_dmg = 0;    //OGvalue 15
	burn_time = 0; //OGvalue 15
	if( isdefined( self.is_zombie ) && self.is_zombie )
	{
		return;
	}
	//self thread player_stop_burning(); Needs to be commented out since later in the script there is no function to set player on fire.
	if( isdefined( trig.script_float ) )
	{
		max_dmg = max_dmg * trig.script_float;
		min_dmg = min_dmg * trig.script_float;
		burn_time = burn_time * trig.script_float;
		if(burn_time >= 1.5)
		{
			burn_time = 1.5;
		}
	}
	if( !isdefined(self.is_burning ) && is_player_valid( self ) )
	{
		self.is_burning = 0; //1
		//maps/mp/_visionset_mgr::vsmgr_activate("overlay", "zm_transit_burn", self, burn_time, level.zm_transit_burn_max_duration); Comment out overlay
		//self notify("burned"); Don't notify to activate overlay
		if(isdefined( trig.script_float ) && trig.script_float >= 0.1 )
		{
			//self thread player_burning_fx(); DONT DO FXS "FLAMES ON PLAYER's FEEETTTTTTTTTTTTTTTTTT
		}
		/* //////DO DAMAGE, IF PLAYER HAS / HAS NOT JUUGGG DISABLE ALL TOGETHER OOH YEAAAH BOIIIII
		if( !self hasperk( "specialty_armorvest" ) || self.health - 100 < 1 )
		{
			radiusdamage( self.origin, 10, max_dmg, min_dmg );
			wait( 0.5 );
			self.is_burning = undefined;
		}
		else if(self hasperk( "specialty_armorvest" ) )
		{
			self dodamage( 15, self.origin );
		}
		else
		{
			self dodamage( 1, self.origin );
		}
		*/
		wait( 0.5 );
		self.is_burning = undefined;
	}
}
/*
player_stop_burning() //Can be commented out since player never catches fire in the first place.
{
	self notify("player_stop_burning");
	self endon("player_stop_burning");
	self endon("death_or_disconnect");
	self waittill("zombified");self notify("stop_flame_damage");
	maps/mp/_visionset_mgr::vsmgr_deactivate("overlay", "zm_transit_burn", self);
}
*/

/*
zombie_burning_fx() //Comment this out since map has frostbite instead of lava fx
{
	self endon("death");
	if(isdefined(self.is_on_fire) && self.is_on_fire)
	{
		return;
	}
	self.is_on_fire = 1;
	self thread maps/mp/animscripts/zm_death::on_fire_timeout();
	if(isdefined(level._effect) && isdefined(level._effect["lava_burning"]))
	{
		if(self.isdog)
		{
			playfxontag(level._effect["lava_burning"], self, "J_SpineLower");
			self thread zombie_burning_audio();
		}
	}
	if(isdefined(level._effect) && isdefined(level._effect["character_fire_death_sm"]))
	{
		wait(1);
		if(randomint(2) > 1)
		{
			tagarray = [];
			tagarray[0] = "J_Elbow_LE";
			tagarray[1] = "J_Elbow_RI";
			tagarray[2] = "J_Knee_RI";
			tagarray[3] = "J_Knee_LE";
			tagarray = randomize_array(tagarray);
			playfxontag(level._effect["character_fire_death_sm"], self, tagarray[0]);
		}
		else
		{
			tagarray[0] = "J_Wrist_RI";
			tagarray[1] = "J_Wrist_LE";
			if(!isdefined(self.a.gib_ref) || self.a.gib_ref != "no_legs")
			{
				tagarray[2] = "J_Ankle_RI";
				tagarray[3] = "J_Ankle_LE";
			}
			tagarray = randomize_array(tagarray);
			playfxontag(level._effect["character_fire_death_sm"], self, tagarray[0]);
		}
	}
}
*/

zombie_burning_audio() //Can leave on, check syntax
{
	self playloopsound( "zmb_fire_loop" );
	self waittill_either( "stop_flame_damage", "death" );
	if(isdefined( self ) && isalive( self ) )
	{
		self stoploopsound( 0.25 );
	}
}
/* ////Dont include this shit
player_burning_fx()
{
	self endon("death");
	if(isdefined(self.is_on_fire) && self.is_on_fire)
	{
		return;
	}
	if(isdefined(self.no_burning_sfx) && self.no_burning_sfx)
	{
		self thread player_burning_audio();
	}
	self.is_on_fire = 1;
	self thread maps/mp/animscripts/zm_death::on_fire_timeout();
	if(isdefined(level._effect) && isdefined(level._effect["character_fire_death_sm"]))
	{
		playfxontag(level._effect["character_fire_death_sm"], self, "J_SpineLower");
	}
}
*/
//Fuck the audio
/*
player_burning_audio()
{
	fire_ent = spawn("script_model", self.origin);
	wait_network_frame();
	fire_ent linkto(self);
	fire_ent playloopsound("evt_plr_fire_loop");
	self waittill_any("stop_flame_damage", "stop_flame_sounds", "death", "discoonect");
	fire_ent delete();
}
*/


zombie_lava_damage( trap )
{
	self endon( "death" );
	zombie_dmg = 1;
	if( isdefined( self.script_float ) )
	{
		zombie_dmg = zombie_dmg * self.script_float;
	}
	/*
	switch( trap._trap_type )
	{
		case "fire":
		case default:
		{
			if( isdefined( self.animname ) && !isdefined( self.is_on_fire ) || !self.is_on_fire )
			{
				if( level.burning_zombies.size < 6 && zombie_dmg >= 1 )
				{
					level.burning_zombies[ level.burning_zombies.size ] = self;
					self playsound( "ignite" );
					self thread zombie_burning_fx();
					self thread zombie_burning_watch();
					self thread zombie_burning_dmg();
					self thread zombie_exploding_death( zombie_dmg, trap );
					wait( randomfloat( 1.25 ) );
				}
			}
			if( self.health > level.zombie_health / 2 && self.health > zombie_dmg )
			{
				self dodamage( zombie_dmg, self.origin, trap );
				break;
			}
		}
	}
	*/
}


zombie_burning_watch()
{
	self waittill_any( "stop_flame_damage", "death" );
	arrayremovevalue( level.burning_zombies, self );
}

zombie_exploding_death( zombie_dmg, trap )
{
	self endon( "stop_flame_damage" );
	if( isdefined( self.isdog ) && self.isdog && isdefined( self.a.nodeath ) )
	{
		return;
	}
	while( isdefined( self ) && self.health >= zombie_dmg && isdefined( self.is_on_fire ) && self.is_on_fire )
	{
		wait( 0.5 );
	}
	if(!isdefined(self) || isdefined( self.is_on_fire ) && !self.is_on_fire || isdefined( self.damageweapon ) && self.damageweapon == "tazer_knuckles_zm" || self.damageweapon == "jetgun_zm" || isdefined( self.knuckles_extinguish_flames ) && self.knuckles_extinguish_flames )
	{
		return;
	}
	tag = "J_SpineLower";
	if( isdefined( self.animname ) && self.animname == "zombie_dog" )
	{
		tag = "tag_origin";
	}
	if( is_mature() )
	{
		if( isdefined( level._effect[ "zomb_gib" ] ) )
		{
			playfx( level._effect[ "zomb_gib" ], self gettagorigin( tag ) );
		}
	}
	else if(isdefined( level._effect[ "spawn_cloud"] ) )
	{
		playfx( level._effect[ "spawn_cloud" ], self gettagorigin( tag ) );
	}
	self radiusdamage( self.origin, 128, 30, 15, undefined, "MOD_EXPLOSIVE" );
	self ghost();
	if( isdefined( self.isdog ) && self.isdog )
	{
		self hide();
	}
	else
	{
		self delay_thread( 1, ::self_delete ); //fixed syntax
	}
}

zombie_burning_dmg()
{
	self endon( "death" );
	damageradius = 25;
	damage = 2;
	while( isdefined( self.is_on_fire ) && self.is_on_fire )
	{
		eyeorigin = self geteye();
		players = get_players();
		for( i = 0; i < players.size; i++ )
		{
			if( is_player_valid( players[ i ] ) )
			{
				playereye = players[ i ] geteye();
				if( distancesquared( eyeorigin, playereye ) < damageradius * damageradius )
				{
					players[ i ] dodamage( damage, self.origin, self );
					players[ i ] notify( "burned" );
				}
			}
		}
		wait( 1 );
	}
}

