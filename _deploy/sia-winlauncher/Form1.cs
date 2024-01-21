namespace sia_winlauncher
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

            // Undecorated Window
            FormBorderStyle = FormBorderStyle.None;

            // Spawn at screen center
            CenterToScreen();

            // Window Properties
            Width = 950;
            Height = 330;
            TransparencyKey = BackColor;    // Set BackColor as transparency key.
        }
    }
}


