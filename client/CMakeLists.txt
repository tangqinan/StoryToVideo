cmake_minimum_required(VERSION 3.16)
project(storytovideo LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 COMPONENTS Quick REQUIRED)

qt_standard_project_setup()

qt_add_executable(${PROJECT_NAME}
    src/main.cpp
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE Qt6::Quick
)

qt_add_qml_module(${PROJECT_NAME}
    URI StoryToVideo
    VERSION 1.0
    QML_FILES
        qml/Main.qml
)

install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
