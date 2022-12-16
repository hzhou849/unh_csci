# CMakeList.txt : CMake project for BarGraph_CM, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.8)

project ("BarGraph_CM")

# Add source to this project's executable.
add_executable (BarGraph_CM "BarGraph_CM.cpp"  "item.hpp"  "row.hpp" "row.cpp" "graph.hpp" "tools.hpp" "tools.cpp" "graph.cpp")

# TODO: Add tests and install targets if needed.
