#version 330

in vec2 texcoord;
out vec4 fragColor;

uniform sampler2D tex;
uniform float time;

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898,78.233))) * 43758.5453);
}

void main() {
    vec4 color = texture(tex, texcoord);

    float noise = rand(texcoord * time) * 0.05;
    color.rgb += noise;

    fragColor = color;
}
