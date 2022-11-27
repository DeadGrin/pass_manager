#ifndef TABLEMODEL_H
#define TABLEMODEL_H
#include "operatingfiles.h"
#include <QObject>
#include <QAbstractTableModel>

class TableModel : public QAbstractTableModel
{
    Q_OBJECT

    QVector<QVector<QString>> table = {"",""};

public:
    explicit TableModel(QObject *parent = nullptr);
    TableModel(OperatingFiles obj, QObject *parent = nullptr);
    int rowCount(const QModelIndex & = QModelIndex()) const override;

    int columnCount(const QModelIndex & = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role) const override;

    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void setTable(QVector<QVector<QString>> value);

public slots:
    void askToAddPassTable();
signals:

};

#endif // TABLEMODEL_H
