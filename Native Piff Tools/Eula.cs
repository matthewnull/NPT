using DevExpress.XtraEditors;
using System;
using System.Windows.Forms;

namespace NPT
{
    public partial class Eula : XtraForm
    {
        public Eula()
        {
            InitializeComponent();

            richEditControl1.ReadOnly = true;
            BringToFront();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            BringToFront();
        }

        private void CheckEdit1_CheckedChanged(object sender, EventArgs e)
        {
            simpleButton1.Enabled = checkEdit1.Checked;
        }

        private void SimpleButton2_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
