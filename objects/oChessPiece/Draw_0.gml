Health = clamp(Health,0,10);
Attack = clamp(Attack,1,10);

if(Health<=0)
{
	if(pragma)
	{
		Health=1;
		pragma=false;
		show_debug_message("pragma used");
	}
	else
	{
		show_debug_message("We're destroying the piece");
		instance_find(oField,0).RemovePiece(id);
		if(myTile.myPiece==id){myTile.myPiece = undefined;}
		instance_destroy();
		instance_find(oField,0).CheckForKings();
	}
}

draw_self();
