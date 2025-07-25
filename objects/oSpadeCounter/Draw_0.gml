image_index = (pSpades) ? 0 : 1;
draw_self();
draw_sprite(sprYellowNumbers,(spadePips%10),x+15,y);
draw_sprite(sprYellowNumbers,(floor((spadePips%100)/10)),x,y);
draw_sprite(sprYellowNumbers,(floor((spadePips%1000)/100)),x-15,y);