curX=camera_get_view_x(view_camera[0]);
if(x<curX+room_width-500+(sprite_width/2) && y>room_height-300
	&& array_length(global.PlayerCards)<99)
{
	//add to the player's deck
	array_insert(global.PlayerCards,0,card);
	SortPlayerCards();
	
	//delete from the spare card list
	for(var i=0; i<array_length(global.PlayerSpareCards);i++)
	{
		if(global.PlayerSpareCards[i]=card)
		{
			array_delete(global.PlayerSpareCards,i,1);
			instance_find(oShopGenerator,0).RefreshSpareCards();
			if(array_length(global.PlayerSpareCards)==0){instance_destroy();}
			break;
		}
	}
}

if(instance_find(oShopGenerator,0).heldCard!=undefined
	&&instance_find(oShopGenerator,0).heldCard==id)
{instance_find(oShopGenerator,0).heldCard=undefined;}