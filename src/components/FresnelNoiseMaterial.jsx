import { shaderMaterial } from "@react-three/drei"
import { extend, useFrame } from "@react-three/fiber"
import vertex from '../shaders/vertex.glsl'
import fragment from '../shaders/fragment.glsl'
import { useRef } from "react"
import { Uniform } from "three"


export default function FresnelNoiseMaterial(
    {
        fresnelPower = -1.5, // power of fresnel
        ...props
}) 
{
    const fresnelRef = useRef()

    const uniforms=
    {
        uTime: 0,
        uPower: fresnelPower,
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
