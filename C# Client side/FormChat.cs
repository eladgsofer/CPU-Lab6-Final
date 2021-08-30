using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
using System.Windows.Forms;

namespace TerminalPC
{
    public partial class FormChat : Form
    {
        string indata_rs= "";
        public FormChat()
        {
            InitializeComponent();
            Home.port.DataReceived += new SerialDataReceivedEventHandler(port_DataReceived);
            
        }

        private void TextBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
           

            if (e.KeyChar == (char)Keys.Enter)
            {
                
                try
                {
                    if (!Home.port.IsOpen)
                    {
                        Home.port.Open();
                    }

                    Home.port.Write(textBox1.Text);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.ToString());
                }


                textBox1.Text = "";
            } 
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        public void port_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string indata ="";
            SerialPort sp = (SerialPort)sender;
            System.Threading.Thread.Sleep(500);
                
            if (!Home.port.IsOpen)
            {
                Home.port.Open();
            }

            while (Home.port.BytesToRead > 0)
            {
                indata  += ((char)Home.port.ReadChar()).ToString();
            }

            MessageBox.Show(indata);
        }

        private void FormChat_Load(object sender, EventArgs e)
        {

        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
