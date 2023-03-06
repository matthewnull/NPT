namespace NPT.DLLInjection
{
    public class InjectionOptions
    {
        public bool WaitForThreadExit { get; set; }

        public static InjectionOptions Defaults => new InjectionOptions();
    }
}
