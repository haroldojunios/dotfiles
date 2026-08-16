-- Converted from nvidia.conf

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("__GL_VRR_ALLOWED", "0")
hl.env("DRI_PRIME", "pci-0000_01_00_0")
hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")

hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
    misc = {
        vrr = 2,
        animate_manual_resizes = false,
    },
})
