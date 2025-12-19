//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 textureSize;
uniform float blurRadius;

void main()
{
	vec2 texel = 1.0/textureSize;
	vec4 totalColor = vec4(0);
	
	/*for(float i= -blurRadius; i<=blurRadius; i++)
	{
		totalColor += texture2D(gm_BaseTexture, v_vTexcoord + vec2(i,0) * texel);
		totalColor += texture2D(gm_BaseTexture,v_vTexcoord);
	}
	
	totalColor /= ((blurRadius*2.0) + 1.0)*2.0;*/
	
	for(float i= -blurRadius; i<=blurRadius; i++)
	{
		totalColor += texture2D(gm_BaseTexture, v_vTexcoord + vec2(i,0) * texel);
	}
	
	totalColor /= (blurRadius*2.0) + 1.0;
    gl_FragColor = v_vColour * totalColor;
	//gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
