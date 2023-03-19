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

#include "BookmarkManager.hpp"

#include <QDebug>
#include <QQmlEngine>
#include <QQmlContext>

#include "BookmarkModel.hpp"

BookmarkManager::BookmarkManager(QQmlApplicationEngine& qmlEngine, QObject *parent)
    : QObject{parent}, m_qmlEngine{qmlEngine}
{
    auto* context = m_qmlEngine.rootContext();
    context->setContextProperty("bookmarkListModel", QVariant::fromValue(m_bookmarks));
    context->setContextProperty("bookmarkManager", this);
}

void BookmarkManager::addBookmark(const QString& name, const QString& url)
{
    qDebug() << "addBookmark: " << "name: " << name << " url: " << url;
    if (!name.isEmpty()) {
        m_bookmarks.append(new BookmarkModel{name, url});
        m_qmlEngine.rootContext()->setContextProperty("bookmarkListModel", QVariant::fromValue(m_bookmarks));
    }
}
