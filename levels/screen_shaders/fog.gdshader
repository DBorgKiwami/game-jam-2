shader_type canvas_item;

float random(vec2 st) {
    return fract(sin(dot(st, vec2(12.9898, 78.233))) * 43758.5453123);
}

// https://thebookofshaders.com/13/
// noise: smooth random values across 2D space
float noise (in vec2 st) {
    vec2 i = floor(st); // cell division
    vec2 f = fract(st); // raw pos within cell
    // four corners
    float a = random(i + vec2(0.0, 0.0));
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    // remapped pos
    vec2 u = f * f * (3.0 - 2.0 * f);

    float ab = mix(a,b,u.x); // interp along x axis ab corners
    float cd = mix(c,d,u.x);
    float ylerp = mix(ab,cd,u.y); // interp corners along y
    return ylerp;
}

float fractalBrownianMotion (in vec2 st) {
    // layering multiple lvls of noise atop each other
    float val;
    float amp = .5;
    for (int i = 0; i < 5; i++) {
        val += amp*noise(st);
        amp*=.45;
        st*=2.;
    }
    return val;
}

mat2 Rotate(float angle) {
    float s = sin(angle), c = cos(angle);
    return mat2(vec2(c, -s), vec2(s, c));
}

void fragment() {
    vec2 uv0 = SCREEN_UV;
    vec3 col = vec3(0);

    // background + rotation
    float a = TIME * .02;
    uv0 *= Rotate(a);  
    uv0 *= 100.; // bg zoom
    float perlin = fractalBrownianMotion(uv0);
    col += mix(
            vec3(0.698, 0.7059, 0.7098),
            vec3(0.2941, 0.2902, 0.2941),
            perlin);

    col *= col * col;
	COLOR = vec4(col * 1., COLOR.a); // maintain alpha via modulate
}
