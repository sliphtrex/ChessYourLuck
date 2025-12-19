if(filesLoaded)
{
	#region Shader Stuff
	if(shaders_are_supported())
	{
		surfx=0;
		surfy=0;
		surfw=room_width;
		surfh=room_height;
		blurSurf=surface_create(surfw,surfh);
		blurSizeH=2;
		blurSizeV=2;

		//draw the application surface with horizontal blur to the blurSurf 
		surface_set_target(blurSurf);
		shader_set(shdBlurH);

		var texSize = shader_get_uniform(shdBlurH,"texturSize");
		shader_set_uniform_f(texSize,surfw,surfh);
		var blurRad = shader_get_uniform(shdBlurH,"blurRadius");
		shader_set_uniform_f(blurRad,blurSizeH);
		draw_surface(application_surface,0-surfx,0-surfy);

		shader_reset();
		surface_reset_target();

		//now draw blurSurf to the screen with the vertical blur
		shader_set(shdBlurV);
		var texSize = shader_get_uniform(shdBlurV,"texturSize");
		shader_set_uniform_f(texSize,surfw,surfh);
		var blurRad = shader_get_uniform(shdBlurV,"blurRadius");
		shader_set_uniform_f(blurRad,blurSizeV);
		draw_surface(blurSurf,surfx,surfy);
		shader_reset();

		//don't forget to free the surface from memory
		surface_free(blurSurf);
	}
	#endregion

	if(menuButton==undefined)
	{menuButton = instance_create_layer(room_width-300,100,"UILayer",oMainMenuButton);}
	//this line makes sure our shader doesn't effect the menu button.
	else{with(menuButton){event_perform(ev_draw,0);}}
}
else
{
	if(menuButton!=undefined)
	{
		instance_destroy(menuButton);
		menuButton = undefined;
	}
}

draw_self();