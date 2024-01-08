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
    void setStep( QString currentStep );

    void doNextStep();
    void doBackStep();

    int getStepToParse();   // returns MOD_STEP_X
    void checkCurrentModules();
};

#endif // STEPMANAGER_H
