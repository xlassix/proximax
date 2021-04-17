import 'package:flutter/material.dart';
import 'package:proximax/services/locations.dart';
import 'package:proximax/widgets/deviceList.dart';
import 'package:geolocator/geolocator.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
  static const String id = "taskScreen";
}

class _TaskScreenState extends State<TaskScreen> {
  Location instance = Location();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void test() async {
    Location locationInstance = Location();
    Position position = await locationInstance.getCurrentLocation();
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    test();
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.location_city,
                        size: 40.0,
                        color: Colors.lightBlue,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Proximax",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    Text("2 devices",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: Colors.white))
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: DeviceList(),
            ),
          ),
          FloatingActionButton(onPressed: () async {
            await instance.getCurrentLocation();
          })
        ],
      ),
    );
  }
}
