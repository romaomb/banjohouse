import 'package:flutter/material.dart';

import 'l10n/localization.dart';
import 'resources/routes.dart';
import 'routes/home_route.dart';
import 'routes/search_route.dart';

class BanjoHouseApp extends StatelessWidget {
  const BanjoHouseApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Localization.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (_) => const HomeRoute(),
        Routes.search: (_) => const SearchRoute(),
      },
    );
  }
}
