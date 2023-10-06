import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/sub_home_screen.dart';
import '../helpers/extensions/string_ext.dart';

// Hints:
//
// To Navigate Page:
//
// Opt 1:
// Navigator.of(context).push(MaterialPageRoute(
//   builder: (context) => const SubHomeScreen(),
// ));
//
// Opt 2:
// Navigator.of(context).pushNamed(SubHomeScreen.routeName);
//
// Becareful: If want to push back to root, we need to set rootNavigator:true.
//            e.g. Navigator.of(context, rootNavigator: true)
//

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
  }) : super(key: key);

  static Route<MaterialPageRoute>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return null;
      case HomeScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
      case SubHomeScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const SubHomeScreen(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  @override
  Widget build(BuildContext context) {
    String initRoute;
    switch (tabItem) {
      case TabItem.menu:
        initRoute = HomeScreen.routeName;
        break;
      case TabItem.home:
        initRoute = HomeScreen.routeName;
        break;
      case TabItem.inbox:
        initRoute = HomeScreen.routeName;
        break;
      case TabItem.team:
        initRoute = HomeScreen.routeName;
        break;
      default:
        initRoute = StringExtension.emptyString;
        break;
    }
    return Navigator(
      key: navigatorKey,
      initialRoute: initRoute,
      onGenerateRoute: generateRoute,
    );
  }
}
