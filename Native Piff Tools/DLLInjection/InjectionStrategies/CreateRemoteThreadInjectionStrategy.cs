using System;

namespace NPT.DLLInjection.InjectionStrategies
{
    internal class CreateRemoteThreadInjectionStrategy : LoadLibraryInjectionStrategyBase
    {
        protected override IntPtr Inject(
          IntPtr processHandle,
          IntPtr loadLibraryAddress,
          IntPtr addressOfDllPath)
        {
            IntPtr remoteThread = WinAPI.CreateRemoteThread(processHandle, IntPtr.Zero, 0U, loadLibraryAddress, addressOfDllPath, 0U, IntPtr.Zero);
            Utils.CheckForFailure(remoteThread == IntPtr.Zero, "Cannot create remote thread using CreateRemoteThread method");
            return remoteThread;
        }
    }
}
