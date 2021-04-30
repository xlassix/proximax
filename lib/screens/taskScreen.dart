import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proximax/services/location.dart';
import 'package:proximax/services/locationsFinder.dart';
import 'package:proximax/widgets/constant.dart';
import 'package:proximax/widgets/deviceList.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
  Position position;
  TaskScreen({this.position});
  static const String id = "taskScreen";
}

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
LocationFinder _instance = LocationFinder();
String uid;
String displayName;
User loggedInUser;
SharedPreferences prefs;
Position position;
bool _loading = false;

Timer timer = new Timer.periodic(new Duration(seconds: 5), (timer) {
  print("Print after 5 seconds");
});

void getUser() async {
  prefs = await SharedPreferences.getInstance();
  try {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      uid = user.uid;
      displayName = user.displayName;
    } else {
      displayName = prefs.getString('display Name');
      uid = prefs.getString("userId");
    }
  } catch (e) {
    print(e);
  }
}

class _TaskScreenState extends State<TaskScreen> {
  LocationFinder instance = LocationFinder();
  @override
  void initState() {
    super.initState();
    getUser();
    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      test();
    });
  }

  void test() async {
    LocationFinder locationInstance = LocationFinder();
    position = await locationInstance.getCurrentLocation();

    var _locationDb = _firestore.collection("Locations").add({
      "time": DateTime.now(),
      "positionLat": position.latitude,
      "positionLong": position.longitude,
      "displayName": displayName
    });

    await _firestore.collection("currentLocation").doc(uid).set({
      "time": DateTime.now(),
      "positionLat": position.latitude,
      "positionLong": position.longitude,
      "displayName": displayName,
      "accuracy": position.accuracy
    }, SetOptions(merge: true));
    await _locationDb;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    position = position!= null
              ?position:widget.position!= null
              ?widget.position:position;
    return Scaffold(
      backgroundColor: kBgColor,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream:
                          _firestore.collection("currentLocation").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || position == null) {
                          return Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(),
                                  CircularProgressIndicator(
                                    backgroundColor: kBgColor,
                                  )
                                ]),
                          );
                        } else {
                          List<Location> locationList = [];
                          final locations = snapshot.data.docs;
                          for (var location in locations) {
                            Map _data = location.data();
                            Location temp = (Location(
                                displayName: _data['displayName'],
                                positionLat: _data['positionLat'],
                                positionLong: _data['positionLong'],
                                time: _data['time'],
                                accuracy: _data["accuracy"]));
                            temp.getProximity(
                                position.latitude, position.longitude);
                            locationList.add(temp);
                          }
                          return DeviceList(locationList: locationList);
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
