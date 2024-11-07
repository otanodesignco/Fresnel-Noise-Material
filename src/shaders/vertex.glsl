out vec2 vUv;
out vec3 viewDirection;
out vec2 worldUV;
out vec3 normals;

void main()
{

    vec4 worldPosition = modelMatrix * vec4( position, 1.0 );
    vec4 worldNormal = modelMatrix * vec4( normal, 0.0 );
    vUv = uv;

    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );

    viewDirection = cameraPosition - worldPosition.xyz;
    worldUV = worldPosition.xy;
    normals = worldNormal.xyz;
}