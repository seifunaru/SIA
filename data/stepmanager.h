#ifndef STEPMANAGER_H
#define STEPMANAGER_H

#include <QObject>
#include <QString>

class StepManager : public QObject
{
    Q_OBJECT
public:
    explicit StepManager(QObject *parent = nullptr);
    int stepCount = 0;

signals:
    int stepUpdateRequest ( int stepCount );
    QString emittedCurrentModules ( QString modules );
    void allStepsReadyToInstall (QString allSteps); // signal used to parse all steps to install to the CMF.

    // ------- ProgressBar Signals -------
    void installationProgressAt20p();
    void installationProgressAt40p();
    void installationProgressAt60p();
    void installationProgressAt80p();
    void installationProgressAt100p();
    // These ones send to QML the installation progress made.

    // Uninstallation signals
    QString fileRemoveError (QString string);
    void uninstallFinished();



public slots:
    void initModInstall();  // Sets the step to 1 to prevent a double-emit signal bug caused by the QML file manager present in Qt 6.6.0.
    void setStep( QString currentStep );

    void doNextStep();
    void doBackStep();

    int getStepToParse();   // returns MOD_STEP_X
    void checkCurrentModules();

    void setInstallDir(QString dir1, QString dir2, QString mod0, QString mod1, QString mod2);
    void initModUnpack(); // starts mod installation
    void initModRemove(); // starts mod uninstallation

    void process_donate_button();
    void process_exit_button();
};

#endif // STEPMANAGER_H
