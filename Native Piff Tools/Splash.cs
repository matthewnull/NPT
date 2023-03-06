using DevExpress.XtraEditors;
using System;
using System.Windows.Forms;

namespace NPT
{
    public partial class Splash : XtraForm
    {
#pragma warning disable IDE0044 // Add readonly modifier
#pragma warning disable IDE0052 // Remove unread private members
        private bool EulaHidden = false;
#pragma warning restore IDE0052 // Remove unread private members
#pragma warning restore IDE0044 // Add readonly modifier

        public Splash(bool hide)
        {
            InitializeComponent();

            /* Lets try this! */
            EulaHidden = hide;
            if (hide)
            {
                this.WindowState = FormWindowState.Minimized;
                this.ShowInTaskbar = false;
            }
            else if (!Settings.HasAcceptedEula())
            {
                // Display EULA
                using (Form f = new Eula())
                {
                    if (f.ShowDialog(this) != DialogResult.OK)
                    {
                        // Bail out if declined
                        Environment.Exit(0);
                        return;
                    }
                    else
                    {

                        // Save EULA acceptance
                        Settings.SaveAcceptedEula();

                        timer1.Enabled = true;
                        timer1.Start();
                    }
                }
            }

            timer1.Enabled = true;
            timer1.Start();
        }

        public static void ThreadProc()
        {
            Application.Run(new Main());
        }

        private void Timer1_Tick(object sender, EventArgs e)
        {
            progressBarControl1.Increment(10);

            if (progressBarControl1.Position == 100)
            {
                timer1.Stop();

                System.Threading.Thread ShowMain = new System.Threading.Thread(new System.Threading.ThreadStart(ThreadProc));
                ShowMain.Start();
                this.Close();

            }
        }

        private void Splash_Load(object sender, EventArgs e)
        {

        }
    }
}
