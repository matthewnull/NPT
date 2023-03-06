using Microsoft.Win32;
using Newtonsoft.Json;
using NPT.DLLInjection;
using NPT.Injection;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.NetworkInformation;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace NPT
{
    public partial class Main : XtraForm
    {
        #region Public Strings

        public string stand_dll;
        public string[] versions;

        public string Ytd_Download { get; private set; }
        public string Config_Download { get; private set; }
        public string DllDownload = "";

        #endregion

        #region Private Statics

        private static readonly Random random = new Random();

        #endregion

        #region Private Bools

        private bool AnySuccessfulInjection;
        private bool GameWasOpen;
        private bool CanAutoInject = true;

        #endregion

        #region Private Ints

        private int gta_pid;

        #endregion

        #region Private Web Clients

        private readonly WebClient WebC = new WebClient();

        #endregion

        #region DLLImports

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr OpenProcess(
            uint dwDesiredAccess,
            int bInheritHandle,
            uint dwProcessId);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern int CloseHandle(IntPtr hObject);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr GetProcAddress(IntPtr hModule, string lpProcName);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr GetModuleHandle(string lpModuleName);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr VirtualAllocEx(
          IntPtr hProcess,
          IntPtr lpAddress,
          IntPtr dwSize,
          uint flAllocationType,
          uint flProtect);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern int WriteProcessMemory(
          IntPtr hProcess,
          IntPtr lpBaseAddress,
          byte[] buffer,
          uint size,
          int lpNumberOfBytesWritten);

        [DllImport("kernel32.dll", SetLastError = true)]
        private static extern IntPtr CreateRemoteThread(
          IntPtr hProcess,
          IntPtr lpThreadAttribute,
          IntPtr dwStackSize,
          IntPtr lpStartAddress,
          IntPtr lpParameter,
          uint dwCreationFlags,
          IntPtr lpThreadId);

        #endregion

        public Main()
        {
            InitializeComponent();

            Text += " 1.0.0.1";

            CheckForIllegalCrossThreadCalls = false;

            lookUpEdit1.Properties.DataSource = dropDownEntryBindingSource;
            lookUpEdit1.Properties.ValueMember = "ID";
            lookUpEdit1.Properties.DisplayMember = "Name";

            lookUpEdit1.Properties.DataSource = (new DropDownEntry[3]
            {
                 new DropDownEntry(0, "Epic Games"),
                 new DropDownEntry(1, "Steam"),
                 new DropDownEntry(2, "Rockstar Games")
            });

            comboBoxEdit1.SelectedIndex = Properties.Settings.Default.CurrentMenu;
            lookUpEdit1.EditValue = Properties.Settings.Default.GameLauncher;
            spinEdit1.Value = (Decimal)Properties.Settings.Default.AutoInjectDelaySeconds;
            checkEdit1.Checked = Properties.Settings.Default.Advanced;
            checkEdit3.Checked = Properties.Settings.Default.SaveOnClose;
            checkEdit4.Checked = Properties.Settings.Default.AutoInject;
            checkEdit7.Checked = Properties.Settings.Default.HideSensitiveInfo;

            UpdateTimer.Start();

            BringToFront();
        }

        #region Main Form Load & Close Events

        private void Main_Load(object sender, EventArgs e)
        {
            TopMost = true;
            Activate();
            BringToFront();

            if (!GameWasOpen)
            {
                XtraMessageBox.Show("You need to open GTA to inject any menu", "Native Piff Tools");
            }

            Thread t = new Thread(RunLoader);
            t.Start();
        }

        private void Main_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (checkEdit3.Checked == true)
            {
                Properties.Settings.Default.CurrentMenu = comboBoxEdit1.SelectedIndex;
                Properties.Settings.Default.GameLauncher = Convert.ToInt32(lookUpEdit1.EditValue);
                Properties.Settings.Default.AutoInjectDelaySeconds = (int)spinEdit1.Value;
                Properties.Settings.Default.Advanced = checkEdit1.Checked;
                Properties.Settings.Default.SaveOnClose = checkEdit3.Checked;
                Properties.Settings.Default.AutoInject = checkEdit4.Checked;
                Properties.Settings.Default.HideSensitiveInfo = checkEdit7.Checked;
                SaveSettings();
            }
            else
            {
                Properties.Settings.Default.Reset();
                Application.Exit();
            }
        }

        #endregion

        #region SimpleButtons Events

        private void SimpleButton1_Click(object sender, EventArgs e)
        {
            // Get the key value of the selected item
            object key = lookUpEdit1.EditValue;

            // Find the DropDownEntry object with the matching ID
            DropDownEntry entry = ((DropDownEntry[])lookUpEdit1.Properties.DataSource).FirstOrDefault(x => x.ID == (int)key);

            // Make sure an entry was found
            if (entry != null)
            {
                // Use the ID value in the switch statement
                switch (entry.ID)
                {
                    case 0:
                        Process.Start("com.epicgames.launcher://apps/9d2d0eb64d5c44529cece33fe2a46482?action=launch&silent=true");
                        break;
                    case 1:
                        Process.Start("steam://run/271590");
                        break;
                    case 2:
                        try
                        {
                            using (RegistryKey registryKey = Registry.LocalMachine.OpenSubKey("SOFTWARE\\WOW6432Node\\Rockstar Games\\Launcher"))
                            {
                                string str = (string)registryKey?.GetValue("InstallFolder");

                                if (str == null)
                                    break;

                                Process.Start(str + "\\Launcher.exe", "-minmodeApp=gta5");
                                break;
                            }
                        }
                        catch (Exception ex)
                        {
                            XtraMessageBox.Show(ex.ToString(), "Native Piff Tools");
                            break;
                        }
                }
            }
        }

        private void SimpleButton2_Click(object sender, EventArgs e)
        {
            if (comboBoxEdit1.SelectedIndex == 0)
            {
                Directory.CreateDirectory("C:\\Native Piff Tools\\BleachV");
                Directory.CreateDirectory("C:\\Native Piff Tools\\BleachV\\V");
                Directory.CreateDirectory("C:\\Native Piff Tools\\BleachV\\Themes");
                Directory.CreateDirectory("C:\\Native Piff Tools\\BleachV\\Logs");
                Directory.CreateDirectory("C:\\Native Piff Tools\\BleachV\\Logs");

                WebClient webClient = new WebClient();

                DllDownload = this.WebC.DownloadString("https://pastebin.com/raw/vvKqvRuP");

                File.Exists("C:\\Native Piff Tools\\BleachV\\Textures.ytd");

                if (File.Exists("C:\\\\River\\\\Settings.json"))
                {
                    Ytd_Download = WebC.DownloadString("https://pastebin.com/raw/vvKqvRuP");
                }

                string fileName1 = "C:\\Native Piff Tools\\BleachV\\Textures.ytd";
                string fileName2 = "C:\\Native Piff Tools\\BleachV\\Config.ini";
                string str1 = "C:\\Native Piff Tools\\BleachV\\V\\1.1";

                webClient.DownloadFile(DllDownload, str1);

                webClient.DownloadFile("https://cdn.discordapp.com/attachments/937375414664454255/1039985677888127047/Textures.ytd", fileName1);
                webClient.DownloadFile("https://cdn.discordapp.com/attachments/937375414664454255/1039987821211033690/Config.ini", fileName2);
                string str3 = "C:\\Native Piff Tools\\BleachV\\V\\1.1";
                if (Process.GetProcessesByName(Path.GetFileNameWithoutExtension("GTA5.exe")).Length == 0)
                {
                    _ = (int)XtraMessageBox.Show("Injection Failed: GTA5.exe Not Found (Open GTA)", "Native Piff Tools");
                }
                else if (InjectionAPI.InjectDLL(str3, "GTA5.exe"))
                {
                    _ = (int)XtraMessageBox.Show("Injection Done! Press INSERT To Open Menu.", "Native Piff Tools");
                }
                else
                {
                    _ = (int)XtraMessageBox.Show("Injection Failed: Unknown Error", "Native Piff Tools");
                    Process process;
                    string s;
                    try
                    {
                        process = Process.GetProcessesByName("GTA5")[0];
                        s = process.Id.ToString();
                    }
                    catch (IndexOutOfRangeException)
                    {
                        Close();
                        return;
                    }
                    try
                    {
#pragma warning disable IDE0018 // Inline variable declaration
                        int result;
#pragma warning restore IDE0018 // Inline variable declaration
                        if (!int.TryParse(s, out result))
                            return;
                        InjectionMethod injectionMethod = InjectionMethod.CREATE_REMOTE_THREAD;
                        try
                        {
                            new DLLInjector(injectionMethod).Inject(result, str3);
                            File.Delete(str1);
                        }
                        catch (Exception ex)
                        {
                            int num4 = (int)XtraMessageBox.Show(ex.Message, ex.GetType().Name, MessageBoxButtons.OK, MessageBoxIcon.Hand);
                        }
                    }
                    catch (WebException)
                    {
                        process.Kill();
                    }
                }
            } // BLEACHV - 1.66

            if (comboBoxEdit1.SelectedIndex == 1)
            {
                Directory.CreateDirectory("C:\\Native Piff Tools\\Scooby\\");
                Directory.CreateDirectory("C:\\Native Piff Tools\\Scooby\\Scooby");
                Directory.CreateDirectory("C:\\Native Piff Tools\\Scooby");

                WebClient webClient = new WebClient();

                DllDownload = WebC.DownloadString("https://pastebin.com/raw/EuVNFW0n");

                string path = "C:\\Native Piff Tools\\Scooby\\Scooby\\1.patch";
                string dlldownload = DllDownload;
                string fileName = path;

                webClient.DownloadFile(dlldownload, fileName);

                string str = "C:\\Native Piff Tools\\Scooby\\Scooby\\1.patch";

                if (Process.GetProcessesByName(Path.GetFileNameWithoutExtension("GTA5.exe")).Length == 0)
                {
                    _ = (int)XtraMessageBox.Show("Injection Failed: GTA5.exe Not Found (Open GTA)", "Native Piff Tools");
                }
                else if (InjectionAPI.InjectDLL(str, "GTA5.exe"))
                {
                    _ = (int)XtraMessageBox.Show("Injection Done! Press F5 To Open Menu", "Native Piff Tools");
                }
                else
                {
                    _ = (int)XtraMessageBox.Show("Injection Failed: Unknown Error", "Native Piff Tools");

                    Process process;
                    string s;

                    try
                    {
                        process = Process.GetProcessesByName("GTA5")[0];
                        s = process.Id.ToString();
                    }
                    catch (IndexOutOfRangeException)
                    {
                        Close();
                        return;
                    }
                    try
                    {
#pragma warning disable IDE0018 // Inline variable declaration
                        int result;
#pragma warning restore IDE0018 // Inline variable declaration
                        if (!int.TryParse(s, out result))
                            return;
                        InjectionMethod injectionMethod = InjectionMethod.CREATE_REMOTE_THREAD;
                        try
                        {
                            new DLLInjector(injectionMethod).Inject(result, str);
                            File.Delete(path);
                        }
                        catch (Exception ex)
                        {
                            int num6 = (int)XtraMessageBox.Show(ex.Message, ex.GetType().Name, MessageBoxButtons.OK, MessageBoxIcon.Hand);
                        }
                    }
                    catch (WebException)
                    {
                        process.Kill();
                    }
                }
            } // Scooby - 1.66

            if (comboBoxEdit1.SelectedIndex == 2)
            {
                Directory.CreateDirectory("C:\\Native Piff Tools\\Stryx");
                Directory.CreateDirectory("C:\\Native Piff Tools\\Stryx\\DLL");

                WebClient webClient = new WebClient();

                File.Delete("C:\\Native Piff Tools\\Stryx\\DLL\\module.dll");

                if (File.Exists("C:\\Native Piff Tools\\Stryx\\DLL\\module.dll"))
                    Close();

                DllDownload = WebC.DownloadString("https://pastebin.com/raw/cJgkDWqy");
                Ytd_Download = "https://cdn.discordapp.com/attachments/1023966826327187538/1067421832594079784/textures.ytd";

                string fileName1 = "C:\\Native Piff Tools\\Stryx\\DLL\\module.dll";
                string fileName2 = "C:\\Native Piff Tools\\Stryx\\textures.ytd";

                webClient.DownloadFile(DllDownload, fileName1);
                webClient.DownloadFile(Ytd_Download, fileName2);

                string str = "C:\\Native Piff Tools\\Stryx\\DLL\\module.dll";

                File.Exists(str);

                Process process;
                string s;

                try
                {
                    process = Process.GetProcessesByName("GTA5")[0];
                    s = process.Id.ToString();
                }
                catch (IndexOutOfRangeException)
                {
                    Close();
                    return;
                }
                try
                {
#pragma warning disable IDE0018 // Inline variable declaration
                    int result;
#pragma warning restore IDE0018 // Inline variable declaration
                    if (!int.TryParse(s, out result))
                        return;
                    InjectionMethod injectionMethod = InjectionMethod.CREATE_REMOTE_THREAD;
                    try
                    {
                        Thread.Sleep(2000);
                        new DLLInjector(injectionMethod).Inject(result, str);
                    }
                    catch (Exception ex)
                    {
                        int num = (int)MessageBox.Show(ex.Message, ex.GetType().Name, MessageBoxButtons.OK, MessageBoxIcon.Hand);
                    }
                }
                catch (WebException)
                {
                    process.Kill();
                }
            } // STRYX - 1.66

            if (comboBoxEdit1.SelectedIndex == 3)
            {
                Directory.CreateDirectory("C:\\Native Piff Tools\\TabMax");
                Directory.CreateDirectory("C:\\Native Piff Tools\\TabMax\\Textures");
                Directory.CreateDirectory("C:\\Native Piff Tools\\TabMax\\DLL");
                Directory.CreateDirectory("C:\\Native Piff Tools\\TabMax\\1");
                Directory.CreateDirectory("C:\\Native Piff Tools\\TabMax\\2");
                Directory.CreateDirectory("C:\\Native Piff Tools\\TabMax\\3");

                WebClient webClient = new WebClient();

                DllDownload = WebC.DownloadString("https://pastebin.com/raw/tSTeU56a");

                if (File.Exists("C:\\\\Native Piff Tools\\TabMax\\\\River.ytd") && File.Exists("C:\\\\Native Piff Tools\\TabMax\\\\Settings.json"))
                    Ytd_Download = WebC.DownloadString("https://pastebin.com/raw/Vpd4N1J6");

                string fileName1 = "C:\\Native Piff Tools\\TabMax\\English.json";
                string fileName2 = "C:\\Native Piff Tools\\TabMax\\Chinese.json";
                string str1 = "C:\\Native Piff Tools\\TabMax\\1.1";

                webClient.DownloadFile(DllDownload, str1);
                webClient.DownloadFile("https://cdn.discordapp.com/attachments/727827301936660480/1037441817823674430/English.json", fileName1);
                webClient.DownloadFile("https://cdn.discordapp.com/attachments/727827301936660480/1037442313456189460/Chinese2.json", fileName2);

                string str2 = "C:\\Native Piff Tools\\TabMax\\1.1";

                if (Process.GetProcessesByName(Path.GetFileNameWithoutExtension("GTA5.exe")).Length == 0)
                {
                    _ = (int)XtraMessageBox.Show("Injection Failed: GTA5.exe Not Found (Open GTA)", "Native Piff Tools");
                }
                else if (InjectionAPI.InjectDLL(str2, "GTA5.exe"))
                {
                    _ = (int)XtraMessageBox.Show("Injection Done! Press F5 To Open Menu", "Native Piff Tools");
                }
                else
                {
                    _ = (int)XtraMessageBox.Show("Injection Failed: Unknown Error", "Native Piff Tools");

                    Process process;
                    string s;

                    try
                    {
                        process = Process.GetProcessesByName("GTA5")[0];
                        s = process.Id.ToString();
                    }
                    catch (IndexOutOfRangeException)
                    {
                        Close();
                        return;
                    }
                    try
                    {
#pragma warning disable IDE0018 // Inline variable declaration
                        int result;
#pragma warning restore IDE0018 // Inline variable declaration
                        if (!int.TryParse(s, out result))
                            return;
                        InjectionMethod injectionMethod = InjectionMethod.CREATE_REMOTE_THREAD;
                        try
                        {
                            new DLLInjector(injectionMethod).Inject(result, str2);
                            File.Delete(str1);
                        }
                        catch (Exception ex)
                        {
                            int num6 = (int)XtraMessageBox.Show(ex.Message, ex.GetType().Name, MessageBoxButtons.OK, MessageBoxIcon.Hand);
                        }
                    }
                    catch (WebException)
                    {
                        process.Kill();
                    }
                }
            } // TABMAX - 1.66

            if (comboBoxEdit1.SelectedIndex == 4)
            {
                string fileName = "Kiddion\\modest-menu.exe";
                Process.Start(fileName);

                XtraMessageBox.Show("Injection Done! Press F5 To Open Menu", "Native Piff Tools");
            } // KIDDION - 1.66
        }

        private void SimpleButton7_Click(object sender, EventArgs e)
        {
            if (comboBoxEdit3.SelectedIndex == 0)
            {
                string target = comboBoxEdit3.SelectedIndex == 0 ? textEdit2.Text : GetIPAddress(textEdit2.Text);
                string url = $"http://ip-api.com/json/{target}";
                string result = "";

                using (WebClient client = new WebClient())
                {
                    string json = client.DownloadString(url);
                    dynamic location = JsonConvert.DeserializeObject(json);

                    result += "IP: " + location.query + Environment.NewLine;
                    result += "Country: " + location.country + Environment.NewLine;
                    result += "Region: " + location.regionName + Environment.NewLine;
                    result += "City: " + location.city + Environment.NewLine;
                    result += "Latitude: " + location.lat + Environment.NewLine;
                    result += "Longitude: " + location.lon + Environment.NewLine;
                    result += "Timezone: " + location.timezone + Environment.NewLine;
                    result += "ISP: " + location.isp + Environment.NewLine;
                    result += "Organization: " + location.org + Environment.NewLine;
                    result += "As: " + location.ast + Environment.NewLine;
                    result += "Status: " + location.status + Environment.NewLine;
                }

                MemoEdit memoEdit = new MemoEdit
                {
                    Dock = DockStyle.Fill,
                    Text = result,
                    ReadOnly = true
                };

                using (XtraForm dialog = new XtraForm())
                {
                    dialog.StartPosition = FormStartPosition.CenterParent;
                    dialog.FormBorderStyle = FormBorderStyle.FixedDialog;
                    dialog.MaximizeBox = false;
                    dialog.MinimizeBox = false;
                    dialog.Controls.Add(memoEdit);
                    dialog.ClientSize = new Size(500, 300);
                    dialog.ShowDialog(this);
                }
            }
            else if (comboBoxEdit3.SelectedIndex == 1)
            {
                string target = comboBoxEdit3.SelectedIndex == 1 ? textEdit2.Text : GetIPAddress(textEdit2.Text);
                string url = $"http://ip-api.com/json/{target}";
                string result = "";

                using (WebClient client = new WebClient())
                {
                    string json = client.DownloadString(url);
                    dynamic location = JsonConvert.DeserializeObject(json);

                    result += "IP: " + location.query + Environment.NewLine;
                    result += "Country: " + location.country + Environment.NewLine;
                    result += "Region: " + location.regionName + Environment.NewLine;
                    result += "City: " + location.city + Environment.NewLine;
                    result += "Latitude: " + location.lat + Environment.NewLine;
                    result += "Longitude: " + location.lon + Environment.NewLine;
                    result += "Timezone: " + location.timezone + Environment.NewLine;
                    result += "ISP: " + location.isp + Environment.NewLine;
                    result += "Organization: " + location.org + Environment.NewLine;
                    result += "As: " + location.ast + Environment.NewLine;
                    result += "Status: " + location.status + Environment.NewLine;
                }

                MemoEdit memoEdit = new MemoEdit
                {
                    Dock = DockStyle.Fill,
                    Text = result,
                    ReadOnly = true
                };

                using (XtraForm dialog = new XtraForm())
                {
                    dialog.StartPosition = FormStartPosition.CenterParent;
                    dialog.FormBorderStyle = FormBorderStyle.FixedDialog;
                    dialog.MaximizeBox = false;
                    dialog.MinimizeBox = false;
                    dialog.Controls.Add(memoEdit);
                    dialog.ClientSize = new Size(500, 300);
                    dialog.ShowDialog(this);
                }
            }
        }

        private void SimpleButton13_Click(object sender, EventArgs e)
        {
            int num;
            Thread thread = new Thread(() => num = (int)CustomDllDialog.ShowDialog());
            thread.SetApartmentState(ApartmentState.STA);
            thread.Start();
        }

        private void SimpleButton14_Click(object sender, EventArgs e)
        {
            if (listView1.SelectedItems.Count == 1)
            {
                int selectedIndex = listView1.SelectedIndices[0];

                if (selectedIndex == 0)
                {
                    return;
                }

                listView1.Items.RemoveAt(selectedIndex);

                if (listView1.Items.Count > selectedIndex && listView1.Items[selectedIndex] != null)
                {
                    listView1.Items[selectedIndex].Selected = true;
                }
                else
                {
                    listView1.Items[selectedIndex - 1].Selected = true;
                    listView1.SelectedItems.Clear();
                }
            }
            else
            {
                for (int index = listView1.Items.Count - 1; index > 0; --index)
                {
                    if (listView1.Items[index].Selected)
                    {
                        listView1.Items.RemoveAt(index);
                        listView1.SelectedItems.Clear();
                    }
                }
            }
            listView1.SelectedItems.Clear();
        }

        private void SimpleButton15_Click(object sender, EventArgs e) => InjectDll();


        #endregion

        #region Timer Tick Events

        private void UpdateTimer_Tick(object sender, EventArgs e)
        {
            UpdateTimer.Stop();

            CheckForUpdate(false);
            UpdateGtaPid();
            ProcessGtaPidUpdate(false);

            if (gta_pid != 0)
            {
                simpleButton15.Focus();
            }

            ProcessScanTimer.Start();

        }

        private void ProcessScanTimer_Tick(object sender, EventArgs e)
        {
            if (!UpdateGtaPid())
            {
                return;
            }
            ProcessGtaPidUpdate(CanAutoInject);
        }

        private void ReInjectTimer_Tick(object sender, EventArgs e)
        {
            ReInjectTimer.Stop();
            EnableReInject();
        }

        private void AutoInjectTimer_Tick(object sender, EventArgs e) => InjectDll();

        private void GameClosedTimer_Tick(object sender, EventArgs e)
        {
            GameClosedTimer.Stop();
            CanAutoInject = true;
        }

        #endregion

        #region Extra Events

        public static void SpoofComputerName()
        {
            RegistryKey ComputerName = RegistryKey.OpenBaseKey(RegistryHive.LocalMachine, RegistryView.Registry64);
            ComputerName = ComputerName.OpenSubKey(@"SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName", true);

            string PCName = (string)ComputerName.GetValue("ComputerName");

            ComputerName.SetValue("SpoofByNPT", 1);
            ComputerName.Close();

            XtraMessageBox.Show("New Computer Name: " + "'" + "SpoofByNPT" + "'" + "\r\n\r\n" + "Old Computer Name: " + "'" + PCName + "'", "Native Piff Tools");
        }

        private static void SpoofHwID()
        {
            string HardwareGuid = "{" + Guid.NewGuid().ToString() + "}";

            RegistryKey HardwareGuidKey = RegistryKey.OpenBaseKey(RegistryHive.LocalMachine, RegistryView.Registry64);
            HardwareGuidKey = HardwareGuidKey.OpenSubKey(@"SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001", true);

            string HardwareGuidResult = (string)HardwareGuidKey.GetValue("HwProfileGUID");

            HardwareGuidKey.SetValue("HwProfileGUID", HardwareGuid);
            HardwareGuidKey.Close();

            XtraMessageBox.Show("New Hardware ID: " + "'" + HardwareGuid + "'" + "\r\n\r\n" + "Old Hardware ID: " + "'" + HardwareGuidResult + "'");
        }

        private static void SpoofGuid()
        {

            string MachineGuid = Guid.NewGuid().ToString();

            RegistryKey MachineKey = RegistryKey.OpenBaseKey(RegistryHive.LocalMachine, RegistryView.Registry64);
            MachineKey = MachineKey.OpenSubKey(@"SOFTWARE\Microsoft\Cryptography", true);

            string MachineGuidResult = (string)MachineKey.GetValue("MachineGuid");

            MachineKey.SetValue("MachineGuid", MachineGuid);

            XtraMessageBox.Show("New Machine Guid: " + "'" + MachineGuid + "'" + "\r\n\r\n" + "Old Machine Guid: " + "'" + MachineGuidResult + "'", "Native Piff Tools");
        }

        private static string GenerateRandomString(int length) => new string(Enumerable.Repeat<string>("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", length).Select<string, char>((Func<string, char>)(s => s[Main.random.Next(s.Length)])).ToArray<char>());

        private DialogResult ShowMessageBox(string message, MessageBoxButtons buttons = MessageBoxButtons.OK, MessageBoxIcon icon = MessageBoxIcon.Information)
        {
            return XtraMessageBox.Show(message, "Naitve Piff Tools", buttons, icon);
        }

        private bool UpdateGtaPid()
        {
            foreach (Process process in Process.GetProcesses())
            {
                if (process.ProcessName == "GTA5")
                {
                    if (gta_pid == process.Id)
                    {
                        return false;
                    }

                    gta_pid = process.Id;
                    return true;
                }
            }
            int num = gta_pid != 0 ? 1 : 0;
            gta_pid = 0;
            return num != 0;
        }

        private bool CheckForUpdate(bool recheck)
        {
            EnsureStandBinDirExists();

            Task<string> stringAsync = new HttpClient().GetStringAsync("https://stand.gg/versions.txt");

            DirectoryInfo directoryInfo = new DirectoryInfo("C:\\Native Piff Tools\\Stand\\Bin\\");

            string str = "";

            try
            {
                stringAsync.Wait();
                str = stringAsync.Result;
            }
            catch (Exception)
            {
                foreach (FileInfo file in directoryInfo.GetFiles())
                {
                    if (file.Name.StartsWith("Stand ") && file.Name.EndsWith(".dll"))
                    {
                        str = "1.8.3:" + file.Name.Substring(6, file.Name.Length - 6 - 4);
                    }
                }
            }

            if (str.Length == 0)
            {
                _ = (int)ShowMessageBox("Failed to get version information. Ensure you're connected to the internet and have no anti-virus program or firewall interfering.");

                if (recheck)
                {
                    return false;
                }

                Application.Exit();
            }
            versions = str.Split(':');

            if (recheck)
            {
                SaveSettings();
                listView1.Items.Clear();
            }

            if (!NPT.Properties.Settings.Default.Advanced)
            {
                UpdateAdvancedMode();
            }

            listView1.Items.Add("Stand " + versions[1]);

            if (NPT.Properties.Settings.Default.CustomDll != "")
            {
                string customDll = NPT.Properties.Settings.Default.CustomDll;
                char[] chArray = new char[1] { '|' };

                foreach (string text in customDll.Split(chArray))
                {
                    listView1.Items.Add(text);
                }
            }

            for (int index = 0; index < NPT.Properties.Settings.Default.InjectDll.Length; ++index)
            {
                if (NPT.Properties.Settings.Default.InjectDll.Substring(index, 1) == "1")
                {
                    listView1.Items[index].Checked = true;
                }
            }

            bool flag = false;

            stand_dll = "C:\\Native Piff Tools\\Stand\\Bin\\Stand " + versions[1] + ".dll";

            if (!File.Exists(stand_dll))
            {
                try
                {
                    foreach (FileSystemInfo file in directoryInfo.GetFiles())
                    {
                        file.Delete();
                    }

                    foreach (DirectoryInfo directory in directoryInfo.GetDirectories())
                    {
                        directory.Delete(true);
                    }
                }
                catch (Exception)
                {

                }

                DownloadStandDll();
                flag = true;
            }

            return flag;
        }

        private void SaveSettings()
        {
            Properties.Settings.Default.InjectDll = "";
            Properties.Settings.Default.CustomDll = "";
            Properties.Settings.Default.CurrentMenu = (int)comboBoxEdit1.SelectedIndex;
            Properties.Settings.Default.GameLauncher = (int)lookUpEdit1.EditValue;
            Properties.Settings.Default.Advanced = checkEdit1.Checked;
            Properties.Settings.Default.SaveOnClose = checkEdit3.Checked;
            Properties.Settings.Default.AutoInject = checkEdit4.Checked;
            Properties.Settings.Default.HideSensitiveInfo = checkEdit7.Checked;
            Properties.Settings.Default.AutoInjectDelaySeconds = (int)spinEdit1.Value;

            for (int index = 0; index < listView1.Items.Count; ++index)
            {
                Properties.Settings.Default.InjectDll += listView1.Items[index].Checked ? "1" : "0";
                if (index != 0)
                {
                    Properties.Settings settings = Properties.Settings.Default;
                    settings.CustomDll = settings.CustomDll + listView1.Items[index].Text + "|";
                }
            }
            if (Properties.Settings.Default.CustomDll != "")
            {
                Properties.Settings.Default.CustomDll = Properties.Settings.Default.CustomDll.Substring(0, Properties.Settings.Default.CustomDll.Length - 1);
            }

            Properties.Settings.Default.Save();
        }

        private void CustomDllDialog_FileOk(object sender, CancelEventArgs e) => AddDll(CustomDllDialog.FileName);

        private void AddDll(string path) => listView1.Items.Add(path);

        private unsafe void InjectDll()
        {
            bool flag = false;

            ProcessScanTimer.Stop();

            simpleButton15.Enabled = false;

            List<string> stringList = new List<string>();

            if (NPT.Properties.Settings.Default.Advanced)
            {
                for (int index = 0; index < listView1.Items.Count; ++index)
                {
                    if (listView1.Items[index].Checked)
                    {
                        stringList.Add(index == 0 ? stand_dll : listView1.Items[index].Text);
                    }
                }
            }
            else
            {
                stringList.Add(stand_dll);
            }

            if (stringList.Contains(stand_dll) && !File.Exists(stand_dll))
            {
                EnsureStandBinDirExists();

                if (!DownloadStandDll())
                {
                    stringList.Remove(stand_dll);
                }
            }

            int num1 = 0;

            IntPtr num2 = OpenProcess(1082U, 1, (uint)gta_pid);

            if (num2 == IntPtr.Zero)
            {
                XtraMessageBox.Show("Failed to get a hold of the game's process.", "Native Piff Tools");
            }
            else
            {
                IntPtr procAddress = GetProcAddress(GetModuleHandle("kernel32.dll"), "LoadLibraryW");

                if (procAddress == IntPtr.Zero)
                {
                    XtraMessageBox.Show("Failed to find LoadLibraryW.", "Native Piff Tools");
                }
                else
                {
                    string path = "C:\\Native Piff Tools\\Stand\\Bin\\Temp";

                    if (!Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }

                    try
                    {
                        foreach (string str1 in stringList)
                        {
                            if (!File.Exists(str1))
                            {
                                XtraMessageBox.Show("Couldn't inject " + str1 + " because the file doesn't exist.", "Native Piff Tools");
                            }
                            else
                            {
                                string str2 = path + "\\SL_" + GenerateRandomString(5) + ".dll";

                                File.Copy(str1, str2);

                                byte[] bytes = Encoding.Unicode.GetBytes(str2);

                                IntPtr num3 = VirtualAllocEx(num2, (IntPtr)(void*)null, (IntPtr)bytes.Length, 12288U, 64U);

                                if (num3 == IntPtr.Zero)
                                    XtraMessageBox.Show("Couldn't allocate the bytes to represent " + str1, "Native Piff Tools");
                                else if (WriteProcessMemory(num2, num3, bytes, (uint)bytes.Length, 0) == 0)
                                    XtraMessageBox.Show("Couldn't write " + str2 + " to allocated memory", "Native Piff Tools");
                                else if (CreateRemoteThread(num2, (IntPtr)(void*)null, IntPtr.Zero, procAddress, num3, 0U, (IntPtr)(void*)null) == IntPtr.Zero)
                                    XtraMessageBox.Show("Failed to create remote thread for " + str1, "Native Piff Tools");
                                else
                                    ++num1;
                            }
                        }
                    }
                    catch (IOException ex)
                    {
                        Activate();

                        flag = true;
                        _ = (int)ShowMessageBox("Your antivirus seems to be preventing injection.\nDisable your anti virus or add an exclusion and try again." + ex.Message, icon: MessageBoxIcon.Hand);
                    }
                }
                CloseHandle(num2);
            }

            if (num1 == 0)
            {
                if (!AnySuccessfulInjection && stringList.Count != 0 && !flag)
                {
                    _ = (int)ShowMessageBox("No DLL was injected. You may need to start Native Piff Tools as an administrator.");
                }

                EnableReInject();
            }
            else
            {
                AnySuccessfulInjection = true;
                ReInjectTimer.Start();
            }
        }

        private void ToggleInjectBtn(bool gameRunning)
        {
            simpleButton15.Enabled = gameRunning;
            simpleButton2.Enabled = gameRunning;
        }

        private void ProcessGtaPidUpdate(bool ProcCanAutoInject)
        {
            bool gameRunning = gta_pid != 0;

            ToggleInjectBtn(gameRunning);

            if (gameRunning)
            {
                if (checkEdit4.Checked & ProcCanAutoInject)
                {
                    if (Properties.Settings.Default.Advanced && spinEdit1.Value > 0M)
                    {
                        AutoInjectTimer.Interval = (int)spinEdit1.Value * 1000;
                        AutoInjectTimer.Start();
                    }
                    else
                    {
                        InjectDll();
                    }
                }
                else
                {

                }
            }
            else
            {
                if (!GameWasOpen)
                {
                    return;
                }

                GameWasOpen = false;
                CanAutoInject = false;
                GameClosedTimer.Start();
            }
        }

        private void EnableReInject()
        {
            simpleButton15.Enabled = true;
            simpleButton2.Enabled = true;
            ProcessScanTimer.Start();
        }

        private void EnsureStandBinDirExists()
        {
            if (!Directory.Exists("C:\\Native Piff Tools\\Stand"))
            {
                Directory.CreateDirectory("C:\\Native Piff Tools\\Stand");
            }

            if (Directory.Exists("C:\\Native Piff Tools\\Stand\\Bin"))
            {
                return;
            }

            Directory.CreateDirectory("C:\\Native Piff Tools\\Stand\\Bin");
        }

        private bool DownloadStandDll()
        {
            bool flag = true;

            Task task = Task.Run(() =>
            {
                WebClient webClient = new WebClient();
                webClient.DownloadFileCompleted += new AsyncCompletedEventHandler(OnDownloadComplete);

                object userToken = new object();
                lock (userToken)
                {
                    webClient.DownloadFileAsync(new Uri("https://stand.gg/Stand%20" + versions[1] + ".dll"), stand_dll + ".tmp", userToken);
                    Monitor.Wait(userToken);
                }
            });

            do
            {

            }
            while (!task.Wait(20));
            {
                File.Move(stand_dll + ".tmp", stand_dll);
            }

            if (new FileInfo(stand_dll).Length < 1024L)
            {
                File.Delete(stand_dll);

                int num = (int)ShowMessageBox("It looks like the DLL download has failed. Ensure you have no anti-virus program interfering.");

                flag = false;
            }

            return flag;
        }

        private void OnDownloadComplete(object sender, AsyncCompletedEventArgs e)
        {
            lock (e.UserState)
                Monitor.Pulse(e.UserState);
        }

        private void RemoveSelectedDll()
        {
            if (listView1.SelectedItems.Count == 1)
            {
                int selectedIndex = listView1.SelectedIndices[0];

                if (selectedIndex == 0)
                {
                    return;
                }

                listView1.Items.RemoveAt(selectedIndex);

                if (listView1.Items.Count > selectedIndex && listView1.Items[selectedIndex] != null)
                {
                    listView1.Items[selectedIndex].Selected = true;
                }
                else
                {
                    listView1.Items[selectedIndex - 1].Selected = true;
                    listView1.SelectedItems.Clear();
                }
            }
            else
            {
                for (int index = listView1.Items.Count - 1; index > 0; --index)
                {
                    if (listView1.Items[index].Selected)
                    {
                        listView1.Items.RemoveAt(index);
                        listView1.SelectedItems.Clear();
                    }
                }
            }
            listView1.SelectedItems.Clear();
        }

        private void FormLoadingBGWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            string publicIP;
            using (WebClient client = new WebClient())
            {
                publicIP = client.DownloadString("http://checkip.dyndns.org");
            }

            //extract the IP from the response string
            publicIP = publicIP.Replace("<html><head><title>Current IP Check</title></head><body>Current IP Address: ", "").Replace("</body></html>", "");

            labelControl32.Text = publicIP;

            if (NetworkInterface.GetIsNetworkAvailable())
            {
                labelControl14.Text = Environment.UserName;
                labelControl30.ForeColor = Color.Green;
                labelControl30.Text = "✔";
            }
            else
            {
                labelControl14.Text = Environment.UserName;
                labelControl30.ForeColor = Color.Green;
                labelControl30.Text = "✔";
            }

            TopMost = false;
        }

        private void ListView1_DragDrop(object sender, DragEventArgs e)
        {
            foreach (string path in (string[])e.Data.GetData(DataFormats.FileDrop))
            {
                AddDll(path);
            }
        }

        private void ListView1_DragOver(object sender, DragEventArgs e)
        {
            if (e.Data.GetDataPresent(DataFormats.FileDrop))
            {
                e.Effect = DragDropEffects.Copy;
            }
            else
            {
                e.Effect = DragDropEffects.None;
            }
        }

        private void ListView1_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode != Keys.Delete)
                return;
            RemoveSelectedDll();
        }

        private void UpdateAdvancedMode()
        {
            if (Properties.Settings.Default.Advanced)
            {
                labelControl8.Visible = true;
                groupControl2.Visible = true;
                groupControl4.Visible = true;
                groupControl9.Visible = true;
                checkEdit3.Visible = true;
                checkEdit4.Visible = true;
                checkEdit7.Visible = true;
                spinEdit1.Visible = true;
            }
            else
            {
                labelControl8.Visible = false;
                groupControl2.Visible = false;
                groupControl4.Visible = false;
                groupControl9.Visible = false;
                checkEdit3.Visible = false;
                checkEdit4.Visible = false;
                checkEdit7.Visible = false;
                spinEdit1.Visible = false;
            }
        }

        void RunLoader()
        {
            FormLoadingBGWorker.RunWorkerAsync();
        }

        private void CheckEdit1_CheckedChanged(object sender, EventArgs e)
        {
            if (checkEdit1.Checked == true)
            {
                labelControl10.Visible = false;
                Properties.Settings.Default.Advanced = true;
                UpdateAdvancedMode();
                return;
            }
            else if (!checkEdit1.Checked)
            {
                labelControl10.Visible = true;
                Properties.Settings.Default.Advanced = false;
                UpdateAdvancedMode();
                return;
            }
        }

        private void CheckEdit2_CheckedChanged(object sender, EventArgs e)
        {
            if (checkEdit2.Checked == true)
            {
                SpoofGuid();
            }
            else
            {
                checkEdit2.Checked = false;
            }
        }

        private void CheckEdit4_CheckedChanged(object sender, EventArgs e)
        {
            if (checkEdit4.Checked || !AutoInjectTimer.Enabled)
            {
                return;
            }
            AutoInjectTimer.Stop();
            XtraMessageBox.Show("You may inject now.", "Native Piff Tools");

        }

        private void CheckEdit5_CheckedChanged(object sender, EventArgs e)
        {
            if (checkEdit5.Checked == true)
            {
                SpoofHwID();
            }
            else
            {
                checkEdit5.Checked = false;
            }
        }

        private void CheckEdit7_CheckedChanged(object sender, EventArgs e)
        {
            if (checkEdit7.Checked == true)
            {
                labelControl32.Visible = false;
            }
            else if (checkEdit7.Checked == false)
            {
                labelControl32.Visible = true;
            }
        }

        private void CheckEdit8_CheckedChanged(object sender, EventArgs e)
        {
            if (checkEdit8.Checked == true)
            {
                SpoofComputerName();
            }
            else
            {
                checkEdit8.Checked = false;
            }
        }

        private string GetIPAddress(string hostname)
        {
            IPHostEntry host = Dns.GetHostEntry(hostname);
            return host.AddressList[0].ToString();
        }

        private class GeoLocation
        {
            public string Query { get; set; }
            public string Country { get; set; }
            public string RegionName { get; set; }
            public string City { get; set; }
            public float Lat { get; set; }
            public float Lon { get; set; }
            public string Timezone { get; set; }
            public string Isp { get; set; }
            public string Org { get; set; }
            public string Ast { get; set; }
            public string Status { get; set; }
        }


        #endregion

    }
}
