if(vsp < 5) vsp += grv;
switch(state)
{
	case ANIMATION.ATTACK:
	{
		if((place_meeting(x,y+vsp,ObjWall)) && (collision_rectangle(ObjPlayer.x-32, ObjPlayer.y-32, ObjPlayer.x+32, ObjPlayer.y+32, self, false, false)) && (maul == 1))
		{
			vsp = 0;
			image_speed = 0.6;
			with(ObjPlayer)
			{
				hp-=ObjSkeletWar.DamageSkeletWar;
				if(ObjPlayer.hp > 0) ObjPlayer.StatePlayer = ANIMATIONPLAYER.HIT;
				else ObjPlayer.StatePlayer = ANIMATIONPLAYER.DEAD;
			}
			sprite_index = SprSkeletWarAttack;
			hsp = sign(image_xscale);
			CooldownSkeletWar = 100;
			CooldownAttackWar = 500;
		}
		else if (CooldownSkeletWar < 0) 
		{hsp = sign(image_xscale); state = ANIMATION.WALK;}
		break;
	}
	case ANIMATION.HIT:
	{
		if((ObjPlayer.attack == 1) && (collision_rectangle(ObjPlayer.x-32, ObjPlayer.y-32, ObjPlayer.x+32, ObjPlayer.y+32, self, false, false))) 
		{
			if(hp <= 0) state = ANIMATION.DEAD;
			else sprite_index = SprSkeletWarHit;
		}
		else state = ANIMATION.WALK;
		break;
	}
	case ANIMATION.DEAD:
	{
		if(StopAnimationDead)
		{
			sprite_index = SprSkeletWarDead;
			if (image_speed > 0)
			{
				if(image_index >= image_number - 1)
				{
					image_speed = 0;
					StopAnimationDead = 0;
				}
			}
		}
		break;
	}
	case ANIMATION.WALK:
	{
		if((CooldownAttackWar <= 0)) 
		{
			maul = 1;
		}
		else maul = 0;
		if(collision_rectangle(ObjPlayer.x-32, ObjPlayer.y-32, ObjPlayer.x+32, ObjPlayer.y+32, self, false, false))
		{
			if((maul==1) && (CooldownAttackWar <= 0) )	state = ANIMATION.ATTACK;
			else 
			{
				if((ObjPlayer.attack == 1) && (ObjPlayer.cooldown < 0))
				{
						hp-=ObjPlayer.damage;
						hsp = 0;
						ObjPlayer.cooldown = 50;
						state = ANIMATION.HIT;
				}
				else 
				{
					if(hsp == 0) hsp = sign(image_xscale);
					hsp = sign(hsp);
				}
			}
		}
		if(place_meeting(x+hsp,y,ObjWall) && (!collision_rectangle(ObjPlayer.x-32, ObjPlayer.y-32, ObjPlayer.x+32, ObjPlayer.y+32, self, false, false)))
		{
			while(!place_meeting(x+sign(hsp),y,ObjWall))
			{
				x+=sign(hsp);
			}
			hsp = -hsp;
		}
		if(place_meeting(x+hsp,y,ObjWallEnemy)  && (!collision_rectangle(ObjPlayer.x-32, ObjPlayer.y-32, ObjPlayer.x+32, ObjPlayer.y+32, self, false, false)))
		{
			while(!place_meeting(x+sign(hsp),y,ObjWallEnemy))
			{
				x+=sign(hsp);
			}
			hsp = -hsp;
		}
		if(place_meeting(x,y+vsp,ObjWall))
		{
			while(!place_meeting(x,y+sign(vsp),ObjWall))
			{
				y+=sign(vsp);
			}
			vsp=0;
		}
		if(place_meeting(x,y+vsp,ObjWallEnemy))
		{
			while(!place_meeting(x,y+sign(vsp),ObjWallEnemy))
			{
				y+=sign(vsp);
			}
			vsp=0;
		}
		if(!place_meeting(x,y+1,ObjWall))	
		{
			sprite_index = SprSkeletWarJump;
			image_speed = 0;
			if(sign(vsp) > 0) image_index = 0; else image_index = 1;
		}
		else
		{
			image_speed = 1;
			if(hsp != 0)
			{
				sprite_index = SprSkeletWarWalk;
			}
		}
		x+=hsp;
		y+=vsp;
		if(hsp != 0) image_xscale = sign(hsp);
		break;
	}
}