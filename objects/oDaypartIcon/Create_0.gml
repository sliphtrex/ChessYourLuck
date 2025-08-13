image_speed=0;
image_index=global.DayPart;

function ResetRoom()
{
	global.postMatch=false;
	curX = camera_get_view_x(view_camera[0]);
	instance_create_layer(curX,0,"Text",oFadeTransition);
}