if(!instance_exists(oRKCTextBox)
	&& instance_find(oShopGenerator,0).heldCard==undefined
	&& instance_find(oShopGenerator,0).heldSpAb==undefined)
{instance_find(oShopGenerator,0).SetupMenus(itemType,item);}