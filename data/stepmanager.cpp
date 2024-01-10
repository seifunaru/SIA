#include "stepmanager.h"

#include <QObject>
#include <QVector>
#include <QString>
#include <QDebug>
#include <QFile>
#include <QStandardPaths>

// This vector of strings tracks which options have been chosen on all steps.
QVector <QString> selectedOptions;

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





