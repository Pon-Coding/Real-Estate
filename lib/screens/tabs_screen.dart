import 'package:blue_real_estate/constants/constants.dart';
import 'package:blue_real_estate/helpers/fonts/grial_icons_font.dart';
import 'package:blue_real_estate/helpers/fonts/text_style_theme.dart';
import 'package:flutter/material.dart';

import '../helpers/localization/language_localization.dart';
import '../widgets/tab_navigator.dart';

enum TabItem { home, inbox, team, menu }

class TabsScreen extends StatefulWidget {
  static const routeName = "/tabs_screen";
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = TabItem.home.index;
  TabItem _currentPage = TabItem.home;

  final Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.inbox: GlobalKey<NavigatorState>(),
    TabItem.team: GlobalKey<NavigatorState>(),
    TabItem.menu: GlobalKey<NavigatorState>(),
  };

  void _onItemTapped(int index) {
    if (index == _currentPage.index) {
      _navigatorKeys[TabItem.values[index]]!
          .currentState!
          .popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
        _currentPage = TabItem.values[index];
      });
    }
    // _navigatorKeys[TabItem.values[index]]!
    //     .currentState!
    //     .popUntil((route) => route.isFirst);
    // setState(() {
    //   _selectedIndex = index;
    //   _currentPage = TabItem.values[index];
    // });
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }

  Widget _buildBody(TabItem tabItem) {
    return TabNavigator(
      navigatorKey: _navigatorKeys[tabItem]!,
      tabItem: tabItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();

        if (isFirstRouteInCurrentTab) {
          if (_currentPage != TabItem.home) {
            _onItemTapped(TabItem.home.index);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body:
            // In below section is to create 4 stacks. To be able to push without losing BottomNavigationBar.
            // If we don't build different stack, it'll lose BottomNavigationBar because it push on the same stack.
            // Becareful: If want to push back to root, we need to set rootNavigator:true.
            //            e.g. Navigator.of(context, rootNavigator: true)
            //     Stack(
            //   children: [
            //     _buildOffstageNavigator(TabItem.home),
            //     _buildOffstageNavigator(TabItem.inbox),
            //     _buildOffstageNavigator(TabItem.team),
            //     _buildOffstageNavigator(TabItem.menu),
            //   ],
            // ),
            _buildBody(_currentPage),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Text(
                  GrialIconsFont.home,
                  style: TextStyleTheme().headline3(
                    fontFamily: Constants.fontGrialLine,
                    textColor: _selectedIndex == 0
                        ? ColorConstants.primaryColor
                        : Colors.grey[600],
                  ),
                ),
                label: getTranslated(context, LanguageJSONConst.tabHome)),
            BottomNavigationBarItem(
                icon: Text(
                  GrialIconsFont.inbox,
                  style: TextStyleTheme().headline3(
                    fontFamily: Constants.fontGrialLine,
                    textColor: _selectedIndex == 1
                        ? ColorConstants.primaryColor
                        : Colors.grey[600],
                  ),
                ),
                label: getTranslated(context, LanguageJSONConst.tabInbox)),
            BottomNavigationBarItem(
                icon: Text(
                  GrialIconsFont.users,
                  style: TextStyleTheme().headline3(
                    fontFamily: Constants.fontGrialLine,
                    textColor: _selectedIndex == 2
                        ? ColorConstants.primaryColor
                        : Colors.grey[600],
                  ),
                ),
                label: getTranslated(context, LanguageJSONConst.tabTeam)),
            BottomNavigationBarItem(
                icon: Text(
                  GrialIconsFont.menu,
                  style: TextStyleTheme().headline3(
                    fontFamily: Constants.fontGrialLine,
                    textColor: _selectedIndex == 3
                        ? ColorConstants.primaryColor
                        : Colors.grey[600],
                  ),
                ),
                label: getTranslated(context, LanguageJSONConst.tabMenu)),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: ColorConstants.primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
