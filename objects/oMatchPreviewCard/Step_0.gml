curX=camera_get_view_x(view_camera[0]);
x=start_x-(((instance_number(oMatchPreviewCard)-12.5)*106)*instance_find(oCardScroller,0).scrollPercent);
if(x<curX+100-(sprite_width/2)||x>curX+room_width-500+(sprite_width/2)){hidden=true;}else{hidden=false;}

if(hidden!=switchedState)
{
	show_debug_message((hidden) ? "hidden":"visible");
	switchedState=hidden;
}