if(!global.moving && !instance_exists(oRKCTextBox))
{
	if(!right)
	{
		draw_sprite_ext(sprCardShopLeftArrow,
			(mouse_x>1460&&mouse_x<1540&&mouse_y>760&&mouse_y<840),
			1500,800,2,2,180,c_white,1);
	}
	else
	{
		draw_sprite_ext(sprCardShopLeftArrow,
			(mouse_x>60&&mouse_x<140&&mouse_y>760&&mouse_y<840),
			100,800,-2,2,180,c_white,1);
	}
}

if(mouse_check_button_released(mb_left))
{
	if(!instance_exists(oFadeTransition) && !instance_exists(oRKCTextBox)
		&& !instance_find(oShopGenerator,0).menusActive &&
		((!right&&mouse_x>1460&&mouse_x<1540&&mouse_y>760&&mouse_y<840)
		||(right&&mouse_x>60&&mouse_x<140&&mouse_y>760&&mouse_y<840)))
	{
		global.moving=true;
	}
}

if(global.moving)
{
	if(moveCounter==0)
	{
		for(var i=0;i<instance_number(all);i++)
		{
			instX[i] = instance_find(all,i).x;
		}
	}
	
	moveCounter++;
	
	if(moveCounter<totalMoveFrames)
	{
		if(right)
		{
			with(all)
			{
				x+=(instance_find(oChangeViewArrows,0).moveDist
					/instance_find(oChangeViewArrows,0).totalMoveFrames);
			}
		}
		else
		{
			with(all)
			{
				x-=(instance_find(oChangeViewArrows,0).moveDist
					/instance_find(oChangeViewArrows,0).totalMoveFrames);
			}
		}
	}
	else
	{
		for(var i=0;i<instance_number(all);i++)
		{
			instance_find(all,i).x = (right) ? instX[i]+1600 : instX[i]-1600;
		}
		global.moving=false;
		moveCounter=0;
		right = !right;
	}
}