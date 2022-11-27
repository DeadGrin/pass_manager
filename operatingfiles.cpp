#include "operatingfiles.h"
#include "qaesencryption.h"
#include <QDir>
#include <QDebug>
#include <string>

OperatingFiles::OperatingFiles()
{
}



const QString &OperatingFiles::key() const
{
    return m_key;
}

bool OperatingFiles::readToVector()
{
    QFile file(QDir::currentPath() + "/passwords/" + currentFileName);
    if(!file.open(QIODevice::ReadOnly))
    {
       return 0;
    }
    QString TEMP = file.readAll();
    file.close();
    if(TEMP.size()<1) return 0;

    passwordsDecoded.clear();
    QString divider = " -- ";
    QString word = "";
    QVector<QString> smallVec(0);
    for(int i =0; i<TEMP.size(); i++)
    {
        if(TEMP[i] == divider[0])
        {
            if(TEMP[i+1] == divider[1] && i+1<TEMP.size())
            {
                if(TEMP[i+2] == divider[2] && i+2<TEMP.size())
                {
                    if(TEMP[i+3] == divider[3] && i+3<TEMP.size())
                    {
                        smallVec.append(word);
                        word.clear();
                        i+=3;
                    }
                }
            }
            else {
                word.append(TEMP[i]);
            }

        }
        else if(TEMP[i] == '\r')
        {
            if(TEMP[i+1] == '\n'&& i+1<TEMP.size())
            {
                smallVec.append(word);
                passwordsDecoded.append(smallVec);
                word.clear();
                smallVec.clear();
                i+=1;
            }
        }
        else
        {
            word.append(TEMP[i]);
        }
    }
return 1;
}

QVector<QVector<QString>> OperatingFiles::getVector()
{
    return passwordsDecoded;
}


void OperatingFiles::logToHistory(QString action)
{
    QFile file(QDir::currentPath() + "/log/" + "LOG");
    file.open(QIODevice::WriteOnly | QIODevice::Append);

    QDateTime date = QDateTime::currentDateTime();
    QString formattedTime = date.toString("dd.MM.yyyy hh:mm:ss");
    QString lineDivider = "\r\n";
    QTextStream out(&file);
    out << action << " " << formattedTime;
    out << lineDivider;

    file.close();


}

void OperatingFiles::updateFile()
{
    QFile file(QDir::currentPath() + "/passwords/" + currentFileName);
    file.open(QIODevice::WriteOnly);
    file.resize(0);
    QTextStream out(&file);
    QString divider = " -- ";
    QString lineDivider = "\r\n";
    for(int i(0); i<passwordsDecoded.size(); i++)
    {
        for(int j(0); j<passwordsDecoded[i].size(); j++)
        {
            out << passwordsDecoded[i][j];
            if(j!=passwordsDecoded[i].size()-1)
            {
                out << divider;
            }
        }
        out << lineDivider;
    }
    file.close();
}



//void OperatingFiles::readFile_Fillbytearray()
//{
//QFile file(QDir::currentPath() + "/passwords/" + currentFileName);
//if(!file.open(QIODevice::ReadOnly))
//{
//    qDebug() << currentFileName << "Is not open";
//    return;
//}
//file.close();
//}

//void OperatingFiles::_QVectorToQByteArrayForEncode()
//{
//    decodedFileByte.clear();
//    QDataStream stream(&decodedFileByte, QIODevice::WriteOnly);
//    stream << passwordsDecoded;
//}


//void OperatingFiles::encodeFileByte()
//{
//    QByteArray KEY = m_key.toUtf8();
//    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
//    encodedFileByte = encryption.encode(decodedFileByte, KEY);
//}

//void OperatingFiles::decodeFileByte()
//{
//    if(encodedFileByte.size() == 0) return;
//    QByteArray KEY = m_key.toUtf8();
//    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB);
//    decodedFileByte = encryption.encode(encodedFileByte, KEY);
//}
//
//void OperatingFiles::writeEncodedFile()
//{
//    QFile file(QDir::currentPath() + "/passwords/" + currentFileName);
//    if(!file.open(QIODevice::WriteOnly))
//    {
//        qDebug() << currentFileName << "Is not open";
//        return;
//    }
//    file.resize(0);
//    file.write(encodedFileByte);
//    fil*/e.close();
//}

void OperatingFiles::setKey(const QString &newKey)
{
    if (m_key == newKey)
        return;
    m_key = newKey;
    emit keyChanged();
}
bool OperatingFiles::verifyKey()
{

    SHA256 SHA256key;
    SHA256key.update(m_key.toStdString());
    uint8_t * digest = SHA256key.digest();
    std::string keySHA256STR = SHA256key.toString(digest);
    keySHA256 = QString::fromStdString(keySHA256STR);
    delete[] digest;

    QFile file(QDir::currentPath() + "/KEYSHA256.txt");
    if (!file.open(QIODevice::ReadOnly))
    {
        return false;
    }
    QString shaFromFile = file.readLine();
    file.close();

    shaFromFile.remove("\r\n");


    if(shaFromFile == keySHA256)
    {
        getFilesWithPasswords();
        return true;
    }
    else{
        return false;
    }
}

QStringList OperatingFiles::getFileList()
{
    return fileList;
}

void OperatingFiles::setCurrentFileName(QString newFileName)
{
newFileName.remove(QChar('"'));
this->currentFileName = newFileName;
passwordsDecoded.clear();
}

QString OperatingFiles::getCurrentFileName()
{
    return currentFileName;
}

bool OperatingFiles::addNewFile(QString newFileName)
{
    if(fileList.contains(newFileName)) return false;
    QFile file(QDir::currentPath() + "/passwords/" + newFileName);
    file.open(QIODevice::WriteOnly);
    file.close();
    getFilesWithPasswords();
    logToHistory("File created: " + newFileName);
    return true;
}

void OperatingFiles::addNewPasswordToVector(QString newS, QString newL, QString newP)
{
    if(newL == "" && newP == "") return;
    QVector<QString> temp;
    temp.append(newS);
    temp.append(newL);
    temp.append(newP);
    passwordsDecoded.append(temp);
    updateFile();
    logToHistory("Added password: " + temp[0] + " " + temp[1] + " " + temp[2]);
}

QStringList OperatingFiles::getLOG()
{
    QStringList temp;
    QString lineDivider = "\r\n";
    QFile file(QDir::currentPath() + "/log/" + "LOG");
    file.open(QIODevice::ReadOnly);
    QString ALL = file.readAll();
    file.close();
    for(int i(0); i<=ALL.count(lineDivider); i++)
    {
        temp.append(ALL.section(lineDivider,i,i));
    }
    return temp;
}



QStringList OperatingFiles::getFilesWithPasswords()
{
    QDir passwordsDir(QDir::currentPath() + "/passwords");
    fileList = passwordsDir.entryList(QStringList(), QDir::Files, QDir::Name);
    return fileList;
}

