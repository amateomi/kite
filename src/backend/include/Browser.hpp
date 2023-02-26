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

#include <memory>

#include <QGuiApplication>
#include <QQmlApplicationEngine>

class Browser {
public:
    Browser(int argc, char* argv[]);

    [[nodiscard]] static int run();

private:
    std::unique_ptr<QGuiApplication> m_core{};
    std::unique_ptr<QQmlApplicationEngine> m_qmlEngine{};
};
