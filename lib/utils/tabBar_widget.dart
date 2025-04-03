import 'package:flutter/material.dart';

class MyTabBarView extends StatefulWidget {
  final int index;
  final ValueChanged<int> changed;
  const MyTabBarView({Key? key, required this.index, required this.changed})
      : super(key: key);

  @override
  State<MyTabBarView> createState() => _MyTabBarViewState();
}

class _MyTabBarViewState extends State<MyTabBarView> {
  final space = Opacity(
    opacity: 0,
    child: Icon(Icons.no_cell_rounded),
  );
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4,
      color: Colors.red,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomTapBar(
            index: 0,
            icon: Icon(Icons.home),
          ),
          bottomTapBar(
            index: 1,
            icon: Icon(Icons.assured_workload_rounded),
          ),
          space,
          bottomTapBar(
            index: 2,
            icon: Icon(Icons.free_cancellation_rounded),
          ),
          bottomTapBar(
            index: 3,
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  Widget bottomTapBar({
    required int index,
    required Icon icon,
  }) {
    final isSelected = index == widget.index;
    return IconTheme(
      data: IconThemeData(color: isSelected ? Colors.white : Colors.black),
      child: IconButton(
          onPressed: () => widget.changed(index), icon: icon, iconSize: 30),
    );
  }
}
