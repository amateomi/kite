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
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QQmlContext>
#include <QQmlEngine>

#include "BookmarkModel.hpp"

BookmarkManager::BookmarkManager(QQmlApplicationEngine& qmlEngine, QObject* parent)
    : QObject { parent }
    , m_qmlEngine { qmlEngine }
{
    auto* context = m_qmlEngine.rootContext();
    context->setContextProperty("bookmarkListModel", QVariant::fromValue(m_bookmarks));
    context->setContextProperty("bookmarkManager", this);

    if (QFile bookmarkFile { bookmarkFilepath }; bookmarkFile.exists()) {
        if (!bookmarkFile.open(QIODevice::ReadOnly)) {
            qWarning() << "Failed to open " << bookmarkFilepath << " file to load bookmarks" << Qt::endl;
            throw std::runtime_error { "Failed to open " + std::string { bookmarkFilepath } };
        }
        if (const auto json = QJsonDocument::fromJson(bookmarkFile.readAll()).object(); !load(json)) {
            qWarning() << "Failed to parse " << bookmarkFilepath << " file to load bookmarks" << Qt::endl;
            throw std::runtime_error { "Failed to parse " + std::string { bookmarkFilepath } };
        }
    }
}

BookmarkManager::~BookmarkManager()
{
    QFile bookmarkFile { bookmarkFilepath };
    if (!bookmarkFile.open(QIODevice::WriteOnly)) {
        qWarning() << "Failed to open " << bookmarkFile.fileName() << " file to save bookmarks" << Qt::endl;
        return;
    }
    QJsonObject json;
    save(json);
    bookmarkFile.write(QJsonDocument(json).toJson());
}

void BookmarkManager::addBookmark(const QString& name, const QString& url)
{
    qDebug() << "addBookmark: "
             << "name: " << name << " url: " << url;
    if (!name.isEmpty()) {
        m_bookmarks.append(new BookmarkModel { name, url });
        m_qmlEngine.rootContext()->setContextProperty("bookmarkListModel", QVariant::fromValue(m_bookmarks));
    }
}

bool BookmarkManager::load(const QJsonObject& json)
{
    if (json.contains("bookmarks") and json["bookmarks"].isArray()) {
        auto bookmarks = json["bookmarks"].toArray();
        m_bookmarks.reserve(bookmarks.size());
        for (const auto item : bookmarks) {
            BookmarkModel model;
            if (!model.read(item.toObject())) {
                return false;
            }
            addBookmark(model.name(), model.url());
        }
    }
    return true;
}

void BookmarkManager::save(QJsonObject& json) const
{
    QJsonArray bookmarks;
    for (const auto item : m_bookmarks) {
        QJsonObject modelObject;
        qobject_cast<const BookmarkModel*>(item)->write(modelObject);
        bookmarks.append(modelObject);
    }
    json["bookmarks"] = bookmarks;
}
