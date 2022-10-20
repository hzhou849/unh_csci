# CMakeList.txt : CMake project for w9_bar_graph, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.8)

project ("w9_bar_graph")

# Add source to this project's executable.
add_executable (w9_bar_graph "w9_bar_graph.cpp"  "item.hpp" "row.hpp")

# TODO: Add tests and install targets if needed.
