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
    print(widget.locationList);
    return Expanded(
      child: ListView(
        children: widget.locationList.map((var element) {
          print(element.displayName);
          return DeviceTile(
            fullName: element.displayName ?? "",
            proximity: element.positionLat.toString() ?? "",
          );
        }).toList(),
      ),
    );
  }
}
