import { OrbitControls } from '@react-three/drei'
import { Perf } from 'r3f-perf'
import FresnelNoiseMaterial from './FresnelNoiseMaterial'
import { useControls } from 'leva'

export default function Experience()
{
    const { power } = useControls({
        power:
        {
            value: -1.5,
            min: -5,
            max: 5,
            step: 0.01
        }
    })

    console.log( power )
    return <>

        <Perf position="top-left" />

        <OrbitControls makeDefault />

        <mesh>
            <icosahedronGeometry args={[ 3, 10 ]}/>
            <FresnelNoiseMaterial
                fresnelPower={ power }
            />
        </mesh>

    </>
}