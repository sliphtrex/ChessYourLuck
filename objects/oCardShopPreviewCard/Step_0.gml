curX=camera_get_view_x(view_camera[0]);
x=start_x-(((instance_number(oCardShopPreviewCard)-10)*106)*instance_find(oCardScroller,0).scrollPercent);
if(x<curX+50||x>curX+1150){hidden=true;}else{hidden=false;}