//height is fixed while width changes dynamically
idealWidth = 0;
idealHeight = 1080;
zoom = 1;

//window_set_fullscreen(true);

aspectRatio = 16/9;

idealWidth = round(idealHeight*aspectRatio);
if(idealWidth&1){idealWidth++;}

maxZoom = floor(display_get_width()/idealWidth);
if(maxZoom>zoom){zoom=maxZoom;}
else if(zoom>maxZoom){zoom=maxZoom;}

for(var i=0;i<=room_last;i++)
{
	if(room_exists(i))
	{
		room_set_viewport(i,0,true,0,0,idealWidth,idealHeight);
		room_set_height(i,idealHeight);
		room_set_width(i,idealWidth);
		room_set_view_enabled(i,true);
	}
}

surface_resize(application_surface,idealWidth,idealHeight);
display_set_gui_size(idealWidth,idealHeight);
window_set_size(idealWidth*zoom,idealHeight*zoom);
alarm[0]=1;

/******************************************************************************
* NOTE: In order for this to work you need to set the height and width in the
room editor for both the room and camera/viewport 0. Without all three set, it
won't work right for some reason.
******************************************************************************/

//this line also sets us to a new random seed each game
randomize();