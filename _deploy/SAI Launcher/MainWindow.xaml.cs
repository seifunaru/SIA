using System.Threading.Tasks;
using System.Windows;
using System.IO;
using System.Reflection;
using System.Diagnostics;

namespace SAI_Launcher
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            initInstaller();
        }

        public async Task initInstaller()
        {
            await Task.Delay(1000);
            // INITIALIZE TEMP FOLDER
            string tempdir = System.IO.Path.GetTempPath();
            tempdir += "/SIA-Launcher";
            if (Directory.Exists(tempdir)) { Directory.Delete(tempdir, true); Directory.CreateDirectory(tempdir); }
            else { Directory.CreateDirectory(tempdir); }

            // EXTRACT RESOURCE TO TEMP
            string destzip = tempdir + "/SIA.zip";
            var embzip = "SAI_Launcher.res.release.zip";
            WriteResourceToFile(embzip, destzip);

            // UNZIP
            string appdir = tempdir + "/SIA_AppContent";
            System.IO.Compression.ZipFile.ExtractToDirectory(destzip, appdir);

            // RUN APP
            string exedir = tempdir + "/SIA_AppContent/release/SIA.exe";
            Process.Start(exedir);

            // CLOSE LAUNCHER
            System.Environment.Exit(0);
        }

        public void WriteResourceToFile(string resourceName, string fileName)
        {
            using (var resource = Assembly.GetExecutingAssembly().GetManifestResourceStream(resourceName))
            {
                using (var file = new FileStream(fileName, FileMode.Create, FileAccess.Write))
                {
                    resource.CopyTo(file);
                }
            }
        }
    }
}
