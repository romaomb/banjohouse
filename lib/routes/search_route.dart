import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../l10n/localization.dart';
import '../models/magic_home.dart';
import '../resources/images.dart';
import '../stores/magic_home_store.dart';

class SearchRoute extends StatefulWidget {
  const SearchRoute({Key key}) : super(key: key);

  @override
  _SearchRouteState createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  MagicHomeStore store;

  @override
  void initState() {
    super.initState();
    store = Provider.of<MagicHomeStore>(context, listen: false);
    store.scan();
  }

  @override
  Widget build(BuildContext context) {
    final separator = const SizedBox(height: 10.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Localization.selectDevice),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) => store.devicesFound.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemCount: store.devicesFound.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => separator,
                  itemBuilder: (_, index) {
                    final device = store.devicesFound[index];
                    return ListTile(
                      onTap: () => _connectAndNavigateBack(device),
                      title: Text(device.model),
                      leading: Image.asset(Images.magicHome, height: 55.0),
                      subtitle: Text(device.internetAddress.address),
                    );
                  }),
        ),
      ),
    );
  }

  void _connectAndNavigateBack(MagicHome device) {
    store.connectTo(device);
    Navigator.pop(context);
  }
}
