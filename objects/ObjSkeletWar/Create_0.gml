/// @description Varribles
hsp = 1;
vsp=0;
grv=0.2;
StopAnimationDead = 1;
//Attack
DamageSkeletWar = 0.01;
hp = 5;
maul = 0;
CooldownSkeletWar = 0;
CooldownAttackWar = 0;

enum ANIMATION
{
	IDLE,
	WALK,
	DEAD,
	HIT,
	ATTACK
}

state = ANIMATION.WALK;