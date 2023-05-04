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

#include "Browser.hpp"

#include <QQmlContext>
#include <QtWebEngineQuick/qtwebenginequickglobal.h>

#include "SearchBarManager.hpp"

Browser::Browser(int argc, char* argv[])
{
    QtWebEngineQuick::initialize();

    m_core.reset(new QGuiApplication { argc, argv });
    m_qmlEngine.reset(new QQmlApplicationEngine);
    m_bookmarkManager.reset(new BookmarkManager { *m_qmlEngine });

    qmlRegisterType<SearchBarManager>("backend.logic", 1, 0, "SearchBarManager");

    m_qmlEngine->load("qrc:/base/main.qml");
}

int Browser::run() { return QGuiApplication::exec(); }
