import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'resources/routes.dart';
import 'routes/home_route.dart';
import 'services/magic_home_service.dart';

class BanjoHouseApp extends StatelessWidget {
  const BanjoHouseApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MagicHomeService(),
      child: MaterialApp(
        title: 'Banjo House',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Routes.home,
        routes: {
          Routes.home: (_) => const HomeRoute(),
        },
      ),
    );
  }
}
