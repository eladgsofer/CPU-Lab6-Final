using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;
using System.IO;

namespace TerminalPC
{
    public partial class Home : Form
    {
        public static SerialPort port;
        Boolean firstConnection = true;
        public static Parity parityTemp;
        public static StopBits stopbitsTemp;
        public static string comTemp;
        public static int baudTemp;
        
        public Home()
        {
            InitializeComponent();
            comboBoxBaud.SelectedIndex = 1;
            comboBoxCOM.SelectedIndex = 0;
            comboBoxParity.SelectedIndex = 0;
            comboBoxSTPBIT.SelectedIndex = 0;
            
        }

        private void ComboBoxCOM_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        // Connect + update parameters
        private void ButtonConnect_Click(object sender, EventArgs e)
        {
            
            if (firstConnection) // For first connection there are default params
            {
                port = new SerialPort(comboBoxCOM.SelectedItem.ToString(),
                                     int.Parse(comboBoxBaud.SelectedItem.ToString()),
                                     (Parity)comboBoxParity.SelectedIndex,
                                     8,
                                     StopBits.One);
                firstConnection = false;
            }


            try
            {
                if (!port.IsOpen)
                {
                    port.Open();
                }


                MessageBox.Show("Connected");

            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }


        //Open chat mode window
        private void ButtonChat_Click(object sender, EventArgs e)
        {
            FormChat fc = new FormChat();
            fc.ShowDialog();

        }

        ////Open file transfer window
        private void ButtonFile_Click(object sender, EventArgs e)
        {
            FormFileTransfer ft = new FormFileTransfer();
            ft.ShowDialog();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void buttonFile_Paint(object sender, PaintEventArgs e)
        {

        }

        private void Home_Load(object sender, EventArgs e)
        {

        }
    }   
}
