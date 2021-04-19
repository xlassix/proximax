import 'package:flutter/material.dart';
import 'package:proximax/widgets/deviceTile.dart';

class DeviceList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListView(
        children: [DeviceTile(fullName: "Oki Ayobami",proximity: "73",)],
      ),
    );
  }
}
