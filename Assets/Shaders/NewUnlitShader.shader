Shader "Custom/ColorPulseShader"
{
    Properties
    {
        _Color1 ("Color 1", Color) = (1, 0, 0, 1)
        _Color2 ("Color 2", Color) = (0, 0, 1, 1)
        _PulseSpeed ("Pulse Speed", Float) = 1.0
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
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 pos : POSITION;
                float4 color : COLOR;
            };

            float _PulseSpeed;
            float4 _Color1;
            float4 _Color2;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = v.color;
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                // »спользование встроенной переменной _Time
                float pulse = 0.5 + 0.5 * sin(_Time.y * _PulseSpeed);

                // »нтерпол€ци€ между двум€ цветами
                float4 color = lerp(_Color1, _Color2, pulse);
                return color;
            }
            ENDCG
        }
    }
    FallBack "Unlit/Color"
}
