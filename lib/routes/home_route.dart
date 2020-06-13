import 'package:flutter/material.dart';

import '../l10n/localization.dart';
import '../widgets/color_picker.dart';
import '../widgets/connection_panel.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Localization.appName),
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
