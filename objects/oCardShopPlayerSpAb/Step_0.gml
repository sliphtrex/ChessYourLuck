if(instance_exists(oSpAbScroller))
{y=start_y-(((array_length(instance_find(oSpAbScroller,0).SpecialProfs)-5)*150)
	*instance_find(oSpAbScroller,0).scrollPercent);}

x=start_x;	

if(y<0||y>800){hidden=true;}else{hidden=false;}
image_index = (global.SpecialsUnlocked[spAb]) ? 0 : 1;

if(instance_find(oShopGenerator,0).heldSpAb!=undefined
	&& instance_find(oShopGenerator,0).heldSpAb==id)
{
	x=mouse_x; y=mouse_y;
}