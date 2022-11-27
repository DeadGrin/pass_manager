#include "controlbuttons.h"

ControlButtons::ControlButtons(QObject *parent)
{

}

ControlButtons::ControlButtons()
    : m_files(false)

{

}

bool ControlButtons::files() const
{
    return m_files;
}


void ControlButtons::setfiles(bool newFiles)
{
    if (m_files == newFiles)
        return;
    m_files = newFiles;
    emit filesChanged();
}




bool ControlButtons::history() const
{
    return m_history;
}

void ControlButtons::sethistory(bool newHistory)
{
    if (m_history == newHistory)
        return;
    m_history = newHistory;
    emit historyChanged();
}

bool ControlButtons::settings() const
{
    return m_settings;
}

void ControlButtons::setsettings(bool newSettings)
{
    if (m_settings == newSettings)
        return;
    m_settings = newSettings;
    emit settingsChanged();
}
