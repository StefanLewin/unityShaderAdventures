Shader "Unlit/MangoShader"
{
    Properties // input data
    {
        _Scale("UVScale", Float) = 1
        _Offset("UVOffset", Float) = 0
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

            float4 _Color;
            float _Scale;
            float _Offset;
            
            
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
                o.uv = (v.uv0 + _Offset) * _Scale;
                return o;
            }

            fixed4 frag (Interpolators i) : SV_Target
            {
                return float4(i.uv, 0, 1);
            }
            ENDCG
        }
    }
}
