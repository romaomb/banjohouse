import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../stores/magic_home_store.dart';

class ConnectionPanel extends StatelessWidget {
  const ConnectionPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<MagicHomeStore>(context);
    final random = Random();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Observer(
            builder: (_) {
              return Column(
                children: [
                  RaisedButton(
                    child: const Text('Search!'),
                    onPressed:
                        store.connectedDevice == null ? store.scan : null,
                  ),
                  const SizedBox(height: 20.0),
                  RaisedButton(
                    child: const Text('Send!'),
                    onPressed: store.connectedDevice != null
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
        Expanded(
          child: Observer(
            builder: (_) {
              return ListView.separated(
                itemCount: store.devicesFound.length,
                shrinkWrap: true,
                separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                itemBuilder: (_, index) {
                  final device = store.devicesFound[index];
                  return InkWell(
                    onTap: () => store.connectTo(device),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(device.toString()),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
