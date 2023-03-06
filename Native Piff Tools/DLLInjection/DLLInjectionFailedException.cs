using System;

namespace NPT.DLLInjection
{
    [Serializable]
    public class DLLInjectionFailedException : Exception
    {
        public DLLInjectionFailedException(string message)
          : base(message)
        {
        }
    }
}
