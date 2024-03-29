#include "stepmanager.h"

#include <QObject>
#include <QVector>
#include <QString>
#include <QDebug>
#include <QFile>
#include <QSettings>
#include <QResource>
#include <QDesktopServices>
#include <QUrl>

// This vector of strings tracks which options have been chosen on all steps.
QVector <QString> selectedOptions;
QString installDir1;
QString installDir2;
QString modFile0;
QString modFile1;
QString modFile2;
bool is_whole_kit_and_caboodle = false;

StepManager::StepManager(QObject *parent) : QObject(parent)
{

}



// ####################################################################################
// HOTFIX : Should be removed on future updates
// ####################################################################################

// Context:
// Qt 6.6.0 has a bug where some slower processes such as a QML FileManager.onAccepted
// can emit doubled signals, causing unintended behaviors on the application.
// The bug has been bypassed by ALWAYS setting the step to stepCount to 1 when the file
// manager emits a signal. So even if it gets doubled, the stepCount will remain 1.

// I think this mod has been fixed on v 6.6.1, which is the build I'm using on Linux,
// but I'll keep this change even there for cross-platform consistency.

// This will be addressed as soon as I update the project to a more up to date Qt build.

void StepManager::initModInstall()
{
    stepCount = 1;
    emit stepUpdateRequest ( stepCount );
}

// ####################################################################################




//This function sets a chosen step by the user on selectedOptions vector.
void StepManager::setStep(QString currentStep)
{
    if (!selectedOptions.contains(currentStep)) {
        selectedOptions.append(currentStep);
        qDebug() << "Element [" + currentStep + "] was successfully attached.";
    } else {
        qDebug() << "Element [" + currentStep + "] is already selected.";
    }
}




void StepManager::doNextStep()
{
    stepCount++;
    emit stepUpdateRequest ( stepCount );
}




// This function deletes the last chosen step, in case the user wants to undo a selected step.
void StepManager::doBackStep()
{
    if (!selectedOptions.isEmpty()) {
        selectedOptions.removeLast();
        StepManager::stepCount--;
        qDebug() << "Last step was removed.";
        qDebug() << "TOTAL OF CURRENT STEPS: " + QString::number(stepCount);
    } else {
        qDebug() << "Could not delete last step, step list is empty.";
    }

    qDebug() << "Selected options after removal:";
    for (const QString &currentOption : selectedOptions) {
        qDebug() << "[" + currentOption + "] , ";
    }

    if (stepCount > 0)
    {
        stepCount--;
        emit stepUpdateRequest ( stepCount );
    }
}

// This is the getter for the current step number.
int StepManager::getStepToParse()
{
    return stepCount;
}

void StepManager::checkCurrentModules()
{
    emit emittedCurrentModules ( selectedOptions.first() );
    qDebug() << "DONE, EMITTED.";
}


void StepManager::setInstallDir(QString dir1, QString dir2, QString mod0, QString mod1, QString mod2)
{
    installDir1 = dir1;
    installDir2 = dir2;
    modFile0 = mod0;
    modFile1 = mod1;
    modFile2 = mod2;
}


void StepManager::initModUnpack ()
{

    QString allSteps = selectedOptions.join(" / ");
    qDebug() << "this is what will be installed ------------------------------------------------z " + allSteps;
    int stepsToInstall = allSteps.toInt(); // sets everything up for installation. This function needs work in order to function properly in other mods. I'm rushing, no time.


    // HOTFIX 3.0.1
    // Warns about all features being set for fine-tune to downgrade Textures, to prevent VRAM crashes.
    if ((stepsToInstall == 0111) || (stepsToInstall == 1111))
    {
        is_whole_kit_and_caboodle = true;
    }



    // Check if the user wants to install the FPS or RT Hotfix.
    if (stepsToInstall > 99)
    {
        //If the user wants FPS or RT Hotfixes, clean Engine.ini.
        QString engineInstallDir = installDir1 + "Engine.ini";
        QFile file(engineInstallDir);


        // Try to open Engine.ini
        qDebug() << "SE VA A ABRIR: " << engineInstallDir;
        if (!file.open(QIODevice::ReadWrite | QIODevice::Text)) {
            qDebug() << "No se pudo abrir el archivo:" << file.errorString();
            return;
        }

        // Sets up lines
        QTextStream in(&file);
        QStringList lines;


        // Read all file lines until last instance of "Paths="
        while (!in.atEnd()) {
            QString line = in.readLine();
            if (line.startsWith("Paths=") || line.startsWith("[Core.System]")) {
                lines.append(line);
            }
        }


        // Clean the file after the last appearance of "Paths="
        file.resize(0);
        QTextStream out(&file);
        for (const QString& line : lines) {
            out << line << Qt::endl;
        }


        // Adds mod intro.
        out << modFile0;


        // If the user wants FPS Hotfix:
        if (stepsToInstall > 999)
        {
            stepsToInstall -= 1000;
            out << modFile1;
            emit installationProgressAt20p();
        }

        // If the user wants RT Hotfix
        if (stepsToInstall > 99)
        {
            stepsToInstall -= 100;
            out << modFile2;
            emit installationProgressAt40p();
        }

    }


    // Check if user wants Fine-Tune
    if (stepsToInstall > 9)
    {
        // Hotfix, needs cleaning: make sure the file permissions are right.
        QFile file (installDir1 + "/GameUserSettings.ini");
        file.setPermissions(file.permissions() | QFileDevice::WriteOwner | QFileDevice::WriteUser | QFileDevice::WriteGroup | QFileDevice::WriteOther);
        file.close();

        // Setup a QSettings for graphics ini
        QSettings graphicsSettings(installDir1 + "/GameUserSettings.ini", QSettings::IniFormat);

        // Sets the ini group to tweak
        graphicsSettings.beginGroup("ScalabilityGroups");

        // Fine tune goes here. Idealy it should be set by using JSON data, but I don't have time to
        // implement that right now, so here is a dirty implemen tation to get the job done.

        // HOTFIX 3.0.1
        //If user has too many VRAM heavy features enabled, sets Fine-Tune-Agr
        if (is_whole_kit_and_caboodle)
        {
            graphicsSettings.setValue("sg.ViewDistanceQuality","2");
            graphicsSettings.setValue("sg.AntiAliasingQuality","3");
            graphicsSettings.setValue("sg.ShadowQuality","2");
            graphicsSettings.setValue("sg.PostProcessQuality","1");
            graphicsSettings.setValue("sg.TextureQuality","2");
            graphicsSettings.setValue("sg.EffectsQuality","2");
            graphicsSettings.setValue("sg.FoliageQuality","2");
            graphicsSettings.setValue("sg.ShadingQuality","3");
            graphicsSettings.setValue("sg.VolumetricsQuality","2");
            graphicsSettings.setValue("sg.SkyQuality","1");
            graphicsSettings.setValue("sg.PopulationQuality","2");
            graphicsSettings.setValue("sg.RaytracingQuality","3");
        }

        else // If not too many VRAM heavy features have been enabled, install Fine-Tune-Lite

        {
            graphicsSettings.setValue("sg.ViewDistanceQuality","2");
            graphicsSettings.setValue("sg.AntiAliasingQuality","3");
            graphicsSettings.setValue("sg.ShadowQuality","2");
            graphicsSettings.setValue("sg.PostProcessQuality","1");
            graphicsSettings.setValue("sg.TextureQuality","1");
            graphicsSettings.setValue("sg.EffectsQuality","2");
            graphicsSettings.setValue("sg.FoliageQuality","2");
            graphicsSettings.setValue("sg.ShadingQuality","3");
            graphicsSettings.setValue("sg.VolumetricsQuality","2");
            graphicsSettings.setValue("sg.SkyQuality","1");
            graphicsSettings.setValue("sg.PopulationQuality","2");
            graphicsSettings.setValue("sg.RaytracingQuality","3");
        }

        graphicsSettings.sync();
        stepsToInstall -= 10;

        emit installationProgressAt60p();
    }


    // Check if user wants FSR3 FrameGen
    if (stepsToInstall > 0)
    {
        qDebug() << "INSTAL DIR 2 is: " << installDir2 + "dlssg_to_fsr3_amd_is_better.dll";

        QFile file (installDir2 + "dlssg_to_fsr3_amd_is_better.dll");

        if (!file.exists())
        {
            QFile::copy(":/modFile/data/modFiles/dlssg_to_fsr3_amd_is_better.dll", installDir2 + "dlssg_to_fsr3_amd_is_better.dll");
        }

        file.setFileName(installDir2 + "version.dll");
        if (!file.exists())
        {
            QFile fileTest1 (installDir2 + "nvngx.dll");
            QFile fileTest2 (installDir2 + "winhttp.dll");
            QFile fileTest3 (installDir2 + "dbghelp.dll");

            if (!fileTest1.exists() && !fileTest2.exists() && !fileTest3.exists())
            {
                QFile::copy(":/modFile/data/modFiles/version.dll" , installDir2 + "version.dll");
            }
        }

        emit installationProgressAt80p();

    }

    // Sets permissions over qrc generated files so game settings don't get blocked.
    QFile file (installDir2 + "dlssg_to_fsr3_amd_is_better.dll");
    file.setPermissions(file.permissions() | QFileDevice::WriteOwner | QFileDevice::WriteUser | QFileDevice::WriteGroup | QFileDevice::WriteOther);
    file.setFileName(installDir2 + "version.dll");
    file.setPermissions(file.permissions() | QFileDevice::WriteOwner | QFileDevice::WriteUser | QFileDevice::WriteGroup | QFileDevice::WriteOther);

    emit installationProgressAt100p();

}


void StepManager::initModRemove ()
{
    // REMOVE Engine.ini
    QFile file (installDir1 + "Engine.ini");
    if (file.exists())
    {
        if (file.remove()) {
            qDebug() << "Engine removed successfully.";
        } else {
            emit fileRemoveError(file.errorString());
        }
    }

    // REMOVE FSR3
    //dlssg_to_fsr3_amd_is_better
    file.setFileName(installDir2 + "dlssg_to_fsr3_amd_is_better.dll");
    file.setPermissions(file.permissions() | QFileDevice::WriteOwner | QFileDevice::WriteUser | QFileDevice::WriteGroup | QFileDevice::WriteOther);
    if (file.exists())
    {
        if (file.remove()) {
            qDebug() << "dlssg_to_fsr3_amd_is_better removed successfully.";
        } else {
            emit fileRemoveError(file.errorString());
        }
    }

    // version
    file.setFileName(installDir2 + "version.dll");
    file.setPermissions(file.permissions() | QFileDevice::WriteOwner | QFileDevice::WriteUser | QFileDevice::WriteGroup | QFileDevice::WriteOther);
    if (file.exists())
    {
        if (file.remove()) {
            qDebug() << "version removed successfully.";

        } else {
            emit fileRemoveError(file.errorString());
        }
    }
    emit uninstallFinished();
}


void StepManager::process_donate_button()
{
    QDesktopServices::openUrl(QUrl("www.patreon.com/seifu", QUrl::TolerantMode));
}

void StepManager::process_exit_button()
{
    emit terminate_app_request();
}
