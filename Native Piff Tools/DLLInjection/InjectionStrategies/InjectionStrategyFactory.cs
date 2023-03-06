using System;

namespace NPT.DLLInjection.InjectionStrategies
{
    internal static class InjectionStrategyFactory
    {
        public static IInjectionStrategy Create(InjectionMethod injectionMethod)
        {
            IInjectionStrategy injectionStrategy;
            if (injectionMethod == InjectionMethod.CREATE_REMOTE_THREAD)
            {
                injectionStrategy = (IInjectionStrategy)new CreateRemoteThreadInjectionStrategy();
            }
            else
            {
                if (injectionMethod != InjectionMethod.NT_CREATE_THREAD_EX)
                    throw new NotSupportedException(string.Format("Injection strategy: {0} is not supported", (object)injectionMethod));
                injectionStrategy = (IInjectionStrategy)new NtCreateThreadExInjectionStrategy();
            }
            return injectionStrategy;
        }
    }
}
