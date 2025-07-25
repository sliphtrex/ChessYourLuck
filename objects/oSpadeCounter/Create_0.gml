pSpades=false;
spadePips=000;
image_index = (pSpades)? 0:1;
image_speed=0;

function AddSpades(num)
{
	spadePips += num;
	spadePips = clamp(spadePips,0,999);
}