curX=camera_get_view_x(view_camera[0]);
x=start_x-(((instance_number(oCSPreviewCard)-12.5)*106)*instance_find(oCardScroller,0).scrollPercent);
if(x<curX+100||x>curX+room_width-500+(sprite_width/2)){hidden=true;}else{hidden=false;}

if(instance_find(oShopGenerator,0).heldCard!=undefined
	&& instance_find(oShopGenerator,0).heldCard==id)
{x=mouse_x; y=mouse_y;}