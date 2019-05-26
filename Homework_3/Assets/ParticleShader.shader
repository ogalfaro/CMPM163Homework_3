Shader "Custom/ParticleShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _StartColor("Start Color",Color) = (0,0,0,0)
        _EndColor("End Color", Color) = (0,0,0,0)
        _Bend("Bend", Float) = 0
        //Define properties for Start and End Color
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Opaque" }
        LOD 100
        
        Blend One One
        ZWrite off
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 uv: TEXCOORD0;
                //Define UV data
            };

            struct v2f
            {   
                float4 vertex : SV_POSITION;
                float3 uv: TEXCOORD0;
                //Define UV data
            };

            sampler2D _MainTex;
            uniform float _Bend;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv; //Correct this for particle shader
                //v.vertex.xy += (_Bend/2*v.vertex.z);
                v.vertex = v.vertex * _Bend;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }
            float4 _StartColor;
            float4 _EndColor;

            float4 frag (v2f i) : SV_Target
            {
                //Get particle age percentage
                float age = i.uv.z;    
                //Sample color from particle texture
                float4 col = tex2D(_MainTex,i.uv.xy);
                //Find "start color"
                float4 start = col * _StartColor;
                //Find "end color"
                float4 end = col * _EndColor;
                //Do a linear interpolation of start color and end color based on particle age percentage
               
                return lerp(start,end,age);//*(col.a)*0.15;
            }
            ENDCG
        }
    }
}
