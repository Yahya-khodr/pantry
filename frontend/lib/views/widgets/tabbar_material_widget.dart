import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';

class TabBarMaterialWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;

  const TabBarMaterialWidget({
    Key? key,
    required this.index,
    required this.onChangedTab,
  }) : super(key: key);

  @override
  State<TabBarMaterialWidget> createState() => _TabBarMaterialWidgetState();
}

class _TabBarMaterialWidgetState extends State<TabBarMaterialWidget> {
  @override
  Widget build(BuildContext context) {
    const placeholder = Opacity(
      opacity: 0,
      child: IconButton(onPressed: null, icon: Icon(Icons.no_cell)),
    );

    return BottomAppBar(
      notchMargin: 6,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(index: 0, icon: const Icon(Icons.home_rounded)),
          buildTabItem(index: 1, icon: const Icon(Icons.shopping_cart_rounded)),
          placeholder,
          buildTabItem(index: 2, icon: const Icon(Icons.grid_view_rounded)),
          buildTabItem(index: 3, icon: const Icon(Icons.person)),
        ],
      ),
    );
  }

  Widget buildTabItem({
    required int index,
    required Icon icon,
  }) {
    final isSelected = index == widget.index;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconTheme(
        data: IconThemeData(
          color: isSelected ? Palette.appBarColor : Palette.unselectedIconColor,
        ),
        child: IconButton(
          icon: icon,
          iconSize: 30,
          onPressed: () => widget.onChangedTab(index),
        ),
      ),
    );
  }
}
