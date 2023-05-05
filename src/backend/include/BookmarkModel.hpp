/****************************************************************************
 * Copyright (c) 2022 Andrey Sikorin, Ivan Grigorik                         *
 *                                                                          *
 * This program is free software: you can redistribute it and/or modify     *
 * it under the terms of the GNU General Public License as published by     *
 * the Free Software Foundation, version 3.                                 *
 *                                                                          *
 * This program is distributed in the hope that it will be useful, but      *
 * WITHOUT ANY WARRANTY; without even the implied warranty of               *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU         *
 * General Public License for more details.                                 *
 *                                                                          *
 * You should have received a copy of the GNU General Public License        *
 * along with this program. If not, see <http://www.gnu.org/licenses/>.     *
 ****************************************************************************/

#pragma once

#include <QJsonObject>
#include <QObject>

class BookmarkModel final : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)

public:
    explicit BookmarkModel(QObject* parent = nullptr);
    explicit BookmarkModel(QString name, QString url, QObject* parent = nullptr);

    [[nodiscard]] QString name() const;
    void setName(const QString& name);

    [[nodiscard]] QString url() const;
    void setUrl(const QString& url);

    [[nodiscard]] bool read(const QJsonObject& json);
    void write(QJsonObject& json) const;

signals:
    void nameChanged();
    void urlChanged();

private:
    QString m_name;
    QString m_url;
};
