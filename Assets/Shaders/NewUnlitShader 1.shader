Shader "Custom/DeformingPulseShader"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
        _PulseSpeed ("Pulse Speed", Float) = 1.0
        _PulseAmount ("Pulse Amount", Float) = 0.1
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

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 pos : POSITION;
                float4 color : COLOR;
            };

            float _PulseSpeed;
            float _PulseAmount;
            float4 _Color;

            v2f vert(appdata v)
            {
                v2f o;

                // —инусоидальное пульсирование
                float pulse = sin(_Time.y * _PulseSpeed) * _PulseAmount;

                // ћодификаци€ вершин с использованием нормалей дл€ создани€ формы пульсации
                v.vertex.xyz += v.normal * pulse;

                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = v.color;

                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                return _Color;
            }
            ENDCG
        }
    }
    FallBack "Unlit/Color"
}
