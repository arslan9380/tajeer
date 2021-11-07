import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function onIndexChange;

  BottomNavBar({this.selectedIndex, this.onIndexChange});

  final List<IconData> _bottomBarIcons = [
    Icons.home_outlined,
    Icons.chat_outlined,
    Icons.favorite_border,
    Icons.person_outline,
  ];
  final List<String> _iconsName = ["Home", "Chat", "Wishlist", "Profile"];

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
        itemCount: _bottomBarIcons.length,
        backgroundColor: Theme.of(context).primaryColor,
        tabBuilder: (int index, bool isActive) {
          final color =
              isActive ? Theme.of(context).primaryColorDark : Colors.white;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _bottomBarIcons[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: AutoSizeText(
                  _iconsName[index],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  presetFontSizes: [14, 8],
                  style: TextStyle(color: color),
                ),
              )
            ],
          );
        },
        activeIndex: selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: onIndexChange);
  }
}
