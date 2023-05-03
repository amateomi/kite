#pragma once

#include <QObject>
#include <QString>

class SearchBarManager : public QObject {
    Q_OBJECT

public:
    explicit SearchBarManager(QObject* parent = nullptr);

    Q_INVOKABLE void receiveNewUrl(const QString& url, QObject* webView);
};
