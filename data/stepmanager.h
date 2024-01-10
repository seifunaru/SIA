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

public slots:
    void initModInstall();  // Sets the step to 1 to prevent a double-emit signal bug caused by the QML file manager present in Qt 6.6.0.
    void setStep( QString currentStep );

    void doNextStep();
    void doBackStep();

    int getStepToParse();   // returns MOD_STEP_X
    void checkCurrentModules();
};

#endif // STEPMANAGER_H
