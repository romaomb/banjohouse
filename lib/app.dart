import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repositories/led/magic_home_repository.dart';
import 'resources/routes.dart';
import 'routes/home_route.dart';
import 'services/magic_home_service.dart';
import 'stores/magic_home_store.dart';

class BanjoHouseApp extends StatelessWidget {
  const BanjoHouseApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MagicHomeStore>(
          create: (_) => MagicHomeStore(
            magicHomeRepository: MagicHomeRepository(MagicHomeService()),
          ),
          dispose: (_, store) => store.dispose(),
        ),
      ],
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
