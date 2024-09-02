//sintema colisão
var _hspd = sign(hspd);
var _vspd = sign(vspd);

//colisão horizontal
repeat(abs(hspd))
{
	if (place_meeting(x + _hspd, y, obj_block))
	{
		hspd = 0;
		break;
	}
	x += _hspd;
}

//clolisão vertical
repeat(abs(vspd))
{
	if (place_meeting(x, y + _vspd, obj_block))
	{
		vspd = 0;
		break;
	}
	y += _vspd;
}
