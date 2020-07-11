/// @description Insert description here
// You can write your code in this editor

// Surfaces
surface_temp = noone;
surface_vectors = noone;
surface_blend = noone;
surface_normals = noone;
surface_lit = noone;

// Shader Textures
light_vectors = shader_get_sampler_index(shd_deferredlighting, "lightVectorTex");
light_blend = shader_get_sampler_index(shd_deferredlighting, "lightBlendTex");
sprite_normals = shader_get_sampler_index(shd_deferredlighting, "spriteNormalsTex");

main_vectors = shader_get_sampler_index(shd_mergevectors, "vectorsMainTex");
merge_vectors = shader_get_sampler_index(shd_mergevectors, "vectorsMergeTex");