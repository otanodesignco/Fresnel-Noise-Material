uniform float uTime;
uniform float uPower;

in vec2 vUv;
in vec3 viewDirection;
in vec3 normals;

#include ./util/fresnel.glsl
#include ./noise/noiseFBM.glsl
#include ./util/twirl.glsl

void main()
{

    vec2 uv = vUv;

    float rotateOffset = uTime * 0.03;

    // rotate uv and generate noise

    uv = twirl( uv, vec2( 0.5), 6.0, vec2( rotateOffset ) );

    float noise =  pow( noiseFBM( uv * 5.0 ), uPower );

    // create fresnel based on the noise as the power
    float rimlight = fresnel( normals, viewDirection, noise );

    vec3 colorFresnel = vec3(0.16, 1.0, 0.8) * rimlight;

    gl_FragColor = vec4( colorFresnel * 1.3, 1.0 );

}