using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AlterCalculator
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            Settings1.Default.Location = this.Location;
            Settings1.Default.Save();
        }
       

        private void Form1_Load(object sender, EventArgs e)
        {
            if (Settings1.Default.Location != null)
            {
                this.Location = Settings1.Default.Location;
            }
        }
    }
}
