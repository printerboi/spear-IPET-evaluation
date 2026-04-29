#include <cstring>
#include "micropather.h"

#include <cmath>
#include <cstdint>
#include <iostream>
#include <vector>

// Simple 2D grid graph for MicroPather
class GridGraph : public micropather::Graph {
public:
    GridGraph(int width, int height)
        : gridWidth(width), gridHeight(height), grid(width * height, 0) {}

    int index(int x, int y) const {
        return y * gridWidth + x;
    }

    void *node(int x, int y) {
        return reinterpret_cast<void *>(static_cast<intptr_t>(index(x, y)));
    }

    void nodeToXY(void *nodePtr, int &x, int &y) const {
        int indexValue = static_cast<int>(reinterpret_cast<intptr_t>(nodePtr));
        x = indexValue % gridWidth;
        y = indexValue / gridWidth;
    }

    // Mark a cell as blocked
    void setBlocked(int x, int y) {
        grid[index(x, y)] = 1;
    }

    float LeastCostEstimate(void *start, void *end) override {
        int startX, startY, endX, endY;
        nodeToXY(start, startX, startY);
        nodeToXY(end, endX, endY);

        // Manhattan distance heuristic
        return static_cast<float>(std::abs(startX - endX) + std::abs(startY - endY));
    }

    void AdjacentCost(void *nodePtr, micropather::MPVector<micropather::StateCost> *neighbors) override {
        int x, y;
        nodeToXY(nodePtr, x, y);

        const int directions[4][2] = {
            {1, 0}, {-1, 0}, {0, 1}, {0, -1}
        };

        for (int directionIndex = 0; directionIndex < 4; ++directionIndex) {
            int neighborX = x + directions[directionIndex][0];
            int neighborY = y + directions[directionIndex][1];

            if (neighborX < 0 || neighborY < 0 || neighborX >= gridWidth || neighborY >= gridHeight) {
                continue;
            }

            if (grid[index(neighborX, neighborY)] == 1) {
                continue; // blocked
            }

            micropather::StateCost stateCost;
            stateCost.state = node(neighborX, neighborY);
            stateCost.cost = 1.0f;

            neighbors->push_back(stateCost);
        }
    }

    void PrintStateInfo(void *nodePtr) override {
        int x, y;
        nodeToXY(nodePtr, x, y);
        std::cout << "(" << x << "," << y << ")";
    }

private:
    int gridWidth;
    int gridHeight;
    std::vector<int> grid;
};

int main() {
    GridGraph graph(10, 10);

    // Add a simple obstacle
    graph.setBlocked(4, 4);
    graph.setBlocked(4, 5);
    graph.setBlocked(4, 6);

    micropather::MicroPather pather(&graph);

    void *start = graph.node(0, 0);
    void *goal = graph.node(9, 9);

    micropather::MPVector<void *> path;
    float totalCost = 0.0f;

    int result = pather.Solve(start, goal, &path, &totalCost);

    if (result == micropather::MicroPather::SOLVED) {
        std::cout << "Path found. Cost: " << totalCost << "\n";
        for (int pathIndex = 0; pathIndex < path.size(); ++pathIndex) {
            graph.PrintStateInfo(path[pathIndex]);
            std::cout << " ";
        }
        std::cout << "\n";
    } else {
        std::cout << "No path found\n";
    }

    return 0;
}