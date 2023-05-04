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

#include <QObject>
#include <QObjectList>
#include <QQmlApplicationEngine>
#include <QString>

class BookmarkManager final : public QObject {
    Q_OBJECT

public:
    explicit BookmarkManager(QQmlApplicationEngine& qmlEngine, QObject* parent = nullptr);

    ~BookmarkManager() override;

    Q_INVOKABLE void addBookmark(const QString& name, const QString& url);

private:
    [[nodiscard]] bool load(const QJsonObject& json);
    void save(QJsonObject& json) const;

    static constexpr auto bookmarkFilepath = R"(C:\ProgramData\kite\bookmark.json)";

    QObjectList m_bookmarks {};
    QQmlApplicationEngine& m_qmlEngine;
};
