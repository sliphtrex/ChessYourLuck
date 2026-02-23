/*if(instance_find(oShopGenerator,0).heldSpAb==id && x>=room_width)
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
}*/

if(shop && instance_find(oShopGenerator,0).heldSpAb!=undefined)
{
	var hSpAb = instance_find(oShopGenerator,0).heldSpAb.spAb;
	
	//update our global player SpAbs barring duplication
	if(instance_find(oShopGenerator,0).pSpAb1==id
		&& hSpAb != instance_find(oShopGenerator,0).pSpAb2.specialAbility
		&& hSpAb != instance_find(oShopGenerator,0).pSpAb3.specialAbility)
	{
		specialAbility = hSpAb;
		global.PlayerSpecialAbility1 = specialAbility;
	}
	if(instance_find(oShopGenerator,0).pSpAb2==id
		&& hSpAb != instance_find(oShopGenerator,0).pSpAb1.specialAbility
		&& hSpAb != instance_find(oShopGenerator,0).pSpAb3.specialAbility)
	{
		specialAbility = hSpAb;
		global.PlayerSpecialAbility2 = specialAbility;
	}
	if(instance_find(oShopGenerator,0).pSpAb3==id
		&& hSpAb != instance_find(oShopGenerator,0).pSpAb1.specialAbility
		&& hSpAb != instance_find(oShopGenerator,0).pSpAb2.specialAbility)
	{
		specialAbility = hSpAb;
		global.PlayerSpecialAbility3 = specialAbility;
	}
	
	//reset our sprite
	Setup();
	
	instance_find(oShopGenerator,0).heldSpAb=undefined;
}