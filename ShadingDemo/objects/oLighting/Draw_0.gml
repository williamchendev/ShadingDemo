/// @description Insert description here
// You can write your code in this editor

// Surface Exists
if (!surface_exists(surface_color)) {
	surface_color = surface_create(screen_width, screen_height);
}
if (!surface_exists(surface_normals)) {
	surface_normals = surface_create(screen_width, screen_height);
}
if (!surface_exists(surface_temp)) {
	surface_temp = surface_create(screen_width, screen_height);
}
if (!surface_exists(surface_vectors)) {
	surface_vectors = surface_create(screen_width, screen_height);
}
if (!surface_exists(surface_blend)) {
	surface_blend = surface_create(screen_width, screen_height);
}
if (!surface_exists(surface_light)) {
	surface_light = surface_create(screen_width, screen_height);
}

// Establish Surface Colors
surface_set_target(surface_color);
draw_clear_alpha(c_black, 0);

for (var i = 0; i < instance_number(oSprite); i++) {
	var temp_sprite = instance_find(oSprite, i);
	draw_sprite(temp_sprite.lit_sprite, temp_sprite.image_index, temp_sprite.x - x, temp_sprite.y - y);
}

surface_reset_target();

// Establish Surface Normals
surface_set_target(surface_normals);
draw_clear_alpha(c_black, 0);

for (var i = 0; i < instance_number(oSprite); i++) {
	var temp_sprite = instance_find(oSprite, i);
	draw_sprite(temp_sprite.normal_sprite, temp_sprite.image_index, temp_sprite.x - x, temp_sprite.y - y);
}

surface_reset_target();

// Establish Surface Lighting
surface_set_target(surface_light);
draw_clear_alpha(c_black, 0);
surface_reset_target();

// Render PointLights
for (var i = 0; i < instance_number(oPointLight); i++) {
	// Find PointLight
	var temp_plight = instance_find(oPointLight, i);
	
	// PointLight Variables
	var temp_lightrange = (temp_plight.range / 32) * 2;
	var temp_lightintensity = temp_plight.intensity;
	var temp_lightcolor = temp_plight.color;
	
	// PointLight Vectors Surface
	surface_set_target(surface_vectors);
	draw_clear_alpha(make_color_rgb(255 / 2.0, 255 / 2.0, 255), 1);
	
	shader_set(shd_pointlightvector);
	draw_sprite_ext(sLights, 0, temp_plight.x - x, temp_plight.y - y, temp_lightrange, temp_lightrange, 0, c_white, 1);
	shader_reset();
	
	surface_reset_target();
	
	// PointLight Blend Surface
	surface_set_target(surface_blend);
	draw_clear_alpha(c_black, 0);
	
	shader_set(shd_pointlightfade);
	draw_sprite_ext(sLights, 0, temp_plight.x - x, temp_plight.y - y, temp_lightrange, temp_lightrange, 0, temp_lightcolor, temp_lightintensity);
	shader_reset();
	
	surface_reset_target();
	
	// Copy Surface
	surface_set_target(surface_temp);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
	surface_copy(surface_temp, 0, 0, surface_light);
	
	// Calculate Lighting
	shader_set(shd_forwardlighting);
	
	texture_set_stage(sprite_normals, surface_get_texture(surface_normals));
	texture_set_stage(light_vectors, surface_get_texture(surface_vectors));
	texture_set_stage(light_blend, surface_get_texture(surface_blend));
	texture_set_stage(light_render, surface_get_texture(surface_temp));
	
	surface_set_target(surface_light);
	draw_sprite_stretched(sLights, 0, 0, 0, screen_width, screen_height);
	surface_reset_target();
	
	shader_reset();
}

// Draw Lighting Surface
shader_set(shd_drawlitsurface);

texture_set_stage(light_texture, surface_get_texture(surface_light));

draw_set_color(tint);
draw_surface(surface_color, x, y);
draw_set_color(c_white);

shader_reset();
