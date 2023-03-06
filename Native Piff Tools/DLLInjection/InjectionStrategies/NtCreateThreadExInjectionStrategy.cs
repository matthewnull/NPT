using System;
using System.Runtime.InteropServices;

namespace NPT.DLLInjection.InjectionStrategies
{
    internal class NtCreateThreadExInjectionStrategy : LoadLibraryInjectionStrategyBase
    {
        protected override unsafe IntPtr Inject(
          IntPtr processHandle,
          IntPtr loadLibraryAddress,
          IntPtr addressOfDllPath)
        {
            IntPtr moduleHandle = WinAPI.GetModuleHandle("ntdll.dll");
            Utils.CheckForFailure(moduleHandle == IntPtr.Zero, "Cannot load NTDLL module");
            IntPtr procAddress = WinAPI.GetProcAddress(moduleHandle, "NtCreateThreadEx");
            Utils.CheckForFailure(procAddress == IntPtr.Zero, "Cannot find NtCreateThreadEx address in NTDLL module");
            WinAPI.NtCreateThreadEx forFunctionPointer = (WinAPI.NtCreateThreadEx)Marshal.GetDelegateForFunctionPointer(procAddress, typeof(WinAPI.NtCreateThreadEx));
            Utils.CheckForFailure(forFunctionPointer == null, "Cannot create delegate from pointer to NtCreateThreadEx");
            int num1 = 0;
            int num2 = 0;
            WinAPI.NtCreateThreadExBuffer createThreadExBuffer = new WinAPI.NtCreateThreadExBuffer()
            {
                Size = sizeof(WinAPI.NtCreateThreadExBuffer),
                Unknown1 = 65539,
                Unknown2 = 8,
                Unknown3 = new IntPtr((void*)&num2),
                Unknown4 = 0,
                Unknown5 = 65540,
                Unknown6 = 4,
                Unknown7 = new IntPtr((void*)&num1),
                Unknown8 = 0
            };
            bool is64BitProcess = Environment.Is64BitProcess;
            IntPtr threadHandle = IntPtr.Zero;
            int num3 = forFunctionPointer(out threadHandle, 2097151U, IntPtr.Zero, processHandle, loadLibraryAddress, addressOfDllPath, 0, 0U, is64BitProcess ? (uint)ushort.MaxValue : 0U, is64BitProcess ? (uint)ushort.MaxValue : 0U, is64BitProcess ? IntPtr.Zero : new IntPtr((void*)&createThreadExBuffer));
            Utils.CheckForFailure(threadHandle == IntPtr.Zero, "NtCreateThreadEx failed");
            return threadHandle;
        }
    }
}

