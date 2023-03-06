using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;

namespace NPT.Injection
{
    internal class InjectionAPI
    {
        public const int MAX_PATH = 260;
        private const int INVALID_HANDLE_VALUE = -1;

        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern IntPtr OpenProcess(
          InjectionAPI.ProcessAccessFlags processAccess,
          bool bInheritHandle,
          int processId);

        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool ReadProcessMemory(
          IntPtr hProcess,
          IntPtr lpBaseAddress,
          byte[] lpBuffer,
          int nSize,
          out IntPtr lpNumberOfBytesRead);

        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool WriteProcessMemory(
          IntPtr hProcess,
          IntPtr lpBaseAddress,
          [MarshalAs(UnmanagedType.AsAny)] object lpBuffer,
          int nSize,
          out IntPtr lpNumberOfBytesWritten);

        [DllImport("kernel32.dll")]
        private static extern bool Process32First(
          IntPtr hSnapshot,
          ref InjectionAPI.PROCESSENTRY32 lppe);

        [DllImport("kernel32.dll")]
        private static extern bool Process32Next(IntPtr hSnapshot, ref InjectionAPI.PROCESSENTRY32 lppe);

        [DllImport("kernel32.dll")]
        private static extern bool Module32First(IntPtr hSnapshot, ref InjectionAPI.MODULEENTRY32 lpme);

        [DllImport("kernel32.dll")]
        private static extern bool Module32Next(IntPtr hSnapshot, ref InjectionAPI.MODULEENTRY32 lpme);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern bool CloseHandle(IntPtr hHandle);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern IntPtr GetModuleHandle(string moduleName);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr CreateToolhelp32Snapshot(
          InjectionAPI.SnapshotFlags dwFlags,
          int th32ProcessID);

        [DllImport("kernel32", CharSet = CharSet.Ansi, SetLastError = true)]
        private static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

        [DllImport("kernel32.dll")]
        private static extern IntPtr CreateRemoteThread(
          IntPtr hProcess,
          IntPtr lpThreadAttributes,
          uint dwStackSize,
          IntPtr lpStartAddress,
          IntPtr lpParameter,
          uint dwCreationFlags,
          out IntPtr lpThreadId);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr VirtualAllocEx(
          IntPtr hProcess,
          IntPtr lpAddress,
          uint dwSize,
          InjectionAPI.AllocationType flAllocationType,
          InjectionAPI.MemoryProtection flProtect);

        public static IntPtr GetModuleBaseAddress(Process proc, string modName)
        {
            IntPtr moduleBaseAddress = IntPtr.Zero;
            foreach (ProcessModule module in (ReadOnlyCollectionBase)proc.Modules)
            {
                if (module.ModuleName == modName)
                {
                    moduleBaseAddress = module.BaseAddress;
                    break;
                }
            }
            return moduleBaseAddress;
        }

        public static IntPtr GetModuleBaseAddress(int procId, string modName)
        {
            IntPtr moduleBaseAddress = IntPtr.Zero;
            IntPtr toolhelp32Snapshot = InjectionAPI.CreateToolhelp32Snapshot(InjectionAPI.SnapshotFlags.Module | InjectionAPI.SnapshotFlags.Module32, procId);
            if (toolhelp32Snapshot.ToInt64() != -1L)
            {
                InjectionAPI.MODULEENTRY32 lpme = new InjectionAPI.MODULEENTRY32();
                lpme.dwSize = (uint)Marshal.SizeOf(typeof(InjectionAPI.MODULEENTRY32));
                if (InjectionAPI.Module32First(toolhelp32Snapshot, ref lpme))
                {
                    while (!lpme.szModule.Equals(modName))
                    {
                        if (!InjectionAPI.Module32Next(toolhelp32Snapshot, ref lpme))
                            goto label_5;
                    }
                    moduleBaseAddress = lpme.modBaseAddr;
                }
            }
        label_5:
            InjectionAPI.CloseHandle(toolhelp32Snapshot);
            return moduleBaseAddress;
        }

        public static int GetProcId(string procname)
        {
            int procId = 0;
            IntPtr toolhelp32Snapshot = InjectionAPI.CreateToolhelp32Snapshot(InjectionAPI.SnapshotFlags.Process, 0);
            if (toolhelp32Snapshot.ToInt64() != -1L)
            {
                InjectionAPI.PROCESSENTRY32 lppe = new InjectionAPI.PROCESSENTRY32();
                lppe.dwSize = (uint)Marshal.SizeOf(typeof(InjectionAPI.PROCESSENTRY32));
                if (InjectionAPI.Process32First(toolhelp32Snapshot, ref lppe))
                {
                    while (!lppe.szExeFile.Equals(procname))
                    {
                        if (!InjectionAPI.Process32Next(toolhelp32Snapshot, ref lppe))
                            goto label_5;
                    }
                    procId = (int)lppe.th32ProcessID;
                }
            }
        label_5:
            InjectionAPI.CloseHandle(toolhelp32Snapshot);
            return procId;
        }

        public static IntPtr FindDMAAddy(IntPtr hProc, IntPtr ptr, int[] offsets)
        {
            byte[] lpBuffer = new byte[IntPtr.Size];
            foreach (int offset in offsets)
            {
                InjectionAPI.ReadProcessMemory(hProc, ptr, lpBuffer, lpBuffer.Length, out IntPtr _);
                ptr = IntPtr.Size == 4 ? IntPtr.Add(new IntPtr(BitConverter.ToInt32(lpBuffer, 0)), offset) : (ptr = IntPtr.Add(new IntPtr(BitConverter.ToInt64(lpBuffer, 0)), offset));
            }
            return ptr;
        }

        public static bool InjectDLL(string dllpath, string procname)
        {
            Process[] processesByName = Process.GetProcessesByName(Path.GetFileNameWithoutExtension(procname));
            if (processesByName.Length == 0)
                return false;
            Process process = processesByName[0];
            InjectionAPI.GetProcId(procname);
            InjectionAPI.OpenProcess(InjectionAPI.ProcessAccessFlags.All, false, process.Id);
            if (!(process.Handle != IntPtr.Zero))
                return false;
            IntPtr num = InjectionAPI.VirtualAllocEx(process.Handle, IntPtr.Zero, 260U, InjectionAPI.AllocationType.Commit | InjectionAPI.AllocationType.Reserve, InjectionAPI.MemoryProtection.ReadWrite);
            if (num.Equals((object)0))
                return false;
            IntPtr lpNumberOfBytesWritten = IntPtr.Zero;
            if (!InjectionAPI.WriteProcessMemory(process.Handle, num, (object)dllpath.ToCharArray(), dllpath.Length, out lpNumberOfBytesWritten) || lpNumberOfBytesWritten.Equals((object)0))
                return false;
            InjectionAPI.GetProcAddress(InjectionAPI.GetModuleHandle("kernel32.dll"), "LoadLibraryA");
            IntPtr procAddress = InjectionAPI.GetProcAddress(InjectionAPI.GetModuleBaseAddress(process.Id, "KERNEL32.DLL"), "LoadLibraryA");
            IntPtr remoteThread = InjectionAPI.CreateRemoteThread(process.Handle, IntPtr.Zero, 0U, procAddress, num, 0U, out IntPtr _);
            if (remoteThread.Equals((object)0))
                return false;
            InjectionAPI.CloseHandle(remoteThread);
            process.Dispose();
            return true;
        }

        [Flags]
        public enum ProcessAccessFlags : uint
        {
            All = 2035711, // 0x001F0FFF
            Terminate = 1,
            CreateThread = 2,
            VirtualMemoryOperation = 8,
            VirtualMemoryRead = 16, // 0x00000010
            VirtualMemoryWrite = 32, // 0x00000020
            DuplicateHandle = 64, // 0x00000040
            CreateProcess = 128, // 0x00000080
            SetQuota = 256, // 0x00000100
            SetInformation = 512, // 0x00000200
            QueryInformation = 1024, // 0x00000400
            QueryLimitedInformation = 4096, // 0x00001000
            Synchronize = 1048576, // 0x00100000
        }

        [Flags]
        private enum SnapshotFlags : uint
        {
            HeapList = 1,
            Process = 2,
            Thread = 4,
            Module = 8,
            Module32 = 16, // 0x00000010
            Inherit = 2147483648, // 0x80000000
            All = Module32 | Module | Thread | Process | HeapList, // 0x0000001F
            NoHeaps = 1073741824, // 0x40000000
        }

        public struct PROCESSENTRY32
        {
            public uint dwSize;
            public uint cntUsage;
            public uint th32ProcessID;
            public IntPtr th32DefaultHeapID;
            public uint th32ModuleID;
            public uint cntThreads;
            public uint th32ParentProcessID;
            public int pcPriClassBase;
            public uint dwFlags;
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 260)]
            public string szExeFile;
        }

        public struct MODULEENTRY32
        {
            internal uint dwSize;
            internal uint th32ModuleID;
            internal uint th32ProcessID;
            internal uint GlblcntUsage;
            internal uint ProccntUsage;
            internal IntPtr modBaseAddr;
            internal uint modBaseSize;
            internal IntPtr hModule;
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 256)]
            internal string szModule;
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 260)]
            internal string szExePath;
        }

        [Flags]
        public enum AllocationType
        {
            Commit = 4096, // 0x00001000
            Reserve = 8192, // 0x00002000
            Decommit = 16384, // 0x00004000
            Release = 32768, // 0x00008000
            Reset = 524288, // 0x00080000
            Physical = 4194304, // 0x00400000
            TopDown = 1048576, // 0x00100000
            WriteWatch = 2097152, // 0x00200000
            LargePages = 536870912, // 0x20000000
        }

        [Flags]
        public enum MemoryProtection
        {
            Execute = 16, // 0x00000010
            ExecuteRead = 32, // 0x00000020
            ExecuteReadWrite = 64, // 0x00000040
            ExecuteWriteCopy = 128, // 0x00000080
            NoAccess = 1,
            ReadOnly = 2,
            ReadWrite = 4,
            WriteCopy = 8,
            GuardModifierflag = 256, // 0x00000100
            NoCacheModifierflag = 512, // 0x00000200
            WriteCombineModifierflag = 1024, // 0x00000400
        }
    }
}
