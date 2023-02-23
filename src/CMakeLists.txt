set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick WebEngineQuick REQUIRED)

qt_add_executable(kite
	main.cpp

	backend/Browser.cpp
)

target_include_directories(kite PRIVATE backend/include)

target_link_libraries(kite
	PRIVATE
	Qt6::Quick
	Qt6::WebEngineQuick
)

qt_add_qml_module(kite
    URI base
    VERSION 1.0
    QML_FILES
		main.qml
)