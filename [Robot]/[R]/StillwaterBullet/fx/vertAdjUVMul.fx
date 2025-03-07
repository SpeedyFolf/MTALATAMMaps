//
// file: vertAdjUVMul.fx
//

//---------------------------------------------------------------------
// Variables
//---------------------------------------------------------------------
float gColorMult = 1;
float2 gUVSpeed = float2(0,0);
float2 gUVMul = float2(1,1);
bool bZWrite = true;
int fCullMode = 2;
float fAlphaRef = 0.7;

texture sTex0;		

//---------------------------------------------------------------------
// Include some common stuff
//---------------------------------------------------------------------
float4x4 gWorld : WORLD;
float4x4 gView : VIEW;
float4x4 gWorldView : WORLDVIEW;
float4x4 gProjection : PROJECTION;
float4x4 gViewProjection : VIEWPROJECTION;
float4x4 gWorldViewProjection : WORLDVIEWPROJECTION;
float4x4 gViewInverse : VIEWINVERSE;
float3 gCameraDirection : CAMERADIRECTION;
texture secondRT < string renderTarget = "yes"; >;
texture gTexture0 < string textureState="0,Texture"; >;
matrix gProjectionMainScene : PROJECTION_MAIN_SCENE;
float3 gCameraPosition : CAMERAPOSITION;
float3 gCameraRotation : CAMERAROTATION;

int CUSTOMFLAGS <string skipUnusedParameters = "yes"; >;

int gFogEnable < string renderState="FOGENABLE"; >;
float4 gFogColor < string renderState="FOGCOLOR"; >;
float gFogStart < string renderState="FOGSTART"; >;
float gFogEnd < string renderState="FOGEND"; >;

int gLighting < string renderState="LIGHTING"; >;
int gDiffuseMaterialSource  < string renderState="DIFFUSEMATERIALSOURCE"; >;
int gAmbientMaterialSource  < string renderState="AMBIENTMATERIALSOURCE"; >;
int gEmissiveMaterialSource  < string renderState="EMISSIVEMATERIALSOURCE"; >;
float4 gGlobalAmbient < string renderState="AMBIENT"; >;
float4 gMaterialAmbient < string materialState="Ambient"; >;
float4 gMaterialDiffuse < string materialState="Diffuse"; >;
float4 gMaterialEmissive < string materialState="Emissive"; >;

float gTime : TIME;

//------------------------------------------------------------------------------------------
// Samplers for the textures
//------------------------------------------------------------------------------------------
sampler Sampler0 = sampler_state
{
    Texture     = (sTex0);
};

//---------------------------------------------------------------------
// Structure of data sent to the vertex shader
//---------------------------------------------------------------------
struct VSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
};

//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
};

//------------------------------------------------------------------------------------------
// MTACalcGTABuildingDiffuse
// - Calculate GTA lighting for buildings
//------------------------------------------------------------------------------------------
float4 MTACalcGTABuildingDiffuse( float4 InDiffuse )
{
    float4 OutDiffuse;

    if ( !gLighting )
    {
        // If lighting render state is off, pass through the vertex color
        OutDiffuse = InDiffuse;
    }
    else
    {
        // If lighting render state is on, calculate diffuse color by doing what D3D usually does
        float4 ambient  = gAmbientMaterialSource  == 0 ? gMaterialAmbient  : InDiffuse;
        float4 diffuse  = gDiffuseMaterialSource  == 0 ? gMaterialDiffuse  : InDiffuse;
        float4 emissive = gEmissiveMaterialSource == 0 ? gMaterialEmissive : InDiffuse;
        OutDiffuse = gGlobalAmbient * saturate( ambient + emissive );
        OutDiffuse.a *= diffuse.a;
    }
    return OutDiffuse;
}

//------------------------------------------------------------------------------------------
// VertexShaderFunction
//  1. Read from VS structure
//  2. Process
//  3. Write to PS structure
//------------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    PS.Position = mul(VS.Position,gWorldViewProjection);

    PS.Diffuse = MTACalcGTABuildingDiffuse(VS.Diffuse);
    PS.Diffuse.rgb *= gColorMult;
	
    float2 anim = float2(fmod(gTime * gUVSpeed.x, 1), fmod(gTime * gUVSpeed.y, 1));
	VS.TexCoord.xy *= gUVMul;
    VS.TexCoord.xy += anim;
    PS.TexCoord = VS.TexCoord;
    return PS;
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique world
{
    pass P0
    {
        AlphaRef = fAlphaRef;
		ZWriteEnable = bZWrite;
        AlphaBlendEnable = true;
        CullMode = fCullMode;
        VertexShader = compile vs_2_0 VertexShaderFunction();
        Texture[0] = sTex0;
    }
}

// Fallback
technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}
