/// @description Insert description here
// You can write your code in this editor

//Olhando+ para o lado certo
if (hspd !=0) xscale = sign(hspd);

image_xscale = xscale;

//exibindo meu estado quando o usiario mandar
if (position_meeting(mouse_x, mouse_y, id)) 
{
	if (mouse_check_button_released(mb_left))
		mostra_estado = !mostra_estado;
}

image_speed = (img_spd / room_speed);
