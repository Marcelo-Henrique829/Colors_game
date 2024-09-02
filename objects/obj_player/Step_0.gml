/// @description Insert description here
// You can write your code in this editor

//var osa maicon
#region //inputs ou controles para os mais aviadados

	var right, left, jump, atack, dash;
	var chao = place_meeting(x, y + 1, obj_block);

	right	= keyboard_check(ord("D"));
	left	= keyboard_check(ord("A"));
	jump	= keyboard_check_pressed(ord("K"));
	atack	= keyboard_check_pressed(ord("J"));
	dash	=keyboard_check_pressed(vk_shift)

#endregion

//Movimentação
hspd = (right - left) * max_hspd


if (ataque_buff > 0) ataque_buff -= 5;
//Aplicando Gravidade
if (!chao)
{
	if (vspd < max_vspd * 2)
	{
		vspd += GRAVIDADE * massa
	}
}

#region maquina de estado
//iniciando a maquina de estados
switch (estado)
{
	
	
#region parado
	case "parado":
	{
		//comportamento do estado
		sprite_index = spr_player_parado1;
		
		//condição de troca de estado
		//movendo
		if (right || left)
		{
			estado = "movendo";
		}
		else if (jump)
		{
			estado = "pulando";
			vspd  = -max_vspd;
			image_index = 0;
		}
		else if (atack)
		{
			estado = "atack";
			hspd = 0;
		}
		else if (dash)
		{
			estado = "dash";
			image_index = 0;
		}
		
		break; 
	}
	#endregion


#region movendo
	case "movendo":
	{
		//comportamento do estado de movimento
		sprite_index = spr_player_run;
		
		//condição de troca de estado
		//parado
		if (abs(hspd) < .1)
		{
			estado = "parado";
			hspd = 0;
		}
		else if (jump || vspd != 0)
		{
			estado = "pulando";
			vspd  = (-max_vspd * jump);
			image_index = 0;
		}
		else if (atack)
		{
			estado = "atack";
			hspd = 0;
			image_index = 0;
		}
		else if (dash)
		{
			estado = "dash";
			image_index = 0;
		}
		break;
	}
#endregion


#region pulando
	case "pulando": 
	{
		
		//estou caindo
		if (vspd > 0)
		{
			sprite_index = spr_player_fall;
		}
		else
		{
			sprite_index = spr_player_jump;
			//garantindo que a animação nao se repita
			if (image_index >= image_number-1)
			{
				image_index = image_number-1;
			}
		}
		
		//condição de troca de estado
		if (chao)
		{
			estado = "parado";
		}
		else if (jump && chao)
		{
			estado = "pulando";
			vspd  = -max_vspd;
		}
		
		break;
	}
#endregion	


#region ataque
	case "atack":
	{
		hspd = 0;
		if (combo == 0)
		{
		sprite_index = spr_player_atack1;
		}
		else if (combo == 1)
		{
			sprite_index = spr_player_atack2;
		}
		else if (combo == 2)
		{
			sprite_index = spr_player_atack3;
		}
		
		//criando objeto de dano
		if (image_index >= 2 && dano == noone && posso)
		{
			dano		 = instance_create_layer(x+sprite_width/2, y-sprite_height/2, layer, obj_dano);
			dano.dano	 = ataque*ataque_mult;
			dano.pai	 = id;
			posso		 = false;
		}
		
		if (atack && combo < 2)
		{
			ataque_buff =room_speed;
		}
		
		if (ataque_buff && combo < 2 && image_index >= image_number-1)
		{
			combo++;
			image_index = 0;
			posso = true;
			ataque_mult += 0.7;
			if (dano)
			{
				instance_destroy(dano, false);
				dano = noone;
			}			
			
			//zerar o buff
			ataque_buff = 0;
		
		}
		
		if (image_index > image_number-1)
		{
			estado = "parado";
			hspd = 0;
			combo = 0;
			posso = true;
			ataque_mult = 1;
			if (dano)
			{
				instance_destroy(dano, false);
				dano = noone;
			}
		}
		break;	
 }
 #endregion

#region dash
	case "dash":
	{
			sprite_index = spr_player_dash;

		//velocidade
		hspd = image_xscale * dash_spd;
		
		//saindo do estado
		if (image_index >= image_number-1)
		{
			estado = "parado";
		}
		
		
		break;
	}
#endregion
	case "hit":
	{
			sprite_index = spr_player_hit;

		
		//saindo do estado
		if(image_index >= image_number-1)
		{
			estado = "parado";
		}
	}
		default:
		{
			estado = "parado";
		}
	}

#endregion

//resetando o game se aperta o R
if (keyboard_check(ord("R")))
{
	game_restart()
}


