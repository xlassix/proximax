import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:pl_notifications/pl_notifications.dart';
import 'package:proximax/services/location.dart';
import 'package:proximax/services/notification.dart';
import 'package:proximax/widgets/deviceTile.dart';

class DeviceList extends StatefulWidget {
  final List<Location> locationList;
  DeviceList({Key key, @required this.locationList}) : super(key: key);

  @override
  _DeviceListState createState() => _DeviceListState();
}

const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('repeating channel id', 'repeating channel name',
        'repeating description');

const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

class _DeviceListState extends State<DeviceList> {
  List<Location> _violation = [];
  void create() async {
    print(_violation);
    for(var i = 0; i < _violation.length; i++){
      var element=_violation[i];
      print(element);
      await flutterLocalNotificationsPlugin.show(
        124,
        "A Notification From Proximax",
        "${element.displayName} is too close to you",
        platformChannelSpecifics,
        payload: 'data');
    }
    _violation=[];
  }

  @override
  Widget build(BuildContext context) {
    create();
    return Expanded(
      child: ListView(
        children: widget.locationList.where((element) {
          return DateTime.now()
                  .difference(DateTime.fromMicrosecondsSinceEpoch(
                      element.time.microsecondsSinceEpoch))
                  .inMinutes <
              5;
        }).map((var element) {
          //print(DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(element.time.microsecondsSinceEpoch)).inMinutes);
          if (element.distance < 1 && element.distance!= 0.0 ) {
            _violation.add(element);
          }
          return DeviceTile(
            fullName: element.displayName ?? "",
            proximity: element.distance.toStringAsFixed(2) ?? "",
            accuracy: element.distance.toStringAsFixed(2) ?? "",
          );
        }).toList(),
      ),
    );
  }
}
