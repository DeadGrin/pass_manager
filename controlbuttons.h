#ifndef CONTROLBUTTONS_H
#define CONTROLBUTTONS_H

#include <QObject>

class ControlButtons : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool files READ files WRITE setfiles NOTIFY filesChanged)
    Q_PROPERTY(bool history READ history WRITE sethistory NOTIFY historyChanged)
    Q_PROPERTY(bool settings READ settings WRITE setsettings NOTIFY settingsChanged)

public:
    explicit ControlButtons(QObject *parent = nullptr);
    ControlButtons();
    bool files() const;



    bool history() const;


    bool settings() const;


public slots:
    void setfiles(bool newFiles);
    void setsettings(bool newSettings);
    void sethistory(bool newHistory);

signals:
    void filesChanged();

    void historyChanged();

    void settingsChanged();

private:
    bool m_files;

    bool m_history;
    bool m_settings;
};

#endif // CONTROLBUTTONS_H
