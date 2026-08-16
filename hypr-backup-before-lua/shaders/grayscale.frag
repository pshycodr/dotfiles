#version 320 es
precision highp float;

in vec2 v_texcoord;
out vec4 fragColor;

uniform sampler2D tex;

const float BRIGHTNESS_CAP  = 0.90;  // caps peak white, cuts glare from bright document backgrounds
const float CONTRAST_SOFTEN = 0.08;  // pulls extremes toward mid-gray, keeps text legible
const float DESATURATE      = 0.10;  // reduces color fatigue without graying the screen out

void main() {
    vec4 src = texture(tex, v_texcoord);
    vec3 color = src.rgb;

    color *= BRIGHTNESS_CAP;

    color = mix(color, vec3(0.5) * BRIGHTNESS_CAP, CONTRAST_SOFTEN);

    float luminance = dot(color, vec3(0.2126, 0.7152, 0.0722));
    color = mix(color, vec3(luminance), DESATURATE);

    fragColor = vec4(color, src.a);
}
