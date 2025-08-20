/***********************************************************************************
* We need to set 4 items based on our available pool of items. Our available items
* should come from our special cards and special abilities. We should only collect
* from what's programmed into the game already, so we can't go through
* global.SpecialsUnlocked right now, but ideally we would be able to just take the
* specials that are still locked, add them to a list, and then pick from those.
***********************************************************************************/
item1=undefined;
item2=undefined;
item3=undefined;
item4=undefined;

//these variables are for the menu
menusActive=false;
//are we editing our deck or SpAbs
editor = false;
//true means the player's buying special abilities, false means cards
SpAbShop=false;
//our shop items item number
itemNumber=undefined;
previewSpAb=undefined;

//are we currently dragging a card or Spab to edit our deck
heldCard=undefined;
heldSpAb=undefined;

//the player's preview spabs
pSpAb1 = undefined;
pSpAb2 = undefined;
pSpAb3 = undefined;

#region initial setup
// # of items to choose from
totalItems=array_length(global.UnlockableCards)+array_length(global.UnlockableSpAbs);

if(totalItems>0)
{
	//assign temp ints for our items such that each one is the same as the first
	var i1=irandom_range(0,totalItems-1);
	var i2=i1;
	var i3=i1;
	var i4=i1;

	//if we have multiple items to choose from we should set them so they're unique
	if(totalItems>1){while(i2==i1){i2 = irandom_range(0,totalItems-1);}}
	if(totalItems>2){while(i3==i1 || i3==i2){i3 = irandom_range(0,totalItems-1);}}
	if(totalItems>3){while(i4==i1 || i4==i2 || i4==i3){i4 = irandom_range(0,totalItems-1);}}

	//now we set the items assuming they're not the same
	
	var cardLength = array_length(global.UnlockableCards);
	
	item1 = instance_create_layer(825,210,"CardShop",oCardShopItem);
	//if our chosen int is outside the bounds of our unlockable cards
	//it's a special ability
	if(i1>=cardLength)
	{
		item1.itemType = 1;
		item1.item = global.UnlockableSpAbs[i1-cardLength];
	}
	else
	{
		item1.itemType = 0;
		item1.item = global.UnlockableCards[i1];
	}
	item1.Setup();
	
	//from here we need to check that our other items actually exist
	if(i2!=i1)
	{
		item2 = instance_create_layer(1050,210,"CardShop",oCardShopItem);
		if(i2>=cardLength)
		{
			item2.itemType = 1;
			item2.item = global.UnlockableSpAbs[i2-cardLength];
		}
		else
		{
			item2.itemType = 0;
			item2.item = global.UnlockableCards[i2];
		}
		item2.Setup();
	}
	
	if(i3!=i1)
	{
		item3 = instance_create_layer(825,350,"CardShop",oCardShopItem);
		if(i3>=cardLength)
		{
			item3.itemType = 1;
			item3.item = global.UnlockableSpAbs[i3-cardLength];
		}
		else
		{
			item3.itemType = 0;
			item3.item = global.UnlockableCards[i3];
		}
		item3.Setup();
	}
	
	if(i4!=i1)
	{
		item4 = instance_create_layer(1050,350,"CardShop",oCardShopItem);
		if(i4>=cardLength)
		{
			item4.itemType = 1;
			item4.item = global.UnlockableSpAbs[i4-cardLength];
		}
		else
		{
			item4.itemType = 0;
			item4.item = global.UnlockableCards[i4];
		}
		item4.Setup();
	}
}
#endregion

#region shop setup and teardown
//_SpAb = 0 if we need a card shop and 1 if we need a SpAb shop
function SetupMenus(_SpAb,_itemNum)
{
	if(!menusActive){menusActive=true;}
	editor=false;
	SpAbShop = _SpAb;
	itemNumber = _itemNum;
	
	if(!instance_exists(oBackButton))
	{instance_create_layer(0,520,"UILayer",oBackButton);}
	
	if(!_SpAb)
	{
		//delete our special ability if there's one on screen
		if(previewSpAb!=undefined)
		{
			instance_destroy(previewSpAb);
			previewSpAb=undefined;
		}
		
		//get rid of any SpAb scrollers that may exist 
		if(instance_exists(oSpAbScroller))
		{
			for(var i=0; i<instance_number(oSpAbScroller); i++)
			{instance_find(oSpAbScroller,i).Close();}
		}
		//setup a card scroller if we don't have one
		if(!instance_exists(oCardScroller))
		{instance_create_layer(0,0,"CardShop",oCardScroller);}
	}
	else if(_SpAb)
	{
		//get rid of any card scrollers that may exist
		if(instance_exists(oCardScroller))
		{
			for(var i=0; i<instance_number(oCardScroller); i++)
			{instance_find(oCardScroller,i).Close();}
		}
		//setup a SpAb scroller if we don't have one 
		if(!instance_exists(oSpAbScroller))
		{instance_create_layer(0,0,"CardShop",oSpAbScroller);}
		
		if(previewSpAb==undefined)
		{
			previewSpAb=instance_create_layer(1050,750,"CardShop",oPreviewSpAb);
		}
		previewSpAb.specialAbility = _itemNum;
		previewSpAb.playerAb = true;
		previewSpAb.shop = true;
		previewSpAb.Setup();
	}
}

function CloseShop()
{
	menusActive=false;
	if(editor){editor=false;}
	
	//delete our special ability if there's one on screen
	if(previewSpAb!=undefined)
	{
		instance_destroy(previewSpAb);
		previewSpAb=undefined;
	}
	
	if(pSpAb1!=undefined)
	{instance_destroy(pSpAb1); pSpAb1=undefined;}
	if(pSpAb2!=undefined)
	{instance_destroy(pSpAb2); pSpAb2=undefined;}
	if(pSpAb3!=undefined)
	{instance_destroy(pSpAb3); pSpAb3=undefined;}
		
	//get rid of any card scrollers that may exist
	if(instance_exists(oCardScroller))
	{
		for(var i=0; i<instance_number(oCardScroller); i++)
		{instance_find(oCardScroller,i).Close();}
	}
	//get rid of any spare card scrollers that may exist
	if(instance_exists(oSpareCardScroller))
	{
		for(var i=0; i<instance_number(oSpareCardScroller); i++)
		{instance_find(oSpareCardScroller,i).Close();}
	}
	//get rid of any SpAb scrollers that may exist 
	if(instance_exists(oSpAbScroller))
	{
		for(var i=0; i<instance_number(oSpAbScroller); i++)
		{instance_find(oSpAbScroller,i).Close();}
	}
	//get rid of the back button(s)
	if(instance_exists(oBackButton))
	{
		for(var i=0; i<instance_number(oBackButton); i++)
		{instance_destroy(instance_find(oBackButton,i));}
	}
	
	if(instance_exists(oSpareCard))
	{
		for(var i=0; i<instance_number(oSpareCard);i++)
		{instance_destroy(instance_find(oSpareCard,i));}
	}
}
#endregion

#region buy cards or SpAbs
function BuySpAb()
{
	global.pDiamonds-=previewSpAb.cost;
	global.SpecialsUnlocked[previewSpAb.specialAbility]=true;
	
	//once we buy a special ability we own it for the game
	for(var i=0; i<array_length(global.UnlockableSpAbs);i++)
	{
		if(previewSpAb.specialAbility==global.UnlockableSpAbs[i])
		{array_delete(global.UnlockableSpAbs,i,1); break;}
	}
	
	if(instance_exists(item1) && item1.itemType==1
		&&item1.item==previewSpAb.specialAbility)
	{instance_destroy(item1);item1=undefined;}
	else if(instance_exists(item2) && item2.itemType==1
		&&item2.item==previewSpAb.specialAbility)
	{instance_destroy(item2);item2=undefined;}
	else if(instance_exists(item3) && item3.itemType==1
		&&item3.item==previewSpAb.specialAbility)
	{instance_destroy(item3);item3=undefined;}
	else if(instance_exists(item4) && item4.itemType==1
		&&item4.item==previewSpAb.specialAbility)
	{instance_destroy(item4);item4=undefined;}
	
	instance_destroy(previewSpAb);
	previewSpAb=undefined;
	
	CloseShop();
}

function BuyCard(_cost)
{
	global.pDiamonds -= _cost;
	
	//add our card to our extras so we can add it to our deck later
	if(global.PlayerSpareCards==undefined){global.PlayerSpareCards=[itemNumber];}
	else{array_push(global.PlayerSpareCards,itemNumber);}
	//NOTE: We're not removing the card from our list because the player
	//is allowed to have duplicates in their deck.
	
	if(instance_exists(item1) && item1.itemType==0
		&&item1.item==itemNumber)
	{instance_destroy(item1);item1=undefined;}
	else if(instance_exists(item2) && item2.itemType==0
		&&item2.item==itemNumber)
	{instance_destroy(item2);item2=undefined;}
	else if(instance_exists(item3) && item3.itemType==0
		&&item3.item==itemNumber)
	{instance_destroy(item3);item3=undefined;}
	else if(instance_exists(item4) && item4.itemType==0
		&&item4.item==itemNumber)
	{instance_destroy(item4);item4=undefined;}
	
	itemNumber=undefined;
	
	CloseShop();
}
#endregion

#region Edit Cards os SpAbs
function SetupDeckEditor()
{
	menusActive=true;
	editor=true;
	
	if(!instance_exists(oBackButton))
	{instance_create_layer(0,520,"UILayer",oBackButton);}
	
	//setup a spare card scroller if we don't have one
	if(!instance_exists(oSpareCardScroller))
	{instance_create_layer(0,0,"CardShop",oSpareCardScroller);}
	
	//setup a card scroller if we don't have one
	if(!instance_exists(oCardScroller))
	{cards = instance_create_layer(0,0,"CardShop",oCardScroller); cards.Setup();}
}

function SetupSpAbEditor()
{
	menusActive=true;
	editor=true;
	
	if(!instance_exists(oBackButton))
	{instance_create_layer(0,520,"UILayer",oBackButton);}
	
	//setup a SpAb scroller if we don't have one 
	if(!instance_exists(oSpAbScroller))
	{instance_create_layer(0,0,"CardShop",oSpAbScroller);}
	
	pSpAb1 = instance_create_layer(200,750,"CardShop",oPreviewSpAb);
	pSpAb1.specialAbility = global.PlayerSpecialAbility1;
	pSpAb1.playerAb=true;
	pSpAb1.shop=true;
	pSpAb1.descSide = false;
	pSpAb1.Setup();
		
	pSpAb2 = instance_create_layer(500,750,"CardShop",oPreviewSpAb);
	pSpAb2.specialAbility = global.PlayerSpecialAbility2;
	pSpAb2.playerAb=true;
	pSpAb2.shop=true;
	pSpAb2.descSide = false;
	pSpAb2.Setup();
		
	pSpAb3 = instance_create_layer(800,750,"CardShop",oPreviewSpAb);
	pSpAb3.specialAbility = global.PlayerSpecialAbility3;
	pSpAb3.playerAb=true;
	pSpAb3.shop=true;
	pSpAb3.Setup();
}
#endregion