import QtQuick 2.15

Item {

    property string mod_intro:
        "
[SystemSettings]

; |||||||||||||||||||||||||||||||||||||||||||||||||| A S C E N D I O   I I I . I ||||||||||||||||||||||||||||||||||||||||||||||||||
; ||||||||||||||||||||||||||||||||||||||||||||| FPS HOTFIX & ENGINE TWEAKS | BY SEIFU |||||||||||||||||||||||||||||||||||||||||||||

; || TAGS |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
; || [!] = dangerous parameter due to lack of information regarding backend optimization.
; || [?] = don't know why it was/wasn't used.

; || DEBUGGING ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
; [][] Debug functions go in here

"

    property string fps_hotfix:
        "
; || MEMORY MANAGEMENT ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
r.FastVRam.GBufferVelocity=1						; useful for movement effects.
r.FastVRam.ShadowPerObject=0						; not needed
r.FastVRam.ShadowPointLight=1						; enables fast VRAM for point lights.
r.FastVRam.SSR=1									; enables fast VRAM for SSR.
r.FastVRam.CustomDepth=1							; enables fast VRAM for custom depth channel.
r.FastVRam.GBufferA=1								; enables fast VRAM for world normal
r.FastVRam.GBufferC=1								; enables fast VRAM for difuse
r.FastVRam.GBufferD=1								; enables fast VRAM for custom data
r.FastVRam.GBufferF=1								; enables fast VRAM for anisotropy
r.FastVRam.DistanceFieldShadows=0					; game doesn't use distance field shadows.
r.FastVRam.DistanceFieldAODownsampledBentNormal=0	; disable because there are no distance field shadows.
r.FastVRam.DistanceFieldAOHistory=0					; disable because there are no distance field shadows.
r.FastVRam.DistanceFieldAOScreenGridResources=0		; disable because there are no distance field shadows.
r.FastVRam.DistanceFieldNormal=0					; disable because there are no distance field shadows.
r.FastVRam.DistanceFieldTileIntersectionResources=0	; disable because there are no distance field shadows.

; || SHADERS / SHADER CACHE |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
r.DistanceFields=0									; as stated on memory management, this game doesn't use distance fields.
r.DistanceFieldShadowing=0							; as stated on memory management, this game doesn't use distance fields.
r.DefaultFeature.AmbientOcclusionStaticFraction=0	; Hogwarts Legacy doesn't use baked lighting.
r.ShaderLibrary.PrintExtendedStats=0				; do not print statistics for shader libs.
r.ForceAllCoresForShaderCompiling=1					; force CPU cores for shader compilation. expects multi-core CPU.
r.ShaderPipelineCache.PreOptimizeEnabled=1			; enables pre-optimization to get shaders pre-loaded. helps with performance.
r.ShaderPipelineCache.SaveAfterPSOsLogged=5			; PSO save frequency after log.
r.ShaderPipelineCache.BackgroundBatchSize=8			; 8 seems about right for pre-loading shaders and cache construction.
r.ShaderPipelineCache.BackgroundBatchTime=1.0		; stop after one second.
r.ShaderPipelineCache.LazyLoadShadersWhenPSOCacheIsPresent=1	; helps with loading times.
r.Shadow.UnbuiltPreviewInGame=0						; prevent non-constructed shadow cast on preview.
r.ParallelShadowsNonWholeScene=1					; allow shaders to get generated in parallel

; || MATERIALS ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
r.DiffuseIndirect.Denoiser=0						; denoiser for indirect lighting is so subtle that it's better to turn it off.
r.SeparateTranslucency=0							; not needed for Hogwarts Legacy translucent materials.
r.SeparateTranslucencyAutoDownsample=0				; as separated translucency is disabled, this parameter has no effect.

; || LOD / CULLING ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
r.FrustumCullNumWordsPerTask=512					; [!] higher numbers result in a more eficient culling, but relay on CPU power.

; || TEXTURE STREAMING ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
r.Streaming.LimitPoolSizeToVRAM=1					; pool size is relative to VRAM.
r.Streaming.AmortizeCPUToGPUCopy=1					; distribuite and prolonge frame load on several frames.
r.Streaming.NumStaticComponentsProcessedPerFrame=18	; max static components processed per frame.
r.Streaming.MaxNumTexturesToStreamPerFrame=16		; max textures processed per frame is slightly lower to prevent GPU overload.
r.Streaming.AllowFastForceResident=0				; do not force streamer residents on VRAM.
r.Streaming.Boost=1.5								; boost texture streamer to prevent potatoing.

"




    property string rt_hotfix:
        "
; || RAY TRACING ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
r.EnableConcurrentSceneProxyCreation=1				; [!] enables concurrent proxy generation on scene. could be unstable.
r.RayTracing.ExcludeDecals=1						; [?] seems to not be doing anything though.
r.RayTracing.Culling=1								; [!] could generate issues with RT shadows.
r.RayTracing.UseTextureLod=1						; enables the use of LODs on RT.
r.RayTracing.Geometry.ProceduralMeshes=1			; default meshes are too expensive to run ray tracing on.
r.RayTracing.Geometry.MaxBuiltPrimitivesPerFrame=3000	; higher value to prevent stuttering and frame drops.
r.RayTracing.Shadow.MaxBatchSize=320				; bigger batch size shadows.
r.RayTracing.Shadows.AcceptFirstHit=1				; less precise, but should improve performance and still look good.
r.RayTracing.Shadows.EnableHairVoxel=0				; disable the use of voxelization on hair strands. it's too expensive.
r.RayTracing.PSOCacheSize=640						; cache size for ray tracing PSO.
r.PSO.EvictionTime=25								; more frequent evictions
r.RayTracing.SkyLight.EnableMaterials=1				; improves quallity and fixes graphics artifacts with several materials.

;|| RAY TRACED REFLECTIONS ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
r.RayTracing.Reflections.Hybrid=1						; mix ray traced reflections with screen space when appropiate.
r.RayTracing.Reflections.MaxBounces=1					; just one bounce lacks precission but we can throw more rays.
r.RayTracing.Reflections.AnyHitMaxRoughness=0.9			; if surface is hyper-reflective, do not use experimental methods.
r.RayTracing.Reflections.ScreenPercentage=45			; percentage of screen taken into account by reflections
r.RayTracing.Reflections.MaxRayDistance=2500.0f			; max distance before rays stop getting computed.
r.RayTracing.Reflections.Denoiser=1						; smooths noise for less artifacts
r.RayTracing.Reflections.Denoiser.Intensity=1.0
r.RayTracing.Reflections.Denoiser.SamplesPerPixel=1
r.RayTracing.Reflections.Denoiser.Radius=1.8
r.RayTracing.Reflections.Filter=1.2						; filters reflections for performance.
r.RayTracing.Reflections.BoundingRadiusThreshold=0.25	; limits the generation of RT acceleration structures based on radius
r.RayTracing.Reflections.SamplesPerPixel=1				; reduced amount of rays per pixel for performance boost.
r.RayTracing.Reflections.ReflectionsIntensityScale=0.7	; (tried) reduced reflection intensity. Most likely not doing anything.
r.RayTracing.Reflections.SpecularIntensityScale=0.2		; (tried) reduced intensity for specular materials, IE wood.
r.RayTracing.Reflections.DirectLighting=1				; relay on RT for direct lighting.
r.RayTracing.Reflections.EmissiveAndIndirectLighting=1	; way too many sources to leave this off.
r.RayTracing.Reflections.Shadows=0						; do not take into account shadows for reflections.
r.RayTracing.Reflections.Translucency=1					; do render windows (fake windows are taken as translucent for some reason).
r.RayTracing.Reflections.RayTraceSkyLightContribution=0	; do not take into account the sky light.
r.RayTracing.Reflections.HeightFog=1					; it's sketchy to see clear reflections on foggy weather.
r.RayTracing.Reflections.EnableTwoSidedGeometry=0		; inner faces are not important for reflections.
r.RayTracing.Reflections.ExperimentalDeferred=1			; [!] enables experimental deferred computation.
r.RayTracing.Reflections.ExperimentalDeferred.MipBias=1.0	; use lowest LOD possible for reflections.
r.RayTracing.Reflections.ExperimentalDeferred.AnyHitMaxRoughness=0.7			; minimum reflection to cast rays.
r.RayTracing.Reflections.ExperimentalDeferred.SpatialResolve=1					; use spatial resolve for better performance.
r.RayTracing.Reflections.ExperimentalDeferred.SpatialResolve.NumSamples=2		; spatial ressolve sample amount
r.RayTracing.Reflections.ExperimentalDeferred.SpatialResolve.MaxRadius=2		; max filter radius
r.RayTracing.Reflections.ExperimentalDeferred.SpatialResolve.TemporalQuality=1	; filter quallity
r.RayTracing.Reflections.ExperimentalDeferred.SpatialResolve.TemporalWeight=0.75		; intensity

; || RAY TRACED GLOBAL ILLUMINATION |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
r.RayTracing.GlobalIllumination.Filter=2.0				; filters the effect for performance.
r.RayTracing.GlobalIllumination.Denoiser=1				; smooths noise for less artifacts
r.RayTracing.GlobalIllumination.Denoiser.Intensity=0.9	; high intensity due to low resolution and strong filtering.
r.RayTracing.GlobalIllumination.Denoiser.SamplesPerPixel=1	; one sample is enough.
r.RayTracing.GlobalIllumination.Denoiser.Radius=4.0		; fairly big radious for a stronger blur effect.
r.GlobalIllumination.ExperimentalPlugin=1				; enables experimental GI.
r.GlobalIllumination.Denoiser.PreConvolution=0			: smoother noise.
r.RayTracing.GlobalIllumination.RenderTileSize=128		; 128 pixel tiles should run faster and offer a good enough result.
r.RayTracing.GlobalIllumination.MaxBounces=1			; just one bounce lacks precission, but it should be enough.
r.RayTracing.GlobalIllumination.SamplesPerPixel=1		; just one ray per pixel.
r.RayTracing.GlobalIllumination.ScreenPercentage=15		; we are looking for soft effects so we can use a low value.
r.RayTracing.GlobalIllumination.MaxRayDistance=1000000	; must be a big number as it has to take effect in large areas.
r.RayTracing.GlobalIllumination.MaxLightCount=24		; no more than 124 lights or performance will go brr.
r.RayTracing.GlobalIllumination.MaxShadowDistance=2500	; use ray tracing on close shadows only.
r.RayTracing.GlobalIllumination.EvalSkyLight=1			; take sky light into account for GI.
r.RayTracing.GlobalIllumination.EnableTransmission=1			; for translucent materials such as glass.
r.RayTracing.GlobalIllumination.EnableTwoSidedGeometry=0		; no need to take into account inner faces.
r.RayTracing.GlobalIllumination.FireflySuppression=1			; gets rid of unwanted artifacts
r.RayTracing.GlobalIllumination.NextEventEstimationSamples=1	; use just one sample on next event estimation.
r.RayTracing.GlobalIllumination.UseRussianRoulette=1			; stops tracking rays based on an estimation algorythm.
"
}
