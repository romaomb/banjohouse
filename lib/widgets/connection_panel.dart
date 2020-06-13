import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../l10n/localization.dart';
import '../models/magic_home.dart';
import '../resources/routes.dart';
import '../stores/magic_home_store.dart';

class ConnectionPanel extends StatelessWidget {
  const ConnectionPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<MagicHomeStore>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildInfoPanel(store)),
          Expanded(child: _buildCommands(context, store))
        ],
      ),
    );
  }

  Widget _buildInfoPanel(MagicHomeStore store) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(Localization.connectionStatus),
        const SizedBox(height: 8.0),
        Observer(
          builder: (_) => _buildInfo(
            store.connectedDevice,
            store.isOn,
          ),
        ),
      ],
    );
  }

  Widget _buildInfo(MagicHome device, bool isOn) {
    var status = '${Localization.status}: ';
    var power = '${Localization.power}: ';
    var model = '${Localization.model}: ';
    var ip = '${Localization.ip}: ';
    var mac = '${Localization.mac}: ';

    if (device == null) {
      status += Localization.disconnected;
    } else {
      status += Localization.connected;
      power += '${isOn ? Localization.on : Localization.off}';
      model += '${device.model}';
      ip += '${device.internetAddress.address}';
      mac += '${device.mac}';
    }

    final info = ObservableList.of([status, power, model, ip, mac]);

    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) => Text(info[index]),
        separatorBuilder: (_, __) => const SizedBox(height: 4.0),
        itemCount: info.length,
      ),
    );
  }

  Widget _buildCommands(BuildContext context, MagicHomeStore store) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Observer(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Localization.commands),
              const SizedBox(height: 8.0),
              RaisedButton(
                child: const Text(Localization.search),
                onPressed: store.connectedDevice == null
                    ? () => _navigateToSearch(context)
                    : null,
              ),
              RaisedButton(
                child: const Text(Localization.togglePower),
                onPressed:
                    store.connectedDevice != null ? store.togglePower : null,
              ),
              RaisedButton(
                child: const Text(Localization.setRandom),
                onPressed: store.connectedDevice != null
                    ? () => store.setRandomColor()
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }

  void _navigateToSearch(BuildContext context) => Navigator.pushNamed(
        context,
        Routes.search,
      );
}
