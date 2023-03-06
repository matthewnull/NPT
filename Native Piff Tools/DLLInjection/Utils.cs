using System.Runtime.InteropServices;

namespace NPT.DLLInjection
{
    internal static class Utils
    {
        public static void CheckForFailure(bool failureIndicator, string message, params object[] args)
        {
            if (failureIndicator)
                throw new DLLInjectionFailedException(string.Format(message, args) + " (" + string.Format("LastWinError: {0}", (object)Marshal.GetLastWin32Error()) + ")");
        }
    }
}
