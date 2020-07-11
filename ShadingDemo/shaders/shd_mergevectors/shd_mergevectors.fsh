//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform sampler2D vectorsMainTex;
uniform sampler2D vectorsMergeTex;

void main()
{
	// Vector Data
	vec4 VectorColor1 = texture2D(vectorsMainTex, v_vTexcoord);
	vec4 VectorColor2 = texture2D(vectorsMergeTex, v_vTexcoord);
	
	// Merge Vectors
	vec4 Color = VectorColor1;
	if (VectorColor2.a > 0.0) {
		/*
		vec3 n1 = (vec3(VectorColor1.r, VectorColor1.g, VectorColor1.b) * 2.0) - 1.0;
		vec3 n2 = (vec3(VectorColor2.r, VectorColor2.g, VectorColor2.b) * 2.0) - 1.0;
		vec3 nd = n1 + n2;
		vec3 rd = (vec3(nd.r, nd.g, nd.b) + 1.0) / 2.0;
		
		Color = vec4(rd.r, rd.g, rd.b, 1.0);
		*/
		
		//vec3 n1 = (VectorColor1.rgb * 2.0) - 1.0;
		//vec3 n2 = (VectorColor2.rgb  * 2.0) - 1.0;
		
	    //vec3 rd = ((n2 + n1) + 1.0) / 2.0;
		//rd = normalize(vec3(rd.x, rd.y, 1.0));
	    //Color = vec4(rd.r, rd.g, rd.b, 1.0);
		
		/*
		vec3 n1 = (vec3(VectorColor1.r, VectorColor1.g, VectorColor1.b) * 2.0) - 1.0;
		vec3 n2 = (vec3(VectorColor2.r, VectorColor2.g, VectorColor2.b) * 2.0) - 1.0;
		vec3 nd = (n1 * n2);
		
		float MinBlue = min(VectorColor1.b, VectorColor2.b);
		float MaxBlue = max(VectorColor1.b, VectorColor2.b);
		float MergeBlue = MaxBlue;
		float DifBlue = MaxBlue - MinBlue;
		if (DifBlue < 0.2) {
			DifBlue *= 5.0;
			MergeBlue = mix(MinBlue, MaxBlue, DifBlue);
		}
		*/
		vec3 n1 = (vec3(VectorColor1.r, VectorColor1.g, VectorColor1.b) * 2.0) - 1.0;
		vec3 n2 = (vec3(VectorColor2.r, VectorColor2.g, VectorColor2.b) * 2.0) - 1.0;
		
		float Red = ((n1.r + n2.r) + 1.0) / 2.0;
		float Green = ((n1.g + n2.g) + 1.0) / 2.0;
		float Blue = max(VectorColor1.b, VectorColor2.b);
		vec3 NormRG = normalize(vec3(Red, Green, 1.0));
		Color = vec4(NormRG.r, NormRG.g, Blue, 1.0);
		
		/*
		vec3 n1 = (vec3(VectorColor1.r, VectorColor1.g, VectorColor1.b) * 2.0) - 1.0;
		vec3 n2 = (vec3(VectorColor2.r, VectorColor2.g, VectorColor2.b) * 2.0) - 1.0;
		vec3 n3 = (normalize(n1 + n2) + 1.0) / 2.0;
		Color = vec4(clamp(n3.r, 0.0, 1.0), clamp(n3.g, 0.0, 1.0), (max(n1.b, n2.b) + 1.0) / 2.0, 1.0);
		*/
	}
	
	// Pass Color
	//Color = vec4(Color.r, 0.0, Color.b, 1.0);
    gl_FragColor = Color;
}
