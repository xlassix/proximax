import 'package:flutter/material.dart';
import 'package:proximax/services/location.dart';
import 'package:proximax/widgets/deviceTile.dart';

class DeviceList extends StatefulWidget {
  final List<Location> locationList;
  DeviceList({Key key, @required this.locationList}) : super(key: key);

  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: widget.locationList.where((element) {
          return DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(element.time.microsecondsSinceEpoch)).inMinutes<5;
        }).map((var element) {
          print(DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(element.time.microsecondsSinceEpoch)).inMinutes);
          return DeviceTile(
            fullName: element.displayName ?? "",
            proximity: element.distance.toStringAsFixed(2) ?? "",
          );
        }).toList(),
      ),
    );
  }
}
