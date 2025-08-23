if(global.curTable!=undefined && !moving){camera_set_view_pos(view_camera[0],1920*global.curTable,0);}

curX = camera_get_view_x(view_camera[0]);
curY = camera_get_view_y(view_camera[0]);

if(!moving && !instance_exists(oRKCTextBox) && !instance_exists(oMatchPreviewer))
{
	draw_sprite_ext(sprCardShopLeftArrow,
		(mouse_x>curX+1760&&mouse_x<curX+1840&&mouse_y>curY+920&&mouse_y<curY+1000),
		curX+1800,curY+960,2,2,180,c_white,1);
	draw_sprite_ext(sprCardShopLeftArrow,
		(mouse_x>curX+80&&mouse_x<curX+160&&mouse_y>curY+920&&mouse_y<curY+1000),
		curX+120,curY+960,-2,2,180,c_white,1);
}


if(mouse_check_button_released(mb_left))
{
	if(!instance_exists(oFadeTransition) && !instance_exists(oRKCTextBox)
		&& !instance_exists(oMatchPreviewer)
		&& !instance_find(oShopGenerator,0).menusActive)
	{
		if(mouse_x>curX+1760&&mouse_x<curX+1840&&mouse_y>curY+920&&mouse_y<curY+1000)
		{moveRight=true; moving=true;}
		else if(mouse_x>curX+80&&mouse_x<curX+160&&mouse_y>curY+920&&mouse_y<curY+1000)
		{moveRight=false; moving=true;}
	}
}

if(moving)
{
	if(curFrame==0){startX=curX;}
	curFrame++;
	var newX = (moveRight) ? startX+((curFrame/totalFrames)*moveDist) : startX-((curFrame/totalFrames)*moveDist);
	camera_set_view_pos(view_camera[0],newX,0);
	if(curFrame==totalFrames)
	{
		if(global.curTable==undefined){global.curTable=0;}
		if(moveRight){global.curTable++;}
		else{global.curTable--;}
		
		if(global.curTable==-1)
		{
			global.curTable=3;
		}
		if(global.curTable==4)
		{
			global.curTable=0;
		}
		camera_set_view_pos(view_camera[0],1920*global.curTable,0);
		curFrame=0;
		moving=false;
	}
}