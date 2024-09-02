/// @description Insert description here
// You can write your code in this editor

var chao = place_meeting(x, y + 1, obj_block);
var player = collision_line(x, y - sprite_height/2, x + (dist * xscale),y - sprite_height/2, obj_player, 0, 1)
if(!chao)
{
	vspd += GRAVIDADE * massa;
}
//if (mouse_check_button_pressed(mb_right))
//{
//	estado = "atack"
//}



switch(estado)
{

	case "parado":
	{
		hspd = 0;
		timer_estado++;
		if (sprite_index != spr_inimigo_esqueleto_idle)
		{
			image_index = 0;
		}
		sprite_index = spr_inimigo_esqueleto_idle;
		
		//condição de troca de estado
		if (position_meeting(mouse_x, mouse_y, self))
		{
				if (mouse_check_button_pressed(mb_right))
				{
					estado = "hit";
				}
			
		}
		//indo para o estado de patrulha
		if (irandom(timer_estado) > 300)
		{
			estado = choose("walk","parado","walk");
			timer_estado = 0;
		}
		//se o player ta na visao
		else if (player)
		{
			estado = "atack";
		}	

		break;
	}
	case "atack":
	{
		hspd =0;
		if (sprite_index != spr_inimigo_esqueleto_atack)
		{
			sprite_index = 0;
			posso = true;
		}
		sprite_index = spr_inimigo_esqueleto_atack;
		
		//saindo do estado
		if (image_index > image_number -1)
		{
			estado = "parado";
		}
		//criando o dano
		if (image_index >= 8 && dano == noone && image_index < 15 && posso)
		{
			dano = instance_create_layer(x + sprite_width/2, y - sprite_height/3, layer,obj_dano);
			dano.dano = ataque;
			dano.pai = id;
			posso = false;
		}
		
		//destroindo dano
		if (dano != noone && image_index >= 15)
		{
			instance_destroy(dano)
			dano = noone;
		}
		break;
	}
	case "hit":
	{
		if (sprite_index != spr_inimigo_esqueleto_hit)
		{
			//iniciando o que for rreciso para este estado
			image_index = 0;
			//vida_atual--;
		}
		sprite_index = spr_inimigo_esqueleto_hit;
		
		//condição para sair do estado
		if (image_index > image_number-1)
		{
			if (vida_atual > 0)
			{
				if (image_index > image_number-1)
				{
				estado = "parado";
				}
			}
			else 
			{
				if (image_index >= 3)
				{
					
					estado = "dead";
				}
			}
			
		}
		break;
	}
	case "walk":
	{
		timer_estado++;
		if (sprite_index != spr_inimigo_esqueleto_walk)
		{
			image_index = 0;
			hspd = choose(1,-1);
		}
		sprite_index = spr_inimigo_esqueleto_walk;
		
		//condição de saida do estado
		if (irandom(timer_estado) > 300)
		{
			estado = choose("parado","walk","parado");
			timer_estado = 0;
		}
		else if (player)
		{
			estado = "atack";
		}	
	break;
	}
	
	case "dead":
	{
		sprite_index = spr_inimigo_esqueleto_morte;
		
		if (sprite_index != spr_inimigo_esqueleto_morte)
		{
			//iniciando o que for reciso para este estado
			image_index = 0;
		}
		
		//morrendo
		if (image_index > image_number-1)
		{
			image_speed = 0;
			image_alpha -= .01;
			
			if (image_alpha <= 0)
			{
				instance_destroy()
			}
		}
	break;
	}
	
}