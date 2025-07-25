if(instance_exists(oSpareCardScroller))
{y=start_y+(((array_length(instance_find(oSpareCardScroller,0).spareCards)-5)*150)
	*instance_find(oSpareCardScroller,0).scrollPercent);}

x=start_x;

if(y<0||y>800){hidden=true;}else{hidden=false;}

if(instance_find(oShopGenerator,0).heldCard!=undefined
	&& instance_find(oShopGenerator,0).heldCard==id)
{
	x=mouse_x; y=mouse_y;
}