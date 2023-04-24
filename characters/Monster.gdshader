shader_type canvas_item;

uniform float progress : hint_range(0, 1);

void fragment() {
	vec4 color1 = texture(TEXTURE, UV);
	vec4 color2 = texture(TEXTURE, UV + vec2(sin(TIME*10.0)*progress, cos(TIME*10.0)*progress));
	vec4 final_color = mix(color1, color2, progress);
	
	if (final_color.a == 0.0) {
		discard;
	}
	
	COLOR = final_color;
}
