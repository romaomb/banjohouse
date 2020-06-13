import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'repositories/led/magic_home_repository.dart';
import 'services/magic_home_service.dart';
import 'stores/magic_home_store.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider<MagicHomeStore>(
            create: (_) => MagicHomeStore(
              magicHomeRepository: MagicHomeRepository(MagicHomeService()),
            ),
            dispose: (_, store) => store.dispose(),
          )
        ],
        child: const BanjoHouseApp(),
      ),
    );
