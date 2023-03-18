/// @description 
key_left=keyboard_check(ord("A"));
key_right=keyboard_check(ord("D"));
key_jump=keyboard_check(vk_space);


if(mouse_check_button(mb_left)) attack = 1;
else attack = 0;

var move = key_right-key_left;
hsp = move * walksp;
/*Calculeted moment*/
switch(StatePlayer)
{
	case ANIMATIONPLAYER.FREE:
	{
		if(vsp < 5) vsp+=grv;
		if(hp <= 0)
		{
			StatePlayer = ANIMATIONPLAYER.DEAD;
		}
		else
		{	
			if(place_meeting(x,y+1,ObjWall) && key_jump)
			{
				vsp=-6.5;
			}
			// Движение по горизонтали
			if(place_meeting(x+hsp,y,ObjWall))
			{
				while(!place_meeting(x+sign(hsp),y,ObjWall))
				{
					x+=sign(hsp);
				}
				hsp=0;
			}
			//Движение по вертикали
			if(place_meeting(x,y+vsp,ObjWall))
			{
				while(!place_meeting(x,y+sign(vsp),ObjWall))
				{
					y+=sign(vsp);
				}
				vsp=0;
			}
			y+=vsp;
			//Анимация
			if(attack = 1 && (place_meeting(x,y+1,ObjWall))) 
			{
				StatePlayer = ANIMATIONPLAYER.ATTACK;
			}
			else
			{
				if(!place_meeting(x,y+1,ObjWall))
				{
					sprite_index = SprPlayerJump;
				}
				else
				{
					if((hsp != 0))
					{
						sprite_index = SprPlayerRun;
					}
					else
					{
						sprite_index = SprPlayerIdle;
					}
				}
			if(hsp != 0) image_xscale = sign(hsp);
			}
			x += hsp;
		}
		break;
	}
	case ANIMATIONPLAYER.HIT:
	{
		if(place_meeting(x+hsp,y,ObjWall))
		{
			while(!place_meeting(x+sign(hsp),y,ObjWall))
			{
				x+=sign(hsp);
			}
			hsp=0;
		}
		if(!place_meeting(x,y+vsp,ObjWall))
		{
			y += vsp;
		}
		if(hp <= 0)
		{
			StatePlayer = ANIMATIONPLAYER.DEAD;
		}
		else
		{
			sprite_index = SprPlayerHit;
			StatePlayer = ANIMATIONPLAYER.FREE;
			x += hsp;
		}
		break;
	}
	case ANIMATIONPLAYER.DEAD:
	{
		if(!place_meeting(x,y+vsp,ObjWall))
		{
			y += vsp;
		}
		sprite_index = SprPlayerDead;
		if (image_speed > 0)
		{
			if(image_index >= image_number - 1)
			{
				image_speed = 0;
			}
		}
		break;
	}
	case ANIMATIONPLAYER.ATTACK:
	{
		if(hp <= 0)
		{
			StatePlayer = ANIMATIONPLAYER.DEAD;
		}
		sprite_index = SprPlayerAttack;
		hsp = 0;
		if(attack == 0) StatePlayer = ANIMATIONPLAYER.FREE;
		break;
	}
}