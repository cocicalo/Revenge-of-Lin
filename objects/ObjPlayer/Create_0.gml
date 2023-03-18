/// @description все переменные
hsp=0;
vsp=0;
grv=0.2;
walksp=4;

cooldown = 0;
attack = 0;
damage = 1;
hp = 5;

Ladder = 0;

CooldownAnimationHit = 100;
enum ANIMATIONPLAYER
{
	FREE, 
	ATTACK,
	HIT,
	DEAD,
	LADDER
}

StatePlayer = ANIMATIONPLAYER.FREE;