uniform float uTime;
uniform float uPower;
uniform vec3 uColorFresnel;
uniform sampler2D utextureMap;
uniform sampler2D uTextureMapNite;

in vec2 vUv;
in vec3 viewDirection;
in vec3 normals;
in vec2 worldUV;

#include ./util/fresnel.glsl
#include ./noise/noiseFBM.glsl
#include ./noise/noiseVoronoi.glsl
#include ./noise/noiseSimple.glsl
#include ./util/twirl.glsl
#include ./util/radialShear.glsl
#include ./util/rotate2D.glsl
#include ./lighting/lightingDiffuse.glsl

void main()
{

    vec2 uv = vUv;


    vec4 textureDay = texture( utextureMap, uv );
    vec4 textureNite = texture( uTextureMapNite, uv );

    float rotateOffset = uTime * 0.01;
    float rotateOffset2 = uTime * 0.01;

    float lightingDiff = lightingDiffuse( normals, viewDirection );
    lightingDiff =  1.0 - smoothstep( 0.01, 1.0, lightingDiff );
    vec4 lightingDiffuze = vec4( vec3( 0.003, 0.003, 0.003 ), 0.4 );
    lightingDiffuze.rgb *= lightingDiff;

    // rotate uv and generate noise

    vec2 uv2 = twirl( uv, vec2( 0.5), 6.0, vec2( rotateOffset ) );
    uv = rotate2D( uv, rotateOffset2 );

    float noise =  pow( noiseFBM( uv * 5.0 ), -2.5 );

    float noiseSimple = pow( noiseSimple( uv2, 25. ), 4.0 );
    vec4 colorVoronoi = vec4( vec3( noiseSimple ) , 1.0 );
    colorVoronoi.rgb *= 2.0;

    float rimLight3 = fresnel( normals, viewDirection, 3.7 );

    // create fresnel based on the noise as the power
    float rimlight = fresnel( normals, viewDirection, noise );

    vec4 colorFresnel = vec4( vec3( rimlight ), 1.0 );

    float rimLightDirection = dot( normalize( vec3( 1.0, 0.0, 0.0 ) ), normals );
    float blendTexturesOffset = dot( normals, vec3( 0.0, 0.0, 1.0 ) );
    blendTexturesOffset = smoothstep( - 0.5, 1.0, blendTexturesOffset );

    vec4 colorBase = mix( textureDay, textureNite, blendTexturesOffset );
    colorBase = mix( colorBase, lightingDiffuze, lightingDiff );

    rimLightDirection = smoothstep( - 0.5, 1.0, rimLightDirection );

    vec4 colorRim1 = vec4(0.16, 0.47, 0.74, 1.0);
    vec4 colorRim2 = vec4(0.87, 0.4, 0.22, 1.0);

    vec4 colorRimLight = mix( colorRim1, colorRim2, rimLightDirection );
    colorRimLight.rgb *= 1.0;

    vec4 colorFinal = mix( colorBase, colorVoronoi, noiseSimple );
    colorFinal = mix( colorFinal, colorFresnel, rimlight );
    colorFinal = mix( colorFinal, colorRimLight, rimLight3 * blendTexturesOffset );

    
    gl_FragColor = colorFinal;
    //gl_FragColor = colorBase;
    #include <tonemapping_fragment>
    #include <colorspace_fragment>

}