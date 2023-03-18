#include "BookmarkManager.hpp"

#include <QDebug>
#include <QQmlEngine>

BookmarkManager::BookmarkManager(QObject *parent)
    : QObject{parent} {
    qmlRegisterType<BookmarkManager>("backend.logic", 1, 0, "BookmarkManager");
}

void BookmarkManager::addBookmark(const QString& url)
{
    qDebug() << url << Qt::endl;
}
