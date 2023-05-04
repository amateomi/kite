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

#include "SearchBarManager.hpp"

#include <QQmlEngine>
#include <QRegularExpression>

#include <algorithm>

SearchBarManager::SearchBarManager(QObject* parent)
    : QObject { parent }
{
}

void SearchBarManager::receiveNewUrl(const QString& url, QObject* webView) const
{
    qDebug() << "receiveNewUrl: " << url << Qt::endl;
    // Always refreshing, if contains https prefix
    static QRegularExpression httpsPattern { "^https://*", QRegularExpression::CaseInsensitiveOption };
    if (httpsPattern.match(url).hasMatch()) {
        QMetaObject::invokeMethod(webView, "reload");
        return;
    }

    // Check is url
    static QRegularExpression urlPattern { R"(^(?!-)[A-Za-z0-9-]+([\-\.]{1}[a-z0-9]+)*\.[A-Za-z]{2,6}$)",
        QRegularExpression::CaseInsensitiveOption };
    const auto match = urlPattern.match(url);
    std::string newUrl;

    if (match.hasMatch()) {
        newUrl = "https://" + url.toStdString() + "/";
    } else {
        newUrl = "https://www.google.com/search?q=" + url.toStdString();
        // Replace all spaces to get correct request
        std::replace(newUrl.begin(), newUrl.end(), ' ', '+');
    }

    webView->setProperty("url", QString::fromStdString(newUrl));
}
