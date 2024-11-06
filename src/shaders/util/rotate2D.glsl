vec2 rotate2D(vec2 v, float a) {
	float s = sin(a);
	float c = cos(a);
	mat2 m = mat2(c, s, -s, c);
	return m * v;
}

// vec2 rotate2D( vec2 uv, vec2 pivot, float angle )
// {
// 	mat2 rotation = mat2(vec2(sin(angle), -cos(angle)),
// 						vec2(cos(angle), sin(angle)));
	
// 	uv -= pivot;
// 	uv = uv * rotation;
// 	uv += pivot;
// 	return uv;
// }