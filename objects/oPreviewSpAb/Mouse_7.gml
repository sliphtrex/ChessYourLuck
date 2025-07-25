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
		show_debug_message(instance_find(oShopGenerator,0).heldSpAb.spAb);
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