#include "stepmanager.h"

#include <QObject>
#include <QVector>
#include <QString>
#include <QDebug>

// This vector of strings tracks which options have been chosen on all steps.
QVector <QString> selectedOptions;

StepManager::StepManager(QObject *parent) : QObject(parent)
{

}




//This function sets a chosen step by the user on selectedOptions vector.
void StepManager::setStep(QString currentStep)
{
    if (!selectedOptions.contains(currentStep)) {
        selectedOptions.append(currentStep);
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
