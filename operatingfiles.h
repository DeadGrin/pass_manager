#ifndef OPERATINGFILES_H
#define OPERATINGFILES_H
#include "qaesencryption.h"
#include <QObject>
#include <QFile>
#include "sha256.h"

class OperatingFiles : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString key READ key WRITE setKey NOTIFY keyChanged)
public:
    OperatingFiles();
    QStringList getFilesWithPasswords();
    const QString &key() const;
    void updateFile();



    void logToHistory(QString action);
 //   void readFile_Fillbytearray();
 //   void _QVectorToQByteArrayForEncode();
 //   void fillQVectorwithDecodedData();
 //   void encodeFileByte();
  //  void decodeFileByte();
  //  void writeEncodedFile();

signals:
    void keyChanged();
public slots:
    bool readToVector();
    void setKey(const QString &newKey);
    bool verifyKey();
    QStringList getFileList();
    void setCurrentFileName(QString newFileName);
    QString getCurrentFileName();
    bool addNewFile(QString newFileName);
    void addNewPasswordToVector(QString newS, QString newL, QString newP);

    QVector<QVector<QString>> getVector();

    QStringList getLOG();

private:

    QStringList fileList;
    QString currentFileName;
    QString m_key = NULL;
    QString keySHA256;
    QByteArray decodedFileByte;
    //send 2d array to update func in tableModel class
    //tableModel.update(2d array) will make "append" to table
    //then tableModel will display table in qml

    //tableModel class should have back-connection
    //for possibility to add new row
    //OR
    //qml will call public slot function to add new password
    //which will append new password into 2d array, and then
    //call tableModel.update(2d array)

    //to edit existing password:
    //qml will call function "edit" and send indexes and new
    //password -> 2d array will be edited, and then called
    //tableModel.update(2d array)

    QByteArray encodedFileByte;
    QVector<QVector<QString>> passwordsDecoded= {"",""};


};
#endif // OPERATINGFILES_H
