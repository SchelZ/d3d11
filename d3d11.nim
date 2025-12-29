import winim/lean

# ------------------------------------------------------------
# Constants
# ------------------------------------------------------------

const
  D3D11_SDK_VERSION* = 7
  D3D_DRIVER_TYPE_HARDWARE* = 1
  D3D_FEATURE_LEVEL_11_0* = 0xB000'u32

  DXGI_FORMAT_R8G8B8A8_UNORM* = 28
  DXGI_USAGE_RENDER_TARGET_OUTPUT* = 0x20
  DXGI_SWAP_EFFECT_DISCARD* = 0

# ------------------------------------------------------------
# COM base
# ------------------------------------------------------------

type
  IUnknownVTable* = object
    QueryInterface*: proc(self: pointer, riid: ptr GUID, ppv: ptr pointer): int32 {.stdcall.}
    AddRef*: proc(self: pointer): int32 {.stdcall.}
    Release*: proc(self: pointer): int32 {.stdcall.}

  IUnknown* = object
    lpVtbl*: ptr IUnknownVTable

# ------------------------------------------------------------
# DXGI structs
# ------------------------------------------------------------

type
  DXGI_RATIONAL* = object
    Numerator*, Denominator*: int32

  DXGI_MODE_DESC* = object
    Width*, Height*: int32
    RefreshRate*: DXGI_RATIONAL
    Format*: int32
    ScanlineOrdering*: int32
    Scaling*: int32

  DXGI_SAMPLE_DESC* = object
    Count*, Quality*: int32

  DXGI_SWAP_CHAIN_DESC* = object
    BufferDesc*: DXGI_MODE_DESC
    SampleDesc*: DXGI_SAMPLE_DESC
    BufferUsage*: int32
    BufferCount*: int32
    OutputWindow*: int
    Windowed*: int32
    SwapEffect*: int32
    Flags*: int32

  D3D11_VIEWPORT* = object
    TopLeftX*, TopLeftY*, Width*, Height*, MinDepth*, MaxDepth*: float32
# ------------------------------------------------------------
# Interfaces
# ------------------------------------------------------------

type
  ID3D11Device* = object
    lpVtbl*: pointer

  ID3D11DeviceContext* = object
    lpVtbl*: pointer

  IDXGISwapChain* = object
    lpVtbl*: pointer

  ID3D11Texture2D* = object
    lpVtbl*: pointer

  ID3D11RenderTargetView* = object
    lpVtbl*: pointer

  ID3D11DeviceVTable* = object
    # IUnknown
    QueryInterface*: proc(self: ptr ID3D11Device; riid: ptr GUID; ppvObject: ptr pointer): int32 {.stdcall.}
    AddRef*: proc(self: ptr ID3D11Device): int32 {.stdcall.}
    Release*: proc(self: ptr ID3D11Device): int32 {.stdcall.}

    # ID3D11Device
    CreateBuffer*: proc(self: ptr ID3D11Device; pDesc: pointer; pInitialData: pointer; ppBuffer: ptr pointer): int32 {.stdcall.}
    CreateTexture1D*: proc(self: ptr ID3D11Device; pDesc: pointer; pInitialData: pointer; ppTexture1D: ptr pointer): int32 {.stdcall.}
    CreateTexture2D*: proc(self: ptr ID3D11Device; pDesc: pointer; pInitialData: pointer; ppTexture2D: ptr pointer): int32 {.stdcall.}
    CreateTexture3D*: proc(self: ptr ID3D11Device; pDesc: pointer; pInitialData: pointer; ppTexture3D: ptr pointer): int32 {.stdcall.}
    CreateShaderResourceView*: proc(self: ptr ID3D11Device; pResource: ptr ID3D11Device; pDesc: pointer; ppSRView: ptr pointer): int32 {.stdcall.}
    CreateUnorderedAccessView*: proc(self: ptr ID3D11Device; pResource: ptr ID3D11Device; pDesc: pointer; ppUAView: ptr pointer): int32 {.stdcall.}
    CreateRenderTargetView*: proc(self: ptr ID3D11Device; pResource: ptr ID3D11Texture2D; pDesc: pointer; ppRTView: ptr ptr ID3D11RenderTargetView): int32 {.stdcall.} # idx = 24
    CreateDepthStencilView*: proc(self: ptr ID3D11Device; pResource: ptr ID3D11Device; pDesc: pointer; ppDSView: ptr pointer): int32 {.stdcall.}
    CreateInputLayout*: proc(self: ptr ID3D11Device; pInputElementDescs: pointer; NumElements: int32; pShaderBytecodeWithInputSignature: pointer; BytecodeLength: int32; ppInputLayout: ptr pointer): int32 {.stdcall.}
    CreateVertexShader*: proc(self: ptr ID3D11Device; pShaderBytecode: pointer; BytecodeLength: int32; pClassLinkage: pointer; ppVertexShader: ptr pointer): int32 {.stdcall.}
    CreateGeometryShader*: proc(self: ptr ID3D11Device; pShaderBytecode: pointer; BytecodeLength: int32; pClassLinkage: pointer; ppGeometryShader: ptr pointer): int32 {.stdcall.}
    CreateGeometryShaderWithStreamOutput*: proc(self: ptr ID3D11Device; pShaderBytecode: pointer; BytecodeLength: int32; pSODeclaration: pointer; NumEntries: int32; pBufferStrides: ptr int32; NumStrides: int32; RasterizedStream: int32; pClassLinkage: pointer; ppGeometryShader: ptr pointer): int32 {.stdcall.}
    CreatePixelShader*: proc(self: ptr ID3D11Device; pShaderBytecode: pointer; BytecodeLength: int32; pClassLinkage: pointer; ppPixelShader: ptr pointer): int32 {.stdcall.}
    CreateHullShader*: proc(self: ptr ID3D11Device; pShaderBytecode: pointer; BytecodeLength: int32; pClassLinkage: pointer; ppHullShader: ptr pointer): int32 {.stdcall.}
    CreateDomainShader*: proc(self: ptr ID3D11Device; pShaderBytecode: pointer; BytecodeLength: int32; pClassLinkage: pointer; ppDomainShader: ptr pointer): int32 {.stdcall.}
    CreateComputeShader*: proc(self: ptr ID3D11Device; pShaderBytecode: pointer; BytecodeLength: int32; pClassLinkage: pointer; ppComputeShader: ptr pointer): int32 {.stdcall.}

    CreateClassLinkage*: proc(self: ptr ID3D11Device; ppLinkage: ptr pointer): int32 {.stdcall.}
    CreateBlendState*: proc(self: ptr ID3D11Device; pBlendStateDesc: pointer; ppBlendState: ptr pointer): int32 {.stdcall.}
    CreateDepthStencilState*: proc(self: ptr ID3D11Device; pDepthStencilDesc: pointer; ppDepthStencilState: ptr pointer): int32 {.stdcall.}
    CreateRasterizerState*: proc(self: ptr ID3D11Device; pRasterizerDesc: pointer; ppRasterizerState: ptr pointer): int32 {.stdcall.}
    CreateSamplerState*: proc(self: ptr ID3D11Device; pSamplerDesc: pointer; ppSamplerState: ptr pointer): int32 {.stdcall.}
    CreateQuery*: proc(self: ptr ID3D11Device; pQueryDesc: pointer; ppQuery: ptr pointer): int32 {.stdcall.}
    CreatePredicate*: proc(self: ptr ID3D11Device; pPredicateDesc: pointer; ppPredicate: ptr pointer): int32 {.stdcall.}
    CreateCounter*: proc(self: ptr ID3D11Device; pCounterDesc: pointer; ppCounter: ptr pointer): int32 {.stdcall.}
    CreateDeferredContext*: proc(self: ptr ID3D11Device; ContextFlags: int32; ppDeferredContext: ptr pointer): int32 {.stdcall.}
    OpenSharedResource*: proc(self: ptr ID3D11Device; hResource: HANDLE; riid: ptr GUID; ppResource: ptr pointer): int32 {.stdcall.}
    CheckFormatSupport*: proc(self: ptr ID3D11Device; Format: int32; pFormatSupport: ptr int32): int32 {.stdcall.}
    CheckMultisampleQualityLevels*: proc(self: ptr ID3D11Device; Format: int32; SampleCount: int32; pNumQualityLevels: ptr int32): int32 {.stdcall.}
    CheckCounterInfo*: proc(self: ptr ID3D11Device; pCounterInfo: ptr pointer): int32 {.stdcall.}
    CheckCounter*: proc(self: ptr ID3D11Device; pDesc: ptr pointer; pType: ptr int32; pActiveCounters: ptr int32; pName: pointer; pUnits: pointer; pDescription: pointer): int32 {.stdcall.}
    CheckFeatureSupport*: proc(self: ptr ID3D11Device; Feature: int32; pFeatureSupportData: pointer; FeatureSupportDataSize: int32): int32 {.stdcall.}
    GetPrivateData*: proc(self: ptr ID3D11Device; guid: ptr GUID; pDataSize: ptr int32; pData: pointer): int32 {.stdcall.}
    SetPrivateData*: proc(self: ptr ID3D11Device; guid: ptr GUID; DataSize: int32; pData: ptr pointer): int32 {.stdcall.}
    SetPrivateDataInterface*: proc(self: ptr ID3D11Device; guid: ptr GUID; pUnknown: ptr IUnknown): int32 {.stdcall.}
    GetFeatureLevel*: proc(self: ptr ID3D11Device): int32 {.stdcall.}
    GetCreationFlags*: proc(self: ptr ID3D11Device): int32 {.stdcall.}
    GetDeviceRemovedReason*: proc(self: ptr ID3D11Device): int32 {.stdcall.}
    GetImmediateContext*: proc(self: ptr ID3D11Device; ppImmediateContext: ptr ptr ID3D11DeviceContext) {.stdcall.}
    SetExceptionMode*: proc(self: ptr ID3D11Device; RaiseFlags: int32): int32 {.stdcall.}
    GetExceptionMode*: proc(self: ptr ID3D11Device): int32 {.stdcall.}


  ID3D11DeviceContextVTable* = object
    QueryInterface*: proc(self: ptr ID3D11DeviceContext; riid: ptr GUID; ppv: ptr pointer): int32 {.stdcall.}
    AddRef*: proc(self: ptr ID3D11DeviceContext): int32 {.stdcall.}
    Release*: proc(self: ptr ID3D11DeviceContext): int32 {.stdcall.}

    # ID3D11DeviceChild (3)
    GetDevice*: pointer
    GetPrivateData*: pointer
    SetPrivateData*: pointer
    SetPrivateDataInterface*: pointer

    # ID3D11DeviceContext methods (in order)
    VSSetConstantBuffers*: pointer
    PSSetShaderResources*: pointer
    PSSetShader*: pointer
    PSSetSamplers*: pointer
    VSSetShader*: pointer
    DrawIndexed*: pointer
    Draw*: pointer
    Map*: pointer
    Unmap*: pointer
    PSSetConstantBuffers*: pointer
    IASetInputLayout*: pointer
    IASetVertexBuffers*: pointer
    IASetIndexBuffer*: pointer
    DrawIndexedInstanced*: pointer
    DrawInstanced*: pointer
    GSSetConstantBuffers*: pointer
    GSSetShader*: pointer
    IASetPrimitiveTopology*: pointer
    VSSetShaderResources*: pointer
    VSSetSamplers*: pointer
    Begin*: pointer
    End*: pointer
    GetData*: pointer
    SetPredication*: pointer
    GSSetShaderResources*: pointer
    GSSetSamplers*: pointer
    OMSetRenderTargets*: proc(self: ptr ID3D11DeviceContext, NumViews: int32, ppRenderTargetViews: ptr ptr ID3D11RenderTargetView, pDepthStencilView: pointer) {.stdcall.}
    OMSetRenderTargetsAndUnorderedAccessViews*: pointer
    OMSetBlendState*: pointer
    OMSetDepthStencilState*: pointer
    SOSetTargets*: pointer
    DrawAuto*: pointer
    DrawIndexedInstancedIndirect*: pointer
    DrawInstancedIndirect*: pointer
    Dispatch*: pointer
    DispatchIndirect*: pointer
    RSSetState*: pointer
    RSSetViewports*: proc(self: ptr ID3D11DeviceContext, numViewports: int32, viewports: ptr D3D11_VIEWPORT) {.stdcall.}
    RSSetScissorRects*: pointer
    CopySubresourceRegion*: pointer
    CopyResource*: pointer
    UpdateSubresource*: pointer
    CopyStructureCount*: pointer
    ClearRenderTargetView*: proc(self: ptr ID3D11DeviceContext; rtv: ptr ID3D11RenderTargetView; colorRGBA: ptr float32) {.stdcall.}

  IDXGISwapChainVTable* = object
    QueryInterface*: proc(self: ptr IDXGISwapChain, riid: ptr GUID, ppv: ptr pointer): int32 {.stdcall.}
    AddRef*: proc(self: ptr IDXGISwapChain): int32 {.stdcall.}
    Release*: proc(self: ptr IDXGISwapChain): int32 {.stdcall.}

    # IDXGIObject
    SetPrivateData*: pointer
    SetPrivateDataInterface*: pointer
    GetPrivateData*: pointer
    GetParent*: pointer

    # IDXGIDeviceSubObject
    GetDevice*: pointer

    # IDXGISwapChain
    Present*: proc(self: ptr IDXGISwapChain, SyncInterval: int32, Flags: int32): int32 {.stdcall.}
    GetBuffer*: proc(self: ptr IDXGISwapChain, Buffer: int32, riid: ptr GUID, ppSurface: ptr pointer): int32 {.stdcall.}
    SetFullscreenState*: pointer
    GetFullscreenState*: pointer
    GetDesc*: pointer
    ResizeBuffers*: pointer
    ResizeTarget*: pointer
    GetContainingOutput*: pointer
    GetFrameStatistics*: pointer
    GetLastPresentCount*: pointer

  IDXGIFactoryVTable* = object
    QueryInterface*: proc(self: pointer, riid: ptr GUID, ppv: ptr pointer): int32 {.stdcall.}
    AddRef*: proc(self: pointer): int32 {.stdcall.}
    Release*: proc(self: pointer): int32 {.stdcall.}
    SetPrivateData*: pointer
    SetPrivateDataInterface*: pointer
    GetPrivateData*: pointer
    GetParent*: pointer
    EnumAdapters*: pointer
    MakeWindowAssociation*: pointer
    GetWindowAssociation*: pointer
    CreateSwapChain*: proc(self: ptr IDXGIFactory, device: pointer, desc: ptr DXGI_SWAP_CHAIN_DESC, swapChain: ptr ptr IDXGISwapChain): int32 {.stdcall.}

  IDXGIFactory* = object
    lpVtbl*: ptr IDXGIFactoryVTable

# ------------------------------------------------------------
# DXGI GUIDs
# ------------------------------------------------------------
const
  IID_IDXGIObject* = DEFINE_GUID(0xaec22fb8'i32, 0x76f3, 0x4639, [0x9b'u8, 0xe0, 0x28, 0xeb, 0x43, 0xa6, 0x7a, 0x2e])
  IID_IDXGIDeviceSubObject* = DEFINE_GUID(0x3d3e0379'i32, 0xf9de, 0x4d58, [0xbb'u8, 0x6c, 0x18, 0xd6, 0x29, 0x92, 0xf1, 0xa6])
  IID_IDXGIResource* = DEFINE_GUID(0x035f3ab4'i32, 0x482e, 0x4e50, [0xb4'u8, 0x1f, 0x8a, 0x7f, 0x8b, 0xd8, 0x96, 0x0b])
  IID_IDXGIKeyedMutex* = DEFINE_GUID(0x9d8e1289'i32, 0xd7b3, 0x465f, [0x81'u8, 0x26, 0x25, 0x0e, 0x34, 0x9a, 0xf8, 0x5d])
  IID_IDXGISurface* = DEFINE_GUID(0xcafcb56c'i32, 0x6ac3, 0x4889, [0xbf'u8, 0x47, 0x9e, 0x23, 0xbb, 0xd2, 0x60, 0xec])
  IID_IDXGISurface1* = DEFINE_GUID(0x4ae63092'i32, 0x6327, 0x4c1b, [0x80'u8, 0xae, 0xbf, 0xe1, 0x2e, 0xa3, 0x2b, 0x86])
  IID_IDXGIAdapter* = DEFINE_GUID(0x2411e7e1'i32, 0x12ac, 0x4ccf, [0xbd'u8, 0x14, 0x97, 0x98, 0xe8, 0x53, 0x4d, 0xc0])
  IID_IDXGIOutput* = DEFINE_GUID(0xae02eedb'i32, 0xc735, 0x4690, [0x8d'u8, 0x52, 0x5a, 0x8d, 0xc2, 0x02, 0x13, 0xaa])
  IID_IDXGISwapChain* = DEFINE_GUID(0x310d36a0'i32, 0xd2e7, 0x4c0a, [0xaa'u8, 0x04, 0x6a, 0x9d, 0x23, 0xb8, 0x88, 0x6a])
  IID_IDXGIFactory* = DEFINE_GUID(0x7b7166ec'i32, 0x21c7, 0x44ae, [0xb2'u8, 0x1a, 0xc9, 0xae, 0x32, 0x1a, 0xe3, 0x69])
  IID_IDXGIDevice* = DEFINE_GUID(0x54ec77fa'i32, 0x1377, 0x44e6, [0x8c'u8, 0x32, 0x88, 0xfd, 0x5f, 0x44, 0xc8, 0x4c])
  IID_IDXGIFactory1* = DEFINE_GUID(0x770aae78'i32, 0xf26f, 0x4dba, [0xa8'u8, 0x29, 0x25, 0x3c, 0x83, 0xd1, 0xb3, 0x87])
  IID_IDXGIAdapter1* = DEFINE_GUID(0x29038f61'i32, 0x3839, 0x4626, [0x91'u8, 0xfd, 0x08, 0x68, 0x79, 0x01, 0x1a, 0x05])
  IID_IDXGIDevice1* = DEFINE_GUID(0x77db970f'i32, 0x6276, 0x48ba, [0xba'u8, 0x28, 0x07, 0x01, 0x43, 0xb4, 0x39, 0x2c])

# ------------------------------------------------------------
# D3D11 GUIDs
# ------------------------------------------------------------
const 
  IID_ID3D11DeviceChild* = DEFINE_GUID(0x1841e5c8'i32, 0x16b0, 0x489b, [0xbc'u8, 0xc8, 0x44, 0xcf, 0xb0, 0xd5, 0xde, 0xae])
  IID_ID3D11DepthStencilState* = DEFINE_GUID(0x03823efb'i32, 0x8d8f, 0x4e1c, [0x9a'u8, 0xa2, 0xf6, 0x4b, 0xb2, 0xcb, 0xfd, 0xf1])
  IID_ID3D11BlendState* = DEFINE_GUID(0x75b68faa'i32, 0x347d, 0x4159, [0x8f'u8, 0x45, 0xa0, 0x64, 0x0f, 0x01, 0xcd, 0x9a])
  IID_ID3D11RasterizerState* = DEFINE_GUID(0x9bb4ab81'i32, 0xab1a, 0x4d8f, [0xb5'u8, 0x06, 0xfc, 0x04, 0x20, 0x0b, 0x6e, 0xe7])
  IID_ID3D11Resource* = DEFINE_GUID(0xdc8e63f3'i32, 0xd12b, 0x4952, [0xb4'u8, 0x7b, 0x5e, 0x45, 0x02, 0x6a, 0x86, 0x2d])
  IID_ID3D11Buffer* = DEFINE_GUID(0x48570b85'i32, 0xd1ee, 0x4fcd, [0xa2'u8, 0x50, 0xeb, 0x35, 0x07, 0x22, 0xb0, 0x37])
  IID_ID3D11Texture1D* = DEFINE_GUID(0xf8fb5c27'i32, 0xc6b3, 0x4f75, [0xa4'u8, 0xc8, 0x43, 0x9a, 0xf2, 0xef, 0x56, 0x4c])
  IID_ID3D11Texture2D* = DEFINE_GUID(0x6f15aaf2'i32, 0xd208, 0x4e89, [0x9a'u8, 0xb4, 0x48, 0x95, 0x35, 0xd3, 0x4f, 0x9c])
  IID_ID3D11Texture3D* = DEFINE_GUID(0x037e866e'i32, 0xf56d, 0x4357, [0xa8'u8, 0xaf, 0x9d, 0xab, 0xbe, 0x6e, 0x25, 0x0e])
  IID_ID3D11View* = DEFINE_GUID(0x839d1216'i32, 0xbb2e, 0x412b, [0xb7'u8, 0xf4, 0xa9, 0xdb, 0xeb, 0xe0, 0x8e, 0xd1])
  IID_ID3D11ShaderResourceView* = DEFINE_GUID(0xb0e06fe0'i32, 0x8192, 0x4e1a, [0xb1'u8, 0xca, 0x36, 0xd7, 0x41, 0x47, 0x10, 0xb2])
  IID_ID3D11RenderTargetView* = DEFINE_GUID(0xdfdba067'i32, 0x0b8d, 0x4865, [0x87'u8, 0x5b, 0xd7, 0xb4, 0x51, 0x6c, 0xc1, 0x64])
  IID_ID3D11DepthStencilView* = DEFINE_GUID(0x9fdac92a'i32, 0x1876, 0x48c3, [0xaf'u8, 0xad, 0x25, 0xb9, 0x4f, 0x84, 0xa9, 0xb6])
  IID_ID3D11UnorderedAccessView* = DEFINE_GUID(0x28acf509'i32, 0x7f5c, 0x48f6, [0x86'u8, 0x11, 0xf3, 0x16, 0x01, 0x0a, 0x63, 0x80])
  IID_ID3D11VertexShader* = DEFINE_GUID(0x3b301d64'i32, 0xd678, 0x4289, [0x88'u8, 0x97, 0x22, 0xf8, 0x92, 0x8b, 0x72, 0xf3])
  IID_ID3D11HullShader* = DEFINE_GUID(0x8e5c6061'i32, 0x628a, 0x4c8e, [0x82'u8, 0x64, 0xbb, 0xe4, 0x5c, 0xb3, 0xd5, 0xdd])
  IID_ID3D11DomainShader* = DEFINE_GUID(0xf582c508'i32, 0x0f36, 0x490c, [0x99'u8, 0x77, 0x31, 0xee, 0xce, 0x26, 0x8c, 0xfa])
  IID_ID3D11GeometryShader* = DEFINE_GUID(0x38325b96'i32, 0xeffb, 0x4022, [0xba'u8, 0x02, 0x2e, 0x79, 0x5b, 0x70, 0x27, 0x5c])
  IID_ID3D11PixelShader* = DEFINE_GUID(0xea82e40d'i32, 0x51dc, 0x4f33, [0x93'u8, 0xd4, 0xdb, 0x7c, 0x91, 0x25, 0xae, 0x8c])
  IID_ID3D11ComputeShader* = DEFINE_GUID(0x4f5b196e'i32, 0xc2bd, 0x495e, [0xbd'u8, 0x01, 0x1f, 0xde, 0xd3, 0x8e, 0x49, 0x69])
  IID_ID3D11InputLayout* = DEFINE_GUID(0xe4819ddc'i32, 0x4cf0, 0x4025, [0xbd'u8, 0x26, 0x5d, 0xe8, 0x2a, 0x3e, 0x07, 0xb7])
  IID_ID3D11SamplerState* = DEFINE_GUID(0xda6fea51'i32, 0x564c, 0x4487, [0x98'u8, 0x10, 0xf0, 0xd0, 0xf9, 0xb4, 0xe3, 0xa5])
  IID_ID3D11Asynchronous* = DEFINE_GUID(0x4b35d0cd'i32, 0x1e15, 0x4258, [0x9c'u8, 0x98, 0x1b, 0x13, 0x33, 0xf6, 0xdd, 0x3b])
  IID_ID3D11Query* = DEFINE_GUID(0xd6c00747'i32, 0x87b7, 0x425e, [0xb8'u8, 0x4d, 0x44, 0xd1, 0x08, 0x56, 0x0a, 0xfd])
  IID_ID3D11Predicate* = DEFINE_GUID(0x9eb576dd'i32, 0x9f77, 0x4d86, [0x81'u8, 0xaa, 0x8b, 0xab, 0x5f, 0xe4, 0x90, 0xe2])
  IID_ID3D11Counter* = DEFINE_GUID(0x6e8c49fb'i32, 0xa371, 0x4770, [0xb4'u8, 0x40, 0x29, 0x08, 0x60, 0x22, 0xb7, 0x41])
  IID_ID3D11ClassInstance* = DEFINE_GUID(0xa6cd7faa'i32, 0xb0b7, 0x4a2f, [0x94'u8, 0x36, 0x86, 0x62, 0xa6, 0x57, 0x97, 0xcb])
  IID_ID3D11ClassLinkage* = DEFINE_GUID(0xddf57cba'i32, 0x9543, 0x46e4, [0xa1'u8, 0x2b, 0xf2, 0x07, 0xa0, 0xfe, 0x7f, 0xed])
  IID_ID3D11CommandList* = DEFINE_GUID(0xa24bc4d1'i32, 0x769e, 0x43f7, [0x80'u8, 0x13, 0x98, 0xff, 0x56, 0x6c, 0x18, 0xe2])
  IID_ID3D11DeviceContext* = DEFINE_GUID(0xc0bfa96c'i32, 0xe089, 0x44fb, [0x8e'u8, 0xaf, 0x26, 0xf8, 0x79, 0x61, 0x90, 0xda])
  IID_ID3D11VideoDecoder* = DEFINE_GUID(0x3c9c5b51'i32, 0x995d, 0x48d1, [0x9b'u8, 0x8d, 0xfa, 0x5c, 0xae, 0xde, 0xd6, 0x5c])
  IID_ID3D11VideoProcessorEnumerator* = DEFINE_GUID(0x31627037'i32, 0x53ab, 0x4200, [0x90'u8, 0x61, 0x05, 0xfa, 0xa9, 0xab, 0x45, 0xf9])
  IID_ID3D11VideoProcessor* = DEFINE_GUID(0x1d7b0652'i32, 0x185f, 0x41c6, [0x85'u8, 0xce, 0x0c, 0x5b, 0xe3, 0xd4, 0xae, 0x6c])
  IID_ID3D11AuthenticatedChannel* = DEFINE_GUID(0x3015a308'i32, 0xdcbd, 0x47aa, [0xa7'u8, 0x47, 0x19, 0x24, 0x86, 0xd1, 0x4d, 0x4a])
  IID_ID3D11CryptoSession* = DEFINE_GUID(0x9b32f9ad'i32, 0xbdcc, 0x40a6, [0xa3'u8, 0x9d, 0xd5, 0xc8, 0x65, 0x84, 0x57, 0x20])
  IID_ID3D11VideoDecoderOutputView* = DEFINE_GUID(0xc2931aea'i32, 0x2a85, 0x4f20, [0x86'u8, 0x0f, 0xfb, 0xa1, 0xfd, 0x25, 0x6e, 0x18])
  IID_ID3D11VideoProcessorInputView* = DEFINE_GUID(0x11ec5a5f'i32, 0x51dc, 0x4945, [0xab'u8, 0x34, 0x6e, 0x8c, 0x21, 0x30, 0x0e, 0xa5])
  IID_ID3D11VideoProcessorOutputView* = DEFINE_GUID(0xa048285e'i32, 0x25a9, 0x4527, [0xbd'u8, 0x93, 0xd6, 0x8b, 0x68, 0xc4, 0x42, 0x54])
  IID_ID3D11VideoContext* = DEFINE_GUID(0x61f21c45'i32, 0x3c0e, 0x4a74, [0x9c'u8, 0xea, 0x67, 0x10, 0x0d, 0x9a, 0xd5, 0xe4])
  IID_ID3D11VideoDevice* = DEFINE_GUID(0x10ec4d5b'i32, 0x975a, 0x4689, [0xb9'u8, 0xe4, 0xd0, 0xaa, 0xc3, 0x0f, 0xe3, 0x33])
  IID_ID3D11Device* = DEFINE_GUID(0xdb6f6ddb'i32, 0xac77, 0x4e88, [0x82'u8, 0x53, 0x81, 0x9d, 0xf9, 0xbb, 0xf1, 0x40])


# ------------------------------------------------------------
# External functions
# ------------------------------------------------------------

proc D3D11CreateDevice*(
  pAdapter: pointer,
  DriverType: int32,
  Software: int,
  Flags: int32,
  pFeatureLevels: ptr int32,
  FeatureLevels: int32,
  SDKVersion: int32,
  ppDevice: ptr ptr ID3D11Device,
  pFeatureLevel: ptr int32,
  ppContext: ptr ptr ID3D11DeviceContext
): int32 {.stdcall, dynlib: "d3d11.dll", importc.}

proc CreateDXGIFactory*(riid: ptr GUID, ppFactory: ptr pointer): int32 {.stdcall, dynlib: "dxgi.dll", importc.}

# ------------------------------------------------------------
# High-level wrappers
# ------------------------------------------------------------

proc createDevice*(): tuple[device: ptr ID3D11Device, context: ptr ID3D11DeviceContext] =
  var featureLevels = [int32(D3D_FEATURE_LEVEL_11_0)]
  var obtained: int32
  var device: ptr ID3D11Device
  var context: ptr ID3D11DeviceContext

  let hr = D3D11CreateDevice(
    nil,
    D3D_DRIVER_TYPE_HARDWARE,
    int(0),
    0,
    addr featureLevels[0],
    int32(featureLevels.len),
    D3D11_SDK_VERSION,
    addr device,
    addr obtained,
    addr context
  )
  doAssert hr == S_OK
  result = (device, context)

proc createFactory*(): ptr IDXGIFactory =
  var raw: pointer
  let hr = CreateDXGIFactory(addr IID_IDXGIFactory, addr raw)
  if hr != 0:
    echo "[Error] createFactory failed, int32=", hr
  result = cast[ptr IDXGIFactory](raw)

proc CreateSwapChain*(factory: ptr IDXGIFactory, device: ptr ID3D11Device, desc: ptr DXGI_SWAP_CHAIN_DESC, swapChain: ptr ptr IDXGISwapChain): int32 {.discardable.} =
  let hr = factory.lpVtbl.CreateSwapChain(factory, cast[pointer](device), desc, swapChain)
  if hr != 0:
    echo "[Error] CreateSwapChain failed, int32=", hr
  return hr

proc GetBuffer*(swapChain: ptr IDXGISwapChain, index: int32, riid: ptr GUID, ppSurface: ptr ptr ID3D11Texture2D): int32 {.discardable.} =
  if swapChain.isNil:
    echo "[Error] swapChain is nil!"
    return -1  # E_FAIL
  let vtbl = cast[ptr IDXGISwapChainVTable](swapChain.lpVtbl)
  return vtbl.GetBuffer(swapChain, index, riid, cast[ptr pointer](ppSurface))

proc CreateRenderTargetView*(device: ptr ID3D11Device, resource: ptr ID3D11Texture2D, rtv: var ptr ID3D11RenderTargetView): int32 {.discardable.} =
  let vtbl = cast[ptr ID3D11DeviceVTable](device.lpVtbl)
  let hr = vtbl.CreateRenderTargetView(device, resource, nil, addr rtv)
  if hr != 0:
    echo "[Error] CreateRenderTargetView failed, int32=", hr
  return hr

proc CreateRenderTargetVi2ew*(device: ptr ID3D11Device, resource: ptr ID3D11Texture2D, rtv: var ptr ID3D11RenderTargetView): int32 {.discardable.}=
  if resource.isNil:
    echo "[Error] backBuffer is nil!"
    return -1  # E_FAIL

  let vtbl = cast[ptr ID3D11DeviceVTable](device.lpVtbl)
  let hr = vtbl.CreateRenderTargetView(device, resource, nil, addr rtv)
  if hr != 0:
    echo "[Error] CreateRenderTargetView failed, int32=", hr
  return hr

proc ClearRenderTargetView*(context: ptr ID3D11DeviceContext, rtv: ptr ID3D11RenderTargetView, color: ptr float32) =
  let vtbl = cast[ptr ID3D11DeviceContextVTable](context.lpVtbl)
  vtbl.ClearRenderTargetView(context, rtv, color)

proc OMSetRenderTargets*(context: ptr ID3D11DeviceContext, rtv: ptr ID3D11RenderTargetView) =
  let vtbl = cast[ptr ID3D11DeviceContextVTable](context.lpVtbl)
  vtbl.OMSetRenderTargets(context, 1, addr rtv, nil)

proc Present*(swapChain: ptr IDXGISwapChain, interval: int32, flags: int32) =
  let vtbl = cast[ptr IDXGISwapChainVTable](swapChain.lpVtbl)
  discard vtbl.Present(swapChain, interval, flags)

proc RSSetViewports*(context: ptr ID3D11DeviceContext, width, height: int32) =
  var vp: D3D11_VIEWPORT
  vp.TopLeftX = 0.0
  vp.TopLeftY = 0.0
  vp.Width = width.float32
  vp.Height = height.float32
  vp.MinDepth = 0.0
  vp.MaxDepth = 1.0
  let vtbl = cast[ptr ID3D11DeviceContextVTable](context.lpVtbl)
  vtbl.RSSetViewports(context, 1, addr vp)
