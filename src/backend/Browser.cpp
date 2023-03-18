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

#include <QtWebEngineQuick/qtwebenginequickglobal.h>

Browser::Browser(int argc, char* argv[])
{
    QtWebEngineQuick::initialize();
    m_core = std::make_unique<QGuiApplication>(argc, argv);
    m_qmlEngine = std::make_unique<QQmlApplicationEngine>();
    m_qmlEngine->load("qrc:/base/main.qml");
}

int Browser::run() { return QGuiApplication::exec(); }
