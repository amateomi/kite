#pragma once

#include <QObject>
#include <QString>

class SearchBar : public QObject {
    Q_OBJECT

public:
    explicit SearchBar(QObject* parent = nullptr);

    Q_INVOKABLE void receiveNewUrl(QString&, QObject* webView);
};
