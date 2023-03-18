#pragma once

#include <QObject>
#include <QString>

class BookmarkManager : public QObject {
    Q_OBJECT
public:
    explicit BookmarkManager(QObject* parent = nullptr);

    Q_INVOKABLE void addBookmark(const QString& url);
};
