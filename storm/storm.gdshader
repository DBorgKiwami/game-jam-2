shader_type canvas_item;

uniform float circle_size : hint_range(0.0, 1.0) = 0.4;
uniform float border_size : hint_range(0.0, 1.0) = 0.1;
uniform float ratio_width = 1.0;
uniform float ratio_height = 1.0;
//uniform float darken_amount : hint_range(0.0, 1.0) = 1.0;

float sdUnevenCapsule(vec2 p, float r1, float r2, float h)
{
    p.x = abs(p.x);
    float b = (r1-r2)/h;
    float a = sqrt(1.0-b*b);
    float k = dot(p,vec2(-b,a));
    if( k < 0.0 ) return length(p) - r1;
    if( k > a*h ) return length(p-vec2(0.0,h)) - r2;
    return dot(p, vec2(a,b) ) - r1;
}

void fragment() {
	float ratio = ratio_width / ratio_height;
	float dist = distance(vec2(0.5), vec2(mix(0.5, UV.x, ratio), UV.y));
	//vec4 orig_color = texture(TEXTURE, UV);

	// step returns 0 inside, 1 outside
	float mask = step(circle_size, dist); 
    float zoom = 6.;
	vec2 uv0 = SCREEN_UV;
    uv0 *= zoom;
    
    // setting up grid and aspect ratio of each grid
    vec2 aspect = vec2(8., 1.); // make grid elements aspect ratio
    vec2 st = uv0 * aspect;
    vec2 id = floor(st);
	
    st.y += TIME * .8; // how fast it falls
    st.y += fract(sin(id.x * 45.67) * 456.78); // fractal & sin-ify grid!
    
    // random nums based on positions
    id = floor(st);
    float rand_num  = fract(sin(id.x * 12.34 + id.y * 56.78) * 789.45);
    
    st = fract(st) -.5; // repeat uv grid
    float t = TIME * (1.5 + rand_num * 1.5); // how fast the wave crashes
    t += fract(sin(id.x * 45.67 + id.y * 678.78) * 456.78) * 6.283;
    // 6.283 = 2PI to truly change sine wave up
    // draw dot via sdt, control y val. via wave with quick descent and slow ascent
    
    float y = -sin(t + sin(t + sin(t) * .5)) * .35; // .35 is cutout of st grid elem.
    vec2 pos = vec2(0., y); // record y val

    vec2 p = (st - pos) / aspect;
    float d = sdUnevenCapsule(p, .05, .0, .1); 
    float rain_drop = smoothstep(.05, .0, d);
    // 1st val in smoothstep is diameter

    // draw a trail of dots 
    vec2 tp = (fract(vec2(uv0.x, uv0.y - .8) * aspect.x * vec2(1., 2.)) - .5) / vec2(1., 2.);
    d = sdUnevenCapsule(tp, 0.08, .0, .1);
    float trail = smoothstep((.5 * (.5 - st.y)), .0, d) * smoothstep(0., 1., st.y - pos.y);  

    // gl_FragColor = vec4(st, 0., 1.); // DEBUG ST POS
    float randColor = fract(sin(id.x * 34.5 + id.y * 67.8) * 910.1);
    //float randColor = 1.;
    float drops = rain_drop + trail;

    COLOR = vec4(.0, .0, drops * randColor, .6);
	//COLOR = orig_color;
	COLOR.a *= mask; // mask OFF for inside, just 0 out the alpha channel
}