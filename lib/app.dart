import 'package:flutter/material.dart';

import 'res/routes.dart';
import 'routes/home_route.dart';

class BanjoHouseApp extends StatelessWidget {
  const BanjoHouseApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banjo House',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (_) => const HomeRoute(),
      },
    );
  }
}
