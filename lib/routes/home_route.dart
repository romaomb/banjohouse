import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/magic_home_service.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MagicHomeService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banjo House'),
      ),
      body: Center(
        child: RaisedButton(
          child: const Text('Press me!'),
          onPressed: () async {
            await service.scan();
            await service.send();
          },
        ),
      ),
    );
  }
}
