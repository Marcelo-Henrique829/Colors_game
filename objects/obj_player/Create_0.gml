/// @description Insert description here
// You can write your code in this editor

randomize();

//cirando camera
var cam =instance_create_layer(x, y, layer, obj_camera);
cam.alvo = id;



// Inherit the parent event
event_inherited();

vida_max = 10;
vida_atual = vida_max;

max_hspd = 4;
max_vspd = 6;
dash_spd = 6;
mostra_estado = true;

combo = 0;

img_spd = 38;

dano = noone
posso =true;
ataque_mult = 1; 
ataque_buff = room_speed;
