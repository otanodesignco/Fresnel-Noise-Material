float lightingDiffuse( vec3 normal, vec3 viewDirection )
{
    return max( dot( normalize( normal ), normalize( viewDirection ) ), 0.0 );
}