from profilevisualizer.Visualizer import Visualizer


def main():
    vis = Visualizer('../../data/D_DUMMY/profile/cpu_stats.csv', True)
    vis.show()


if __name__ == "__main__":
    main()