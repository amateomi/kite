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

BookmarkModel::BookmarkModel(QObject *parent)
    : QObject{parent} {}

BookmarkModel::BookmarkModel(const QString &name, const QString &url, QObject *parent)
    : QObject{parent}, m_name{name}, m_url{url} {}

QString BookmarkModel::name() const
{
    return m_name;
}

void BookmarkModel::setName(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

QString BookmarkModel::url() const
{
    return m_url;
}

void BookmarkModel::setUrl(const QString &url)
{
    if (m_url != url) {
        m_url = url;
        emit urlChanged();
    }
}
