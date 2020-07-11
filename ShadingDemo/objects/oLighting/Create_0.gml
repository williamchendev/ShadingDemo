/// @description Insert description here
// You can write your code in this editor

// Settings
screen_width = 480;
screen_height = 270;
tint = c_white;

// Surfaces
surface_color = noone;
surface_normals = noone;

surface_temp = noone;
surface_vectors = noone;
surface_blend = noone;

surface_light = noone;

// Shader Textures
sprite_normals = shader_get_sampler_index(shd_forwardlighting, "spriteNormalTex");
light_vectors = shader_get_sampler_index(shd_forwardlighting, "lightVectorTex");
light_blend = shader_get_sampler_index(shd_forwardlighting, "lightBlendTex");
light_render = shader_get_sampler_index(shd_forwardlighting, "lightRenderTex");

light_texture = shader_get_sampler_index(shd_drawlitsurface, "lightTex");