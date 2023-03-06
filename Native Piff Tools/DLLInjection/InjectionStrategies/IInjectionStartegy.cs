using System;

namespace NPT.DLLInjection.InjectionStrategies
{
    internal interface IInjectionStrategy
    {
        IntPtr Inject(IntPtr processHandle, string dllPath);
    }
}
