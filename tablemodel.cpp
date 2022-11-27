#include "tablemodel.h"


TableModel::TableModel(QObject *parent)
    : QAbstractTableModel{parent}
{
    QVector<QString> mini;
    mini.append("Choose File");
    mini.append(" ");
    mini.append(" ");
    table.append(mini);

}

int TableModel::rowCount(const QModelIndex &) const
{
    return table.size();
}

int TableModel::columnCount(const QModelIndex &) const
{
    return table.at(0).size();
}

QVariant TableModel::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case Qt::DisplayRole:
        return table.at(index.row()).at(index.column());
    default:
        break;
    }

    return QVariant();
}

QHash<int, QByteArray> TableModel::roleNames() const
{
    return { {Qt::DisplayRole, "display"} };
}

void TableModel::setTable(QVector<QVector<QString>> value)
  {
      beginResetModel();
      table = value;
      endResetModel();
  }
void TableModel::askToAddPassTable()
  {
      beginResetModel();
      QVector<QString> ask;
      ask.append("Please ");
      ask.append("add new ");
      ask.append("password");
      table.clear();
      table.append(ask);
      endResetModel();
  }

