import 'package:flutter/material.dart';
import 'package:proximax/widgets/deviceTile.dart';

class DeviceList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [DeviceTile()],
    );
  }
}
