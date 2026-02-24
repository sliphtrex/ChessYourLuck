if(editable)
{
	curX=camera_get_view_x(view_camera[0]);
	if(x>curX+room_width-400)
	{
		array_push(global.PlayerSpareCards,card);
		instance_find(oShopGenerator,0).RefreshSpareCards();
	
		for(var i=0;i<array_length(global.PlayerCards);i++)
		{
			if(global.PlayerCards[i]==card)
			{
				//remove from deck
				array_delete(global.PlayerCards,i,1);
				SortPlayerCards();
				break;
			}
		}
	}

	if(instance_find(oShopGenerator,0).heldCard!=undefined
		&&instance_find(oShopGenerator,0).heldCard==id)
	{instance_find(oShopGenerator,0).heldCard=undefined;}
}