/// @description Insert description here
// You can write your code in this editor

// Surface Exists
if (!surface_exists(surface_temp)) {
	surface_temp = surface_create(480, 270);
}
if (!surface_exists(surface_vectors)) {
	surface_vectors = surface_create(480, 270);
}
if (!surface_exists(surface_blend)) {
	surface_blend = surface_create(480, 270);
}
if (!surface_exists(surface_normals)) {
	surface_normals = surface_create(480, 270);
}
if (!surface_exists(surface_lit)) {
	surface_lit = surface_create(480, 270);
}

// Surface Vectors
surface_set_target(surface_vectors);
//draw_clear_alpha(make_color_rgb(255 / 2, 255 / 2, 255), 1);
draw_clear_alpha(c_black, 0);
surface_reset_target();

for (var i = 0; i < instance_number(oPointLight); i++) {
	// Point Light Variables
	var temp_plight = instance_find(oPointLight, i);
	var temp_lightrange = (temp_plight.range / 32) * 2;
	
	// Draw Point Light
	surface_set_target(surface_temp);
	draw_clear_alpha(c_black, 0);
	
	shader_set(shd_pointlightvector);
	draw_sprite_ext(sLights, 0, temp_plight.x - x, temp_plight.y - y, temp_lightrange, temp_lightrange, 0, c_white, 1);
	shader_reset();
	
	surface_reset_target();
	
	// Duplicate Vectors Surface
	surface_set_target(surface_blend);
	draw_surface(surface_vectors, 0, 0);
	surface_reset_target();
	
	// Merge Vectors
	//shader_set(shd_mergevectors);
	
	//texture_set_stage(main_vectors, surface_get_texture(surface_blend));
	//texture_set_stage(merge_vectors, surface_get_texture(surface_temp));
	
	surface_set_target(surface_vectors);
	draw_surface(surface_temp, 0, 0);
	//draw_sprite_ext(sLights, 0, 240, 135, 15, 8.4375, 0, c_white, 1);
	surface_reset_target();
	
	//shader_reset();
}

// Surface Blend
surface_set_target(surface_blend);
draw_clear_alpha(c_black, 0);

gpu_set_blendmode(bm_max);
shader_set(shd_pointlightfade);

for (var i = 0; i < instance_number(oPointLight); i++) {
	var temp_plight = instance_find(oPointLight, i);
	
	var temp_lightrange = (temp_plight.range / 32) * 2;
	var temp_lightintensity = temp_plight.intensity;
	var temp_lightcolor = temp_plight.color;
	
	draw_sprite_ext(sLights, 0, temp_plight.x - x, temp_plight.y - y, temp_lightrange, temp_lightrange, 0, temp_lightcolor, temp_lightintensity);
}

gpu_set_blendmode(bm_normal);
shader_reset();

draw_set_color(c_white);
draw_set_alpha(1);

surface_reset_target();

// Surface Normals
surface_set_target(surface_normals);
draw_clear_alpha(c_black, 0);

for (var i = 0; i < instance_number(oSprite); i++) {
	var temp_sprite = instance_find(oSprite, i);
	draw_sprite(temp_sprite.normal_sprite, temp_sprite.image_index, temp_sprite.x - x, temp_sprite.y - y);
}

surface_reset_target();

// Surface Lit
surface_set_target(surface_lit);
draw_clear_alpha(c_black, 0);

for (var i = 0; i < instance_number(oSprite); i++) {
	var temp_sprite = instance_find(oSprite, i);
	draw_sprite(temp_sprite.lit_sprite, temp_sprite.image_index, temp_sprite.x - x, temp_sprite.y - y);
}

surface_reset_target();

// Draw Surface
shader_set(shd_deferredlighting);

texture_set_stage(light_vectors, surface_get_texture(surface_vectors));
texture_set_stage(light_blend, surface_get_texture(surface_blend));
texture_set_stage(sprite_normals, surface_get_texture(surface_normals));

draw_surface(surface_lit, x, y);

shader_reset();

//draw_surface(surface_vectors, x, y);
//draw_surface(surface_blend, x, y);