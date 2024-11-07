import { shaderMaterial, useTexture } from "@react-three/drei"
import { extend, useFrame } from "@react-three/fiber"
import vertex from '../shaders/vertex.glsl'
import fragment from '../shaders/fragment.glsl'
import { useRef } from "react"
import { Color, SRGBColorSpace } from "three"


export default function FresnelNoiseMaterial(
    {
        fresnelPower = -1.5, // power of fresnel
        colorFresnel = '#ffffff', // second color,
        intensity = 1, // intensity for the colors
        ...props
}) 
{
    const fresnelRef = useRef()

    colorFresnel = new Color( colorFresnel ).multiplyScalar( intensity )

    const textureEarth = useTexture( './day.jpg' )
    textureEarth.colorSpace = SRGBColorSpace
    const textureNite = useTexture( './night.jpg' )

    const uniforms=
    {
        uTime: 0,
        uColorFresnel: colorFresnel,
        uPower: fresnelPower,
        utextureMap: textureEarth,
        uTextureMapNite: textureNite,
    }

    

    useFrame( ( state, delta ) =>
    {
        fresnelRef.current.uniforms.uTime.value += delta

    })

    const FresnelNoiseMaterial = shaderMaterial( uniforms, vertex, fragment )

    extend( { FresnelNoiseMaterial } )

    return (
    
    <fresnelNoiseMaterial
        key={ FresnelNoiseMaterial.key }
        ref={ fresnelRef }
        { ...props }
    />

    )
}
