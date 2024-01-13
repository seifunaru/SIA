#ifndef CUSTOMMODFUNCTIONS_H
#define CUSTOMMODFUNCTIONS_H

#include <QObject>
#include <QString>

class CustomModFunctions : public QObject
{
    Q_OBJECT
public:
    explicit CustomModFunctions(QObject *parent = nullptr);

signals:
    void request_init_modInstallation();
    bool mod_install_dir_1_isOk ( bool state );
    bool mod_install_dir_2_isOk ( bool state );
    bool mod_uninstall_dir_1_isOk ( bool state );
    bool mod_uninstall_dir_2_isOk ( bool state );
    QString emittedInstallDirs (QString dir1, QString dir2);

public slots:
    void checkModInstallDir1 ( QString userInput );
    void checkModInstallDir2 ( QString userInput );
    void checkModUninstallDir1 ( QString userInput );
    void checkModUninstallDir2 ( QString userInput );
    void getInstallDirs();
};

#endif // CUSTOMMODFUNCTIONS_H
