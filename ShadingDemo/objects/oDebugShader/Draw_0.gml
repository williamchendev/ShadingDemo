/// @description Insert description here
// You can write your code in this editor

shader_set(shd_pointlightfade);

/*
draw_set_color(c_white);
draw_rectangle(x - 5, y - 5, x + 5, y + 5, false);
*/


draw_sprite_ext(sLights, 0, mouse_x, mouse_y, 9, 9, 0, c_white, 1);

shader_reset();