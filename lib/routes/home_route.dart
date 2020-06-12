import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../stores/magic_home_store.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<MagicHomeStore>(context);
    final random = Random();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Banjo House'),
      ),
      body: Center(
        child: Observer(
          builder: (_) {
            return Column(
              children: [
                RaisedButton(
                  child: const Text('Connect!'),
                  onPressed: store.device == null ? store.connect : null,
                ),
                const SizedBox(height: 20.0),
                RaisedButton(
                  child: const Text('Send!'),
                  onPressed: store.device != null
                      ? () => store.setColor(
                            random.nextInt(255),
                            random.nextInt(255),
                            random.nextInt(255),
                          )
                      : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
