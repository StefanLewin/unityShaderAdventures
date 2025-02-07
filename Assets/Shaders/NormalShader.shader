Shader "Unlit/NormalShader"
{
    Properties // input data
    {

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
            
            sampler2D _MainTex;
            float4 _MainTex_ST;

            struct MeshData
            { // Per-Vertec mesh data
                float4 vertex : POSITION; //vertex position
                float3 normals: NORMAL; //vertex normals
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION; // clip space position
                float3 normal: TEXCOORD0;
            };

            Interpolators vert (MeshData v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex); //Converts local space to clip space
                o.normal = UnityObjectToWorldNormal(v.normals);
                return o;
            }

            fixed4 frag (Interpolators i) : SV_Target
            {
                return float4(i.normal, 1);
            }
            ENDCG
        }
    }
}
