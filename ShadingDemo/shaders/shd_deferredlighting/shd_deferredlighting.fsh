//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D lightVectorTex;
uniform sampler2D lightBlendTex;
uniform sampler2D spriteNormalsTex;

void main()
{
	// Light Vector
	vec4 LightVectorColor = texture2D(lightVectorTex, v_vTexcoord);
	
	// Light Blend
	vec4 LightBlendColor = texture2D(lightBlendTex, v_vTexcoord);
	
	// Sprite Normals
	vec4 NormalColor = texture2D(spriteNormalsTex, v_vTexcoord);
	
	// Sprite Lit
	vec4 Color = texture2D(gm_BaseTexture, v_vTexcoord);
	
	// Calculate Normals
	float Alpha = 1.0;
	if (Color.a > 0.0) {
		// Vector RGB
		float LightVectorR = (LightVectorColor.r * 2.0) - 1.0;
		float LightVectorG = (LightVectorColor.g * 2.0) - 1.0;
		float LightVectorB = (LightVectorColor.b * 2.0) - 1.0;
		
		// Normal RGB
		float NormalR = (NormalColor.r * 2.0) - 1.0;
		float NormalG = ((1.0 - NormalColor.g) * 2.0) - 1.0;
		float NormalB = (NormalColor.b * 2.0) - 1.0;
		
		// Vector Calc
		NormalR = clamp(1.0 - abs(NormalR - LightVectorR), 0.0, 1.0);
		NormalG = clamp(1.0 - abs(NormalG - LightVectorG), 0.0, 1.0);
		NormalB = clamp(1.0 - abs(NormalB - LightVectorB), 0.0, 1.0);
		
		float Highlights = (NormalR + NormalG) * 0.5;
		
		Alpha = (Highlights * 0.8) + (NormalB * 0.2);
	}
	
	// Pass Color
	Color = Color * LightBlendColor;
    gl_FragColor = vec4(Color.r, Color.g, Color.b, Color.a * Alpha);
}
