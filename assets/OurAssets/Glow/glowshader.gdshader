shader_type spatial;
// unshaded: żeby świecił sam z siebie
// blend_add: kolory dodają się do tła (jak światło), zamiast je nadpisywać
render_mode unshaded, blend_add;

uniform vec4 glow_color : source_color = vec4(1.0, 0.5, 0.0, 1.0); // Kolor (pomarańczowy domyślnie)
uniform float fresnel_power : hint_range(0.5, 10.0) = 1.0; // Jak wąska jest krawędź (im więcej tym cieńsza)
uniform float pulse_speed : hint_range(0.0, 10.0) = 2.0; // Prędkość pulsowania

void fragment() {
	// 1. Obliczamy Fresnel (Kąt patrzenia)
	// dot(NORMAL, VIEW) to matematyka: 1.0 = środek, 0.0 = krawędź
	float fresnel = dot(NORMAL, VIEW);
	
	// Odwracamy to: chcemy, żeby krawędź była jasna (1.0), a środek ciemny (0.0)
	// clamp zapobiega błędom przy ujemnych wartościach
	float rim = 1.0 - clamp(fresnel, 0.0, 1.0);
	
	// Potęgujemy wynik, żeby krawędź była ostra, a nie rozmyta na cały obiekt
	rim = pow(rim, fresnel_power);
	
	// 2. Dodajemy Twoje pulsowanie (czerwono-pomarańczowe)
	// Zmieniamy trochę logikę, żeby pulsowała jasność całego rima
	float pulse = (sin(TIME * pulse_speed) + 1.0) * 0.5; // wartość 0.0 - 1.0
	float intensity = 0.5 + (pulse * 0.5); // Minimalna jasność 0.5, max 1.0
	
	// 3. Wynik
	// Mnożymy kolor przez siłę Rima i pulsowanie
	ALBEDO = glow_color.rgb;
	
	// Klucz do sukcesu: ALPHA decyduje gdzie widać kolor
	ALPHA = rim * intensity * glow_color.a;
}