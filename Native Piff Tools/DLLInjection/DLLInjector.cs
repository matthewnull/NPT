using NPT.DLLInjection.InjectionStrategies;
using System;
using System.IO;

namespace NPT.DLLInjection
{
    public class DLLInjector
    {
        private IInjectionStrategy _injectionStrategy;

        public DLLInjector(InjectionMethod injectionMethod) => this._injectionStrategy = InjectionStrategyFactory.Create(injectionMethod);

        public void Inject(int pid, string pathToDll, InjectionOptions injectionOptions = null)
        {
            if (pid <= 0)
                throw new ArgumentException("Invalid process pid: " + pid.ToString(), nameof(pid));
            if ((string.IsNullOrWhiteSpace(pathToDll) ? 1 : (!File.Exists(pathToDll) ? 1 : 0)) != 0)
                throw new ArgumentException("Cannot access DLL: \"" + pathToDll + "\"");
            injectionOptions = injectionOptions ?? InjectionOptions.Defaults;
            IntPtr num1 = WinAPI.OpenProcess(WinAPI.ProcessAccessFlags.CreateThread | WinAPI.ProcessAccessFlags.VirtualMemoryOperation | WinAPI.ProcessAccessFlags.VirtualMemoryRead | WinAPI.ProcessAccessFlags.VirtualMemoryWrite | WinAPI.ProcessAccessFlags.QueryInformation, false, pid);
            Utils.CheckForFailure((num1 == IntPtr.Zero ? 1 : 0) != 0, "Cannot open process with PID: {0}", (object)pid);
            IntPtr hHandle = this._injectionStrategy.Inject(num1, pathToDll);
            if (injectionOptions.WaitForThreadExit)
            {
                int num2 = (int)WinAPI.WaitForSingleObject(hHandle, uint.MaxValue);
            }
            WinAPI.CloseHandle(num1);
        }
    }
}
