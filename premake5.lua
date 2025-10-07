project "GLFW"
	kind "StaticLib"
	language "C"

    targetdir ("%{wks.location}/Binaries/" .. OutputDir .. "/%{prj.name}")
    objdir ("%{wks.location}/Binaries/Intermediates/" .. OutputDir .. "/%{prj.name}")

	files
{
    "include/GLFW/glfw3.h",
    "include/GLFW/glfw3native.h",
    "src/internal.h",
    "src/platform.h",
    "src/mappings.h",
    "src/context.c",
    "src/init.c",
    "src/input.c",
    "src/monitor.c",
    "src/platform.c",
    "src/vulkan.c",
    "src/window.c",
    "src/egl_context.c",
    "src/osmesa_context.c",
    "src/null_platform.h",
    "src/null_joystick.h",
    "src/null_init.c",

    "src/null_monitor.c",
    "src/null_window.c",
    "src/null_joystick.c",

}
filter "system:linux"
    pic "On"

    systemversion "latest"
    staticruntime "On"

    files
    {
        -- X11 sources (optional: you can keep or switch)
        "src/x11_init.c",
        "src/x11_monitor.c",
        "src/x11_window.c",
        "src/xkb_unicode.c",

        -- Wayland sources
        "src/wl_init.c",
        "src/wl_monitor.c",
        "src/wl_window.c",


        "src/posix_time.c",
        "src/posix_module.c",
        "src/posix_poll.c",
        "src/posix_thread.c",
        "src/glx_context.c",
        "src/egl_context.c",
        "src/osmesa_context.c",
        "src/linux_joystick.c"
    }

    defines
    {
        "_GLFW_HAS_GLX",
        "_GLFW_HAS_EGL"
    }

    -- Premake pseudocode example
    prebuildcommands {
        '{MKDIR} %{wks.location}/generated',

        -- Already included protocols ...
        'wayland-scanner client-header /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml %{wks.location}/generated/xdg-shell-client-protocol.h',
        'wayland-scanner private-code /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml %{wks.location}/generated/xdg-shell-client-protocol-code.h',

        'wayland-scanner client-header /usr/share/wayland-protocols/unstable/xdg-decoration/xdg-decoration-unstable-v1.xml %{wks.location}/generated/xdg-decoration-unstable-v1-client-protocol.h',
        'wayland-scanner private-code /usr/share/wayland-protocols/unstable/xdg-decoration/xdg-decoration-unstable-v1.xml %{wks.location}/generated/xdg-decoration-unstable-v1-client-protocol-code.h',

        'wayland-scanner client-header /usr/share/wayland-protocols/stable/viewporter/viewporter.xml %{wks.location}/generated/viewporter-client-protocol.h',
        'wayland-scanner private-code /usr/share/wayland-protocols/stable/viewporter/viewporter.xml %{wks.location}/generated/viewporter-client-protocol-code.h',

        -- ✅ Relative Pointer
        'wayland-scanner client-header /usr/share/wayland-protocols/unstable/relative-pointer/relative-pointer-unstable-v1.xml %{wks.location}/generated/relative-pointer-unstable-v1-client-protocol.h',
        'wayland-scanner private-code /usr/share/wayland-protocols/unstable/relative-pointer/relative-pointer-unstable-v1.xml %{wks.location}/generated/relative-pointer-unstable-v1-client-protocol-code.h',

        -- pointer-constraints
        'wayland-scanner client-header /usr/share/wayland-protocols/unstable/pointer-constraints/pointer-constraints-unstable-v1.xml %{wks.location}/generated/pointer-constraints-unstable-v1-client-protocol.h',
        'wayland-scanner private-code /usr/share/wayland-protocols/unstable/pointer-constraints/pointer-constraints-unstable-v1.xml %{wks.location}/generated/pointer-constraints-unstable-v1-client-protocol-code.h',

        -- fractional-scale
        'wayland-scanner client-header /usr/share/wayland-protocols/staging/fractional-scale/fractional-scale-v1.xml %{wks.location}/generated/fractional-scale-v1-client-protocol.h',
        'wayland-scanner private-code /usr/share/wayland-protocols/staging/fractional-scale/fractional-scale-v1.xml %{wks.location}/generated/fractional-scale-v1-client-protocol-code.h',


        'wayland-scanner client-header /usr/share/wayland-protocols/staging/xdg-activation/xdg-activation-v1.xml %{wks.location}/generated/xdg-activation-v1-client-protocol.h',
        'wayland-scanner private-code /usr/share/wayland-protocols/staging/xdg-activation/xdg-activation-v1.xml %{wks.location}/generated/xdg-activation-v1-client-protocol-code.h',

        'wayland-scanner client-header /usr/share/wayland-protocols/unstable/idle-inhibit/idle-inhibit-unstable-v1.xml %{wks.location}/generated/idle-inhibit-unstable-v1-client-protocol.h',
        'wayland-scanner private-code /usr/share/wayland-protocols/unstable/idle-inhibit/idle-inhibit-unstable-v1.xml %{wks.location}/generated/idle-inhibit-unstable-v1-client-protocol-code.h',


        'wayland-scanner code /usr/share/wayland/wayland.xml %{wks.location}/generated/wayland-client-protocol-code.h',

        'wayland-scanner client-header /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml %{wks.location}/generated/xdg-shell-client-protocol.h',
        'wayland-scanner private-code /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml %{wks.location}/generated/xdg-shell-client-protocol-code.h',

    }





    links {
        "wayland-client",
        "wayland-cursor",
        "wayland-egl",
        "X11",
        "Xrandr",
        "GL",
        "m",
        "dl"
    }

    includedirs {
        "%{wks.location}/generated"
    }

    files {
        "%{wks.location}/generated/xdg-shell-client-protocol.h",
        "%{wks.location}/generated/xdg-shell-client-protocol-code.h"
    }
    


filter "system:windows"
    systemversion "latest"
    staticruntime "On"
    


    files
    {
        "src/win32_init.c",
        "src/win32_module.c",
        "src/win32_joystick.c",
        "src/win32_monitor.c",
        "src/win32_time.h",
        "src/win32_time.c",
        "src/win32_thread.h",
        "src/win32_thread.c",
        "src/win32_window.c",
        "src/wgl_context.c",
        "src/egl_context.c",
        "src/osmesa_context.c"
    }

    defines 
    { 
        "_GLFW_WIN32",
        "_CRT_SECURE_NO_WARNINGS"

    }

filter "configurations:Debug"
    runtime "Debug"
    symbols "On"

filter "configurations:Release"
    runtime "Release"
    optimize "On"