import 'package:covid19app/presentation/screens/main/main_screen_controller.dart';
import 'package:covid19app/presentation/screens/main/pages/home_page.dart';
import 'package:covid19app/presentation/screens/main/pages/search_page.dart';
import 'package:covid19app/presentation/screens/main/pages/world_page.dart';
import 'package:covid19app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

/// References
/// Save Page state: https://stackoverflow.com/a/55512883
class MainScreen extends StatelessWidget {
  final List<Widget> _pages = [HomePage(), WorldPage(), SearchPage()];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(
      init: MainScreenController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Covid-19"),
            backgroundColor: Constants.backgroundColor,
          ),
          body: Container(
            color: Constants.foregroundColor,
            child: IndexedStack(
              children: _pages,
              index: _.selectedIndex,
            ),
          ),
          bottomNavigationBar: Container(
              child: _bottomNavigationBar(_.selectedIndex, _)),
        );
      }
    );
  }

  Widget _bottomNavigationBar(int selectedIndex, MainScreenController controller) => BottomNavigationBar(
        onTap: (int index) => controller.updateSelectedIndex(index),
        currentIndex: controller.selectedIndex,
        backgroundColor: Constants.backgroundColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        items: [
          BottomNavigationBarItem(
              icon: Icon(LineIcons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.globe), title: Text('World')),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.search), title: Text('Search')),
        ],
      );
}
