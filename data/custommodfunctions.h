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
    bool mod_install_dir_1_isOk ( bool state );
    bool mod_install_dir_2_isOk ( bool state );

public slots:
    void checkModInstallDir1 ( QString userInput );
    void checkModInstallDir2 ( QString userInput );
};

#endif // CUSTOMMODFUNCTIONS_H
