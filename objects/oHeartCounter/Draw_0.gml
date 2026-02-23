draw_sprite_ext(sprHeartPip,0,x,y,4,4,0,c_white,1);
draw_sprite_ext(sprYellowNumbers, (hearts<0) ? 10 : 11, x-20, y,2,2,0,c_white,1);

if(hearts>=10||hearts<=-10)
{
	draw_sprite_ext(sprYellowNumbers, 1, x, y,2,2,0,c_white,1);
	draw_sprite_ext(sprYellowNumbers, (hearts>=10) ? (hearts-10) : (hearts+10), x+20, y,2,2,0,c_white,1);
}
else {draw_sprite_ext(sprYellowNumbers,hearts,x,y,2,2,0,c_white,1);}

curTime++;
if(curTime==timer){instance_destroy();}