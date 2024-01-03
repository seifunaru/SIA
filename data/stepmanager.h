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

public slots:
    void setStep(QString currentStep);

    void doNextStep();
    void doBackStep();

    int getStepToParse();   // returns MOD_STEP_X
};

#endif // STEPMANAGER_H
