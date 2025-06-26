import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:whispertales/core/styles/customs_color.dart';
import 'package:whispertales/core/styles/styles.dart';
import 'package:whispertales/features/home/view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    const HomeScreen(),
    Center(
        child: Text(
      "History Screen",
      style: AppTextStyles.font20GoogleFontEWhite,
    )),
    Center(
        child: Text(
      "Settings Screen",
      style: AppTextStyles.font20GoogleFontEWhite,
    )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home, size: 30),
            label: "Home",
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.history, size: 30),
            label: "History",
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.settings, size: 30),
            label: "Settings",
          ),
        ],
        color: CustomsColros.lightPurple,
        buttonBackgroundColor: Colors.white,
        backgroundColor: CustomsColros.primaryColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: _pages[_page],
    );
  }
}
