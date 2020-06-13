import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../l10n/localization.dart';
import '../stores/magic_home_store.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<MagicHomeStore>(context);
    return Column(
      children: [
        Observer(builder: (_) {
          return Text(
            '${Localization.currentColor}: '
            '${store.currentColor?.toString() ?? ''}',
          );
        }),
      ],
    );
  }
}
