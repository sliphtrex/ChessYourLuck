moving=false;

curFrame=0;
totalFrames=room_speed;
startX=0;
moveDist=1920;
moveRight=true;
if(global.curTable!=undefined){camera_set_view_pos(view_camera[0],1920*global.curTable,0);}
show_debug_message("our current table is: "+string(global.curTable)
	+"\nand the camera is positioned at "+string(camera_get_view_x(view_camera[0])));