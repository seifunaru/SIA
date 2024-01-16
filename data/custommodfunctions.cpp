#include "custommodfunctions.h"

#include <QCoreApplication>
#include <QStandardPaths>
#include <QFile>
#include <QDebug>
#include <QDir>

QString mod_install_dir_1;
QString mod_install_dir_2;
QString selectedOptions;

CustomModFunctions::CustomModFunctions(QObject *parent) : QObject(parent)
{

}



// SLOTS:

// This functions checks if Ascendio's engine.ini exists in its default path for the installation process.
void CustomModFunctions::checkModInstallDir1( QString userInput )
{

    // If user input is set as AUTO, the app will try to find standard paths.
    if (userInput == "AUTO")
    {
        qDebug() << "Trying AUTO path";
        // Assigns expected engine.ini path.
        QString localAppDataPath = QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation);
        localAppDataPath.append("/Hogwarts Legacy/Saved/Config/WindowsNoEditor/Engine.ini");

        // Assigns engine path to a qfile.
        QFile file(localAppDataPath);

        if (file.exists())
        {
            // Hotfix, needs cleaning: make sure the file permissions are right.
            file.setPermissions(file.permissions() | QFileDevice::WriteOwner | QFileDevice::WriteUser | QFileDevice::WriteGroup | QFileDevice::WriteOther);

            mod_install_dir_1 = localAppDataPath;
            mod_install_dir_1.chop(10);

            qDebug() << "INSTALLATION DIR 1 AUTHENTICATED. DIR 1 = " + mod_install_dir_1;
            emit mod_install_dir_1_isOk(true);

        } else {

            // HOTFIX 3.0.1
            // If file doesn't exist, try with EGS standard path.

            localAppDataPath = QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation);
            localAppDataPath.append("/HogwartsLegacy/Saved/Config/WindowsNoEditor/Engine.ini");

            file.setFileName(localAppDataPath);

            if (file.exists()) {
                // Hotfix, needs cleaning: make sure the file permissions are right.
                file.setPermissions(file.permissions() | QFileDevice::WriteOwner | QFileDevice::WriteUser | QFileDevice::WriteGroup | QFileDevice::WriteOther);

                mod_install_dir_1 = localAppDataPath;
                mod_install_dir_1.chop(10);

                qDebug() << "INSTALLATION DIR 1 AUTHENTICATED. DIR 1 = " + mod_install_dir_1;
                emit mod_install_dir_1_isOk(true);
            } else {
                qDebug() << "INSTALLATION DIR 1 IS NOT VALID. REQUESTING NEW PATH";
                emit mod_install_dir_1_isOk(false);
            }
        }
    }

    // If it's not set as AUTO, it means the user has provided a custom path, so let's check if it's valid.
    else
    {
        userInput = userInput.remove(0, 8);
        qDebug() << "Using custom user input path = " + userInput;
        QFile file(userInput);

        if (userInput.contains("Engine.ini") && file.exists())
        {
            // Hotfix, needs cleaning: make sure the file permissions are right.
            file.setPermissions(file.permissions() | QFileDevice::WriteOwner | QFileDevice::WriteUser | QFileDevice::WriteGroup | QFileDevice::WriteOther);

            mod_install_dir_1 = userInput;
            mod_install_dir_1.chop(10);

            qDebug() << "------------------------------------------------------------------ CONTAIN DETECTED";
            emit mod_install_dir_1_isOk(true);
        } else {
            qDebug() << "------------------------------------------------------------------ CONTAIN FAIL";
            emit mod_install_dir_1_isOk(false);
        }
    }

}

// This function tries to find HogwartsLegacy.exe on some "standard" locations before asking for the path to it.

void CustomModFunctions::checkModInstallDir2( QString userInput )
{
    if (userInput == "AUTO")
    {
        // Sets a QFile to check different usual paths.
        QFile file ("C:/Program Files (x86)/Steam/steamapps/common/Hogwarts Legacy/Phoenix/Binaries/Win64/HogwartsLegacy.exe");

        // Try 1
        if (file.exists()) {
            qDebug() << "It's a miracle! File exists: " + file.fileName();
        } else {
            file.setFileName("D:/SteamLibrary/steamapps/common/Hogwarts Legacy/Phoenix/Binaries/Win64/HogwartsLegacy.exe");
        }

        // Try 2
        if (file.exists()) {
            qDebug() << "It's a miracle! File exists: " + file.fileName();
        } else {
            file.setFileName("E:/SteamLibrary/steamapps/common/Hogwarts Legacy/Phoenix/Binaries/Win64/HogwartsLegacy.exe");
        }

        // Try 3
        if (file.exists()) {
            qDebug() << "It's a miracle! File exists: " + file.fileName();
        } else {
            file.setFileName("F:/SteamLibrary/steamapps/common/Hogwarts Legacy/Phoenix/Binaries/Win64/HogwartsLegacy.exe");
        }

        // Couldn't find the file!
        // Ask the user for the game exe path.
        emit mod_install_dir_2_isOk(false);
    }

    else

    {
        // Removes the "file:///" which is returned.
        userInput = userInput.remove(0, 8);

        // Assigns the user provided path to a QFile
        QFile file (userInput);

        // Check if the game exe was chosen, and check if it exists as a file in the system.
        if (userInput.contains("HogwartsLegacy.exe") && file.exists())
        {
            // Check if it was the CORRECT Hogwarts Legacy Exe
            if (userInput.contains("Phoenix/Binaries/Win64"))
            {
                mod_install_dir_2 = userInput;
                mod_install_dir_2.chop(18);
                qDebug() << "-|||||||||||||||||||||||||||||||||||- DETECTED THE CORRECT HogwartsLegacy.exe - FILE LOCATION: " + mod_install_dir_2;
                emit mod_install_dir_2_isOk(true);
            } else {

                // Check if the user chose the HL source exe instead.
                userInput.chop(18);
                userInput += "Phoenix/Binaries/Win64/HogwartsLegacy.exe";

                file.setFileName(userInput);
                if(file.exists())
                {
                    mod_install_dir_2 = userInput;
                    mod_install_dir_2.chop(18);
                    qDebug() << "-|||||||||||||||||||||||||||||||||||- WAS INCORRECT; CORRECTED IT ; - FILE LOCATION: " + mod_install_dir_2;
                    emit mod_install_dir_2_isOk(true);
                } else {
                    qDebug() << "-||||||| COULDN'T FIND THE CORRECT PATH AT: " + userInput;
                    emit mod_install_dir_2_isOk(false);
                }
            }
        }

        else

        {
            qDebug() << "-||||||| COULDN'T FIND THE CORRECT PATH AT: " + userInput;
            emit mod_install_dir_2_isOk(false);
        }
    }

}


// This functions checks if Ascendio's engine.ini exists in its default path for uninstallation.
void CustomModFunctions::checkModUninstallDir1( QString userInput )
{

    // If user input is set as AUTO, the app will try to find standard paths.
    if (userInput == "AUTO")
    {
        qDebug() << "Trying AUTO path";
        // Assigns expected engine.ini path.
        QString localAppDataPath = QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation);
        localAppDataPath.append("/Hogwarts Legacy/Saved/Config/WindowsNoEditor/Engine.ini");

        // Assigns engine path to a qfile.
        QFile file(localAppDataPath);

        if (file.exists())
        {
            // Hotfix, needs cleaning: make sure the file permissions are right.
            file.setPermissions(file.permissions() | QFileDevice::WriteOwner | QFileDevice::WriteUser | QFileDevice::WriteGroup | QFileDevice::WriteOther);

            mod_install_dir_1 = localAppDataPath;
            mod_install_dir_1.chop(10);

            qDebug() << "INSTALLATION DIR 1 AUTHENTICATED. DIR 1 = " + mod_install_dir_1;
            emit mod_uninstall_dir_1_isOk(true);

        } else {

            // HOTFIX 3.0.1
            // If file doesn't exist, try with EGS standard path.

            localAppDataPath = QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation);
            localAppDataPath.append("/HogwartsLegacy/Saved/Config/WindowsNoEditor/Engine.ini");

            file.setFileName(localAppDataPath);

            if (file.exists()) {
                // Hotfix, needs cleaning: make sure the file permissions are right.
                file.setPermissions(file.permissions() | QFileDevice::WriteOwner | QFileDevice::WriteUser | QFileDevice::WriteGroup | QFileDevice::WriteOther);

                mod_install_dir_1 = localAppDataPath;
                mod_install_dir_1.chop(10);

                qDebug() << "INSTALLATION DIR 1 AUTHENTICATED. DIR 1 = " + mod_install_dir_1;
                emit mod_uninstall_dir_1_isOk(true);
            } else {
                qDebug() << "INSTALLATION DIR 1 IS NOT VALID. REQUESTING NEW PATH";
                emit mod_uninstall_dir_1_isOk(false);
            }
        }
    }
}

// This function tries to find HogwartsLegacy.exe on some "standard" locations before asking for the path to it.

void CustomModFunctions::checkModUninstallDir2( QString userInput )
{
    if (userInput == "AUTO")
    {
        // Sets a QFile to check different usual paths.
        QFile file ("C:/Program Files (x86)/Steam/steamapps/common/Hogwarts Legacy/Phoenix/Binaries/Win64/HogwartsLegacy.exe");

        // Try 1
        if (file.exists()) {
            qDebug() << "It's a miracle! File exists: " + file.fileName();
        } else {
            file.setFileName("D:/SteamLibrary/steamapps/common/Hogwarts Legacy/Phoenix/Binaries/Win64/HogwartsLegacy.exe");
        }

        // Try 2
        if (file.exists()) {
            qDebug() << "It's a miracle! File exists: " + file.fileName();
        } else {
            file.setFileName("E:/SteamLibrary/steamapps/common/Hogwarts Legacy/Phoenix/Binaries/Win64/HogwartsLegacy.exe");
        }

        // Try 3
        if (file.exists()) {
            qDebug() << "It's a miracle! File exists: " + file.fileName();
        } else {
            file.setFileName("F:/SteamLibrary/steamapps/common/Hogwarts Legacy/Phoenix/Binaries/Win64/HogwartsLegacy.exe");
        }

        // Couldn't find the file!
        // Ask the user for the game exe path.
        emit mod_uninstall_dir_2_isOk(false);
    }

    else

    {
        // Removes the "file:///" which is returned.
        userInput = userInput.remove(0, 8);

        // Assigns the user provided path to a QFile
        QFile file (userInput);

        // Check if the game exe was chosen, and check if it exists as a file in the system.
        if (userInput.contains("HogwartsLegacy.exe") && file.exists())
        {
            // Check if it was the CORRECT Hogwarts Legacy Exe
            if (userInput.contains("Phoenix/Binaries/Win64"))
            {
                mod_install_dir_2 = userInput;
                mod_install_dir_2.chop(18);
                qDebug() << "-|||||||||||||||||||||||||||||||||||- DETECTED THE CORRECT HogwartsLegacy.exe - FILE LOCATION: " + mod_install_dir_2;
                emit mod_uninstall_dir_2_isOk(true);
            } else {

                // Check if the user chose the HL source exe instead.
                userInput.chop(18);
                userInput += "Phoenix/Binaries/Win64/HogwartsLegacy.exe";

                file.setFileName(userInput);
                if(file.exists())
                {
                    mod_install_dir_2 = userInput;
                    mod_install_dir_2.chop(18);
                    qDebug() << "-|||||||||||||||||||||||||||||||||||- WAS INCORRECT; CORRECTED IT ; - FILE LOCATION: " + mod_install_dir_2;
                    emit mod_uninstall_dir_2_isOk(true);
                } else {
                    qDebug() << "-||||||| COULDN'T FIND THE CORRECT PATH AT: " + userInput;
                    emit mod_uninstall_dir_2_isOk(false);
                }
            }
        }

        else

        {
            qDebug() << "-||||||| COULDN'T FIND THE CORRECT PATH AT: " + userInput;
            emit mod_uninstall_dir_2_isOk(false);
        }
    }

}

void CustomModFunctions::getInstallDirs()
{
    emit emittedInstallDirs(mod_install_dir_1, mod_install_dir_2);
}
