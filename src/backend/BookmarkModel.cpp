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

#include "BookmarkModel.hpp"

BookmarkModel::BookmarkModel(QObject* parent)
    : QObject { parent }
{
}

BookmarkModel::BookmarkModel(QString name, QString url, QObject* parent)
    : QObject { parent }
    , m_name { std::move(name) }
    , m_url { std::move(url) }
{
}

QString BookmarkModel::name() const { return m_name; }

void BookmarkModel::setName(const QString& name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

QString BookmarkModel::url() const { return m_url; }

void BookmarkModel::setUrl(const QString& url)
{
    if (m_url != url) {
        m_url = url;
        emit urlChanged();
    }
}

bool BookmarkModel::read(const QJsonObject& json)
{
    if (json.contains("name") and json["name"].isString()) {
        m_name = json["name"].toString();
    } else {
        return false;
    }
    if (json.contains("url") and json["url"].isString()) {
        m_url = json["url"].toString();
    } else {
        return false;
    }
    return true;
}

void BookmarkModel::write(QJsonObject& json) const
{
    json["name"] = m_name;
    json["url"] = m_url;
}
