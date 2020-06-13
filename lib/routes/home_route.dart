import 'package:flutter/material.dart';

import '../widgets/color_picker.dart';
import '../widgets/connection_panel.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banjo House'),
      ),
      body: Column(
        children: const [
          Expanded(child: ConnectionPanel()),
          Expanded(child: ColorPicker()),
        ],
      ),
    );
  }
}
