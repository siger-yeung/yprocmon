-- project("yprocmon")
add_includedirs("include")
add_linkdirs("lib")
add_defines("UNICODE")
target("detours")
    set_kind("static")
    add_includedirs("deps/detour/src")
    add_files("deps/detour/src/*.cpp|uimports.cpp")
    add_defines("WIN32_LEAN_AND_MEAN")
    add_defines("_WIN32_WINNT=0x501")
    add_defines("DETOUR_DEBUG=0")
    after_build(function(target)
        os.cp(target:targetfile(), "$(projectdir)/lib")
    end)
target("withdll")
    set_kind("binary")
    add_files("deps/detour/samples/withdll/withdll.cpp")
    add_links("detours")
    after_build(function(target)
        os.cp(target:targetfile(), "bin")
    end)
target("yhook")
    add_deps("detours")
    set_kind("shared")
    add_files("src/yhook.cc")
    add_links("detours")
    add_links("wsock32")
    add_links("ws2_32")
    add_defines("ADD_EXPORTS")
    after_build(function(target)
        os.cp(target:targetfile(), "bin")
    end)
target("ymsgbox")
    set_kind("binary")
    add_files("src/ymsgbox.c")
    after_build(function(target)
        os.cp(target:targetfile(), "bin")
    end)
target("yprocmon")
    set_kind("binary")
    add_files("src/yprocmon.cc")
    add_links("detours")
    add_links("wsock32")
    add_links("ws2_32")
    after_build(function(target)
        os.cp(target:targetfile(), "bin")
    end)

if is_arch("x86_64", "x64") then
    on_install(function()
        print("Installing MinGW x86_64 libraries...")
        os.cp("/usr/x86_64-w64-mingw32/bin/*.dll", "bin")
    end)
else
    on_install(function()
        print("Installing MinGW i686 libraries...")
        os.cp("/usr/i686-w64-mingw32/bin/*.dll", "bin")
    end)
end