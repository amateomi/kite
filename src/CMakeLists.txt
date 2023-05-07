set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Core Gui WebEngineQuick REQUIRED)

qt_add_executable(kite
    main.cpp

    backend/include/Browser.hpp
    backend/include/SearchBarManager.hpp
    backend/include/BookmarkManager.hpp
    backend/include/BookmarkModel.hpp
  
    backend/Browser.cpp
    backend/SearchBarManager.cpp
    backend/BookmarkManager.cpp
    backend/BookmarkModel.cpp
)

target_include_directories(kite PRIVATE backend/include)

target_link_libraries(kite
	PRIVATE
    Qt6::Core
	Qt6::Gui
	Qt6::WebEngineQuick
)

qt_add_qml_module(kite
    URI base
    VERSION 1.0
    
    QML_FILES
        main.qml
        frontend/PageControlButton.qml
        frontend/BookmarkButton.qml
        frontend/BookmarkAddButton.qml
        frontend/SearchBar.qml
        frontend/PageContent.qml
        frontend/Tab.qml

    RESOURCES
        frontend/TabBarFunctions.js

        ../images/backIcon.svg
        ../images/forwardIcon.svg
        ../images/reloadIcon.svg
)
