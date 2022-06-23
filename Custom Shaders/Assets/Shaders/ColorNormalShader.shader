Shader "Unlit/MyShaders/ColorNormalShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RandomMultiplier("Random strength", Range(0,1000000)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"
            float _RandomMultiplier;
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            float Random(float x){
                float s = sin(x);
                return frac(s * 65124.457125);
            }
            float Random(float2 p){
                float d = dot(11.25566, 54.67921);
                float s = sin(d);
                return frac(s * 65124.457125);
            }
            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                float2 uv = i.uv * 10;
                float idx = floor(uv.x);
                float gvx = frac(uv.x);
                float rnd1 = Random(idx);
                float rnd2 = Random(idx + 1); 
                float c = smoothstep(0.0, 1.0, gvx);
                float col = lerp(rnd1, rnd2, gvx);
                return fixed4(col, col, col, 1);
            }
            ENDCG
        }
    }
}
