if(editable && instance_find(oShopGenerator,0).heldSpAb!=undefined)
{
	var hSpAb = instance_find(oShopGenerator,0).heldSpAb.spAb;
	show_debug_message(instance_find(oShopGenerator,0).heldSpAb);
	
	if(instance_find(oShopGenerator,0).heldSpAb==id)
	{
		//if we drop it with the spare SpAbs
		//we need to clear it from the globals and clear the icon
		if(x>room_width-400)
		{
			if(slot==0){global.PlayerSpecialAbility1 = -1;}
			else if(slot==1){global.PlayerSpecialAbility2 = -1;}
			else if(slot==2){global.PlayerSpecialAbility3 = -1;}
			spAb = -1;
			instance_find(oSpAbScroller,0).SpecialProfs[hSpAb].inUse=false;
		}
		//in either event we need to reset position
		x = start_x; y=start_y;
	}
	
	else if(instance_find(oShopGenerator,0).heldSpAb.object_index==oSpareSpAb)
	{
		//update our global player SpAbs barring duplication
		if(instance_find(oShopGenerator,0).pSpAb1==id
			&& hSpAb != instance_find(oShopGenerator,0).pSpAb2.spAb
			&& hSpAb != instance_find(oShopGenerator,0).pSpAb3.spAb)
		{
			if(spAb != -1)
			{instance_find(oSpAbScroller,0).SpecialProfs[spAb].inUse=false;}
			spAb = hSpAb;
			global.PlayerSpecialAbility1 = spAb;
		}
		if(instance_find(oShopGenerator,0).pSpAb2==id
			&& hSpAb != instance_find(oShopGenerator,0).pSpAb1.spAb
			&& hSpAb != instance_find(oShopGenerator,0).pSpAb3.spAb)
		{
			if(spAb != -1)
			{instance_find(oSpAbScroller,0).SpecialProfs[spAb].inUse=false;}
			spAb = hSpAb;
			global.PlayerSpecialAbility2 = spAb;
		}
		if(instance_find(oShopGenerator,0).pSpAb3==id
			&& hSpAb != instance_find(oShopGenerator,0).pSpAb1.spAb
			&& hSpAb != instance_find(oShopGenerator,0).pSpAb2.spAb)
		{
			if(spAb != -1)
			{instance_find(oSpAbScroller,0).SpecialProfs[spAb].inUse=false;}
			spAb = hSpAb;
			global.PlayerSpecialAbility3 = spAb;
		}
		
		instance_find(oSpAbScroller,0).SpecialProfs[hSpAb].inUse=true;
	}
	else if(instance_find(oShopGenerator,0).heldSpAb.object_index==oPreviewSpAb)
	{instance_find(oShopGenerator,0).heldSpAb = undefined;}
	
	//reset our sprite
	Setup();
	
	instance_find(oShopGenerator,0).heldSpAb=undefined;
}