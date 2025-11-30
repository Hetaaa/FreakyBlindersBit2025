shader_type spatial;
render_mode unshaded, blend_add;

// ZMIANA TUTAJ: (1.0, 0.0, 0.0, 1.0) to czysty czerwony
uniform vec4 glow_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); 

uniform float fresnel_power : hint_range(0.5, 10.0) = 1.0;
uniform float pulse_speed : hint_range(0.0, 10.0) = 2.0;

void fragment() {
	float fresnel = dot(NORMAL, VIEW);
	float rim = 1.0 - clamp(fresnel, 0.0, 1.0);
	rim = pow(rim, fresnel_power);
	
	float pulse = (sin(TIME * pulse_speed) + 1.0) * 0.5;
	float intensity = 0.5 + (pulse * 0.5);
	
	ALBEDO = glow_color.rgb;
	ALPHA = rim * intensity * glow_color.a;
}