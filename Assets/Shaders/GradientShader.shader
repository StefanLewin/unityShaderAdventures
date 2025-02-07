Shader "Unlit/GradientShader"
{
    Properties // input data
    {
        _ColorA("Color A", Color) = (1,1,1,1)
        _ColorB("Color B", Color) = (1,1,1,1)
        _ColorStart("Color Start", Range(0,1)) = 0
        _ColorEnd("Color End", Range(0,1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _ColorA;
            float4 _ColorB;
            float _ColorStart;
            float _ColorEnd;
            
            sampler2D _MainTex;
            float4 _MainTex_ST;

            struct MeshData
            { // Per-Vertec mesh data
                float4 vertex : POSITION; //vertex position
                float4 uv0 : TEXCOORD0;
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION; // clip space position
                float2 uv : TEXCOORD1;
            };

            Interpolators vert (MeshData v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex); //Converts local space to clip space
                o.uv = v.uv0;
                return o;
            }

            float InverseLerp( float a, float b, float v)
            {
                return (v-a)/(b-a);
            }

            fixed4 frag (Interpolators i) : SV_Target
            {
                float t = saturate(InverseLerp(_ColorStart, _ColorEnd, i.uv.x));
                float4 outColor = lerp(_ColorA, _ColorB, t);
                return outColor;
            }
            ENDCG
        }
    }
}
