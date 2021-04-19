import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proximax/services/locations.dart';
import 'package:proximax/widgets/deviceList.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
  static const String id = "taskScreen";
}

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
String uid;
String full_name;
User loggedInUser;
SharedPreferences prefs;

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
      full_name = user.displayName;
    } else {
      full_name = prefs.getString('display Name');
      uid = prefs.getString("userId");
    }
  } catch (e) {
    print(e);
  }
}

class _TaskScreenState extends State<TaskScreen> {
  Location instance = Location();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    timer = Timer.periodic(Duration(seconds: 60), (timer) {
      test();
    });
  }

  void test() async {
    Location locationInstance = Location();
    Position position = await locationInstance.getCurrentLocation();
    await _firestore.collection("currentLocation").doc(uid).set({
      "time": DateTime.now(),
      "position_lat": position.latitude,
      "position_long": position.longitude,
      "display Name": full_name
    }, SetOptions(merge: true));

    print(position);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}

