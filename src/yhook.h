/**
 * Copyright (c) 2021 sigeryeung
 *
 * @file yhook.cc
 * @author Siger Yang (sigeryeung@gmail.com)
 * @date 2021-09-10
 *
 * @brief yhook 头
 */

#pragma once
#include <cstdint>
#include <string>
#include <vector>
#include <windows.h>

#ifdef ADD_EXPORTS
#define YHOOKAPI __declspec(dllexport)
#else
#define YHOOKAPI __declspec(dllimport)
#endif

#define YHOOKCALL __cdecl

typedef int (*YHOOKCALLBACK)(const char *name);
typedef YHOOKCALLBACK *PYHOOKCALLBACK;

struct yhook_entry
{
    PVOID original;
    PVOID detoured;
};

DWORD write_pipe(const uint8_t *data, const size_t length);
DWORD write_pipe(const std::string &s);
inline void
send_hook_message(const std::string &name,
                  const std::vector<std::pair<std::string, std::string>> &args);
inline void send_spawn_message();

extern HANDLE pipe;

#define DECLARE_HOOKED(f) decltype(f) hooked_ #f;

#ifdef __cplusplus
extern "C"
{
#endif

    YHOOKAPI LONG YHOOKCALL Hook();
    YHOOKAPI LONG YHOOKCALL UnHook();
    // YHOOKAPI LONG YHOOKCALL RegisterHookCallback(YHOOKCALLBACK callback);

#ifdef __cplusplus
}
#endif