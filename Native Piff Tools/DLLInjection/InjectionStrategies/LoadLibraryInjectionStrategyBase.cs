using System;
using System.Text;

namespace NPT.DLLInjection.InjectionStrategies
{
    internal abstract class LoadLibraryInjectionStrategyBase : IInjectionStrategy
    {
        public IntPtr Inject(IntPtr processHandle, string dllPath)
        {
            if (processHandle == IntPtr.Zero)
                throw new ArgumentException("Invalid process handle", nameof(processHandle));
            byte[] lpBuffer = !string.IsNullOrWhiteSpace(dllPath) ? Encoding.ASCII.GetBytes(dllPath + "\0") : throw new ArgumentException("Invalid dll path", "pathToDll");
            IntPtr num1 = WinAPI.VirtualAllocEx(processHandle, IntPtr.Zero, (uint)lpBuffer.Length, WinAPI.AllocationType.Commit | WinAPI.AllocationType.Reserve, WinAPI.MemoryProtection.ExecuteReadWrite);
            Utils.CheckForFailure(num1 == IntPtr.Zero, "Cannot allocate memory in process");
            Utils.CheckForFailure(!WinAPI.WriteProcessMemory(processHandle, num1, lpBuffer, lpBuffer.Length, out IntPtr _), "Cannot write to process memory");
            IntPtr moduleHandle = WinAPI.GetModuleHandle("kernel32.dll");
            Utils.CheckForFailure(moduleHandle == IntPtr.Zero, "Cannot get handle to kernel32 module");
            IntPtr procAddress = WinAPI.GetProcAddress(moduleHandle, "LoadLibraryA");
            Utils.CheckForFailure(procAddress == IntPtr.Zero, "Cannot get address of LoadLibrary function");
            IntPtr num2 = this.Inject(processHandle, procAddress, num1);
            Utils.CheckForFailure((num2 == IntPtr.Zero ? 1 : 0) != 0, "Cannot create remote thread using {0} method.", (object)this.GetType().Name);
            return num2;
        }

        protected abstract IntPtr Inject(
          IntPtr processHandle,
          IntPtr loadLibraryAddress,
          IntPtr addressOfDllPath);
    }
}
