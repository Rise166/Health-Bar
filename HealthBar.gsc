#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_powerups;
#include maps\mp\gametypes_zm\spawnlogic;
#include maps\mp\gametypes_zm\_hostmigration;
#include maps\mp\zombies\_zm_laststand;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\gametypes_zm\_hud_message;


init()
{
    level endon("end_game");
    level thread onplayerconnect();
}
onplayerconnect()
{
    for(;;)
        {
            level waittill("connected",player);
            player thread onplayerspawn();
            player thread healthBar();
            player thread healthBarprogress();
        }
}
onplayerspawn()
{
    level endon("game_ended");
    self endon("disconnect");
    for(;;)
        { 
            self waittill("spawned_player");
        }   
}
healthBar()
{
    flag_wait( "initial_blackscreen_passed" );
    self endon("disconnect");
    level endon("end_game");
    self.healthprogressbar = createPrimaryProgressBar();
    self.healthprogressbar setPoint ("CENTER","CENTER", 360, 90);
    self.healthprogressbar.color = (0,0,0);
    self.healthprogressbar.bar.color = (1,0,0);
    self.healthprogressbar.alpha = 1;
    self.healthprogressbar.archived = 1;
    // self.test_healthPercentage = createFontString("Objective", 1.5);
    // self.test_healthPercentage setPoint ("CENTER","CENTER", 0, 0); //for testing health_percentage
}
    
//main backend update bar
    
healthBarprogress()
{
    while(self.maxhealth > 0)
        {  
            self endon("disconnect");
            level endon("end_game");
            health_percentage = (int(self.health) / int(self.maxhealth));
            self.healthprogressbar updateBar(health_percentage);
            self.test_healthPercentage setvalue(health_percentage);
    if(health_percentage > 0.7) 
                {
                    self.healthprogressbar.bar.color = (0, 1, 0); //🟢
                }
            else if(health_percentage > 0.4)
                {
                    self.healthprogressbar.bar.color = (1, 0.5, 0);  //🟠
                }
            else if(health_percentage > 0)
                {
                    self.healthprogressbar.bar.color = (1, 0, 0);  //🔴
                }
            wait 0.05;
            waittillframeend;
        }
}



// (0, 1, 0); //full 🟢 
// (1, 1, 0); //medium 🟡 
// (1, 0.5, 0); //low 🟠
// (1, 0, 0); //very low 🔴 


