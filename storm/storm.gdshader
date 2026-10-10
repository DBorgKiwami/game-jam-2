shader_type canvas_item;

uniform float circle_size : hint_range(0.0, 1.0) = 0.4;
uniform float border_size : hint_range(0.0, 1.0) = 0.1;
uniform float ratio_width = 1.0;
uniform float ratio_height = 1.0;


void fragment() {
	float ratio = ratio_width / ratio_height;
	float dist = distance(vec2(0.5, 0.5), vec2(mix(0.5, UV.x, ratio), UV.y));
	vec4 orig_color = texture(TEXTURE, UV);
	
	float mask = step(circle_size, dist);
	float borderMask = step(border_size, dist);
	float stormBorderWall = mask-borderMask;
	float act = mask - borderMask;
	//COLOR.rgba = vec4(1.0) * borderMask;
	COLOR.rgba = vec4(1.0) * stormBorderWall;
	//COLOR.rgb = vec3(0.0, 0.2, 1.0) * borderMask;
	//COLOR.rgb = vec3(stormBorderWall, borderMask, 0.0);
	//COLOR.a = mask;
	//COLOR.a = (1.0 - mask);
}