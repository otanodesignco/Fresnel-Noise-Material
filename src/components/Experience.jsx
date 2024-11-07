import { OrbitControls, Stars } from '@react-three/drei'
import FresnelNoiseMaterial from './FresnelNoiseMaterial'
import { Leva, useControls } from 'leva'

export default function Experience()
{
    const { power, intensity } = useControls({
        power:
        {
            value: -1.5,
            min: -10,
            max: 10,
            step: 0.01
        },
        intensity:
        {
            value: 1.5,
            min: 1,
            max: 5,
            step: 0.01
        }
    })

    console.log( power )
    return <>

        <Leva hidden />

        <OrbitControls makeDefault />

        <mesh>
            <sphereGeometry args={[ 2.4, 65, 65 ]}/>
            <FresnelNoiseMaterial
                fresnelPower={ power }
                intensity={ intensity }
            />
        </mesh>
        <Stars radius={100} depth={50} count={1000} factor={4} saturation={0} fade speed={2} />

    </>
}