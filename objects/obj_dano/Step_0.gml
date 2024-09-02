/// @description Insert description here
// You can write your code in this editor

var outro = instance_place(x,y, obj_entidade);

//se estou tocando em alguuem
if (outro)
{
	//player não conta
	if (outro.id != pai)
	{
		
		//chacando quem é o pai do outrio
		var papi = object_get_parent(outro.object_index);
		if(papi != object_get_parent(pai.object_index))
		{
			if (outro.vida_atual > 0)
			{
				outro.estado = "hit";
				outro.image_index = 0;
				outro.vida_atual -= dano;
				instance_destroy()
			}
		}
	}
}
