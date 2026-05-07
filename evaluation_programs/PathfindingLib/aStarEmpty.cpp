#include "PathfindingLib.hpp"
#include <iostream>

using namespace PathfindingLib;

int main() {
    // Create a grid of 100x100 tiles
    Pathfinding_Grid<int> grid(100, 100);

    /**
     * Add no obstacles here.
     */

    // Define start and end tile
    auto start = std::make_tuple(0, 0);
    auto end = std::make_tuple(99, 99);

    // Call the A* algo on the grid
    auto path = findPathAStar(grid, start, end);

    // Print the path
    if (!path.empty()) {
        std::cout << "Path found with " << path.size() << " steps:\n";
        for (const auto& [x, y] : path) {
            std::cout << "(" << x << "," << y << ") ";
        }
        std::cout << "\n";
    } else {
        std::cout << "No path found!\n";
    }

    return 0;
}