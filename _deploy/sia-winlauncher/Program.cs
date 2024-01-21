using sia_winlauncher.Properties;
using System.Diagnostics;
using System.IO.Compression;
using System.Runtime.CompilerServices;

namespace sia_winlauncher
{
    class ZipExtractor
    {
        public static void ExtractAndRun()
        {
            string tempFolder = Path.Combine(Path.GetTempPath(), "_sia");

            try
            {
                // Create _sia dir on tempFolder if it doesn't exist.
                if (!Directory.Exists(tempFolder))
                {
                    Directory.CreateDirectory(tempFolder);
                }
                else
                {
                    // if directory exists, remove it, then create it again.
                    Directory.Delete(tempFolder, true);
                    Directory.CreateDirectory(tempFolder);
                }

                // Extract ZIP content from resources to the generated temp folder.¡
                using (MemoryStream zipStream = new MemoryStream(Properties.Resources.release))
                {
                    using (ZipArchive archive = new ZipArchive(zipStream))
                    {
                        archive.ExtractToDirectory(tempFolder);
                    }
                }

                // Look for SIA exe
                string siaExe = tempFolder + "/release/SIA.exe";

                // Check if SIA exe exists.
                if (File.Exists(siaExe))
                {
                    // Run SIA.exe
                    Process.Start(siaExe);
                    Application.Exit();
                }
                else
                {
                    // ERROR
                    Console.WriteLine("No se encontró ningún archivo ejecutable en el ZIP.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
            }
        }
    }

    internal static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            ApplicationConfiguration.Initialize();

            // Run Extract and Run on a separate thread.
            Task.Run(() => ZipExtractor.ExtractAndRun());

            // Run main interface on main thread.
            Application.Run(new Form1());
        }
    }
}