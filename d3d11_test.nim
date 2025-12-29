import winim/lean
import dx11_core

var
  gSwapChain: ptr IDXGISwapChain
  gDevice: ptr ID3D11Device
  gContext: ptr ID3D11DeviceContext
  gRTV: ptr ID3D11RenderTargetView

proc wndProc(hwnd: HWND; msg: UINT; w: WPARAM; l: LPARAM): LRESULT {.stdcall.} =
  case msg
  of WM_DESTROY:
    PostQuitMessage(0)
    return 0
  else:
    return DefWindowProcW(hwnd, msg, w, l)

proc InitD3D(hwnd: HWND) =
  # --- device + context ---
  var featureLevels = [UINT(D3D_FEATURE_LEVEL_11_0)]
  var obtained: UINT

  let hrDev = D3D11CreateDevice(
    nil,
    D3D_DRIVER_TYPE_HARDWARE,
    HMODULE(0),
    0,
    addr featureLevels[0],
    1,
    D3D11_SDK_VERSION,
    addr gDevice,
    addr obtained,
    addr gContext
  )
  if hrDev != 0:
    echo "[Error] D3D11CreateDevice failed: ", hrDev
    quit(1)

  # --- factory ---
  var factoryRaw: pointer
  let hrFac = CreateDXGIFactory(addr IID_IDXGIFactory, addr factoryRaw)
  if hrFac != 0:
    echo "[Error] CreateDXGIFactory failed: ", hrFac
    quit(1)

  let factory = cast[ptr IDXGIFactory](factoryRaw)

  # --- swap chain ---
  var scd: DXGI_SWAP_CHAIN_DESC
  zeroMem(addr scd, sizeof(scd))
  scd.BufferCount = 1
  scd.BufferDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM
  scd.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT
  scd.OutputWindow = hwnd
  scd.SampleDesc.Count = 1
  scd.Windowed = TRUE

  CreateSwapChain(factory, gDevice, addr scd, addr gSwapChain)

  # --- back buffer ---
  var backBuffer: ptr ID3D11Texture2D
  let hrBB = GetBuffer(
    gSwapChain,
    0,
    addr IID_ID3D11Texture2D,
    addr backBuffer
  )
  if hrBB != 0 or backBuffer.isNil:
    echo "[Error] GetBuffer failed: ", hrBB
    quit(1)

  # --- RTV ---
  let hrRTV = CreateRenderTargetView(gDevice, backBuffer, gRTV)
  if hrRTV != 0 or gRTV.isNil:
    echo "[Error] CreateRenderTargetView failed: ", hrRTV
    quit(1)

  # --- bind RTV ---
  OMSetRenderTargets(gContext, gRTV)

  # --- viewport ---
  RSSetViewports(gContext, 800, 600)

proc RenderFrame() =
  var color: array[4, float32] = [0.0'f32, 0.2'f32, 0.4'f32, 1.0'f32]
  ClearRenderTargetView(gContext, gRTV, addr color[0])
  Present(gSwapChain, 0, 0)

when isMainModule:
  let hInst = GetModuleHandleW(nil)

  var wc: WNDCLASSW
  zeroMem(addr wc, sizeof(wc))
  wc.lpfnWndProc = wndProc
  wc.hInstance = hInst
  wc.lpszClassName = "DX11Nim"

  RegisterClassW(addr wc)

  let hwnd = CreateWindowW(
    wc.lpszClassName,
    "DX11 Nim Test",
    WS_OVERLAPPEDWINDOW,
    200, 200, 800, 600,
    0, 0, hInst, nil
  )

  ShowWindow(hwnd, SW_SHOW)

  InitD3D(hwnd)

  var msg: MSG
  while true:
    if PeekMessageW(addr msg, 0, 0, 0, PM_REMOVE):
      if msg.message == WM_QUIT:
        break
      TranslateMessage(addr msg)
      DispatchMessageW(addr msg)
    RenderFrame()
