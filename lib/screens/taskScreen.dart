import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proximax/services/locations.dart';
import 'package:proximax/widgets/deviceList.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
  static const String id = "taskScreen";
}

final _auth = FirebaseAuth.instance;
// final _firestore = FirebaseFirestore.instance;
// String _message;
User loggedInUser;

Timer timer = new Timer.periodic(new Duration(seconds: 5), (timer) {
  print("Print after 5 seconds");
});

void getUser() async {
  try {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      print(user.uid);
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
    test();
    getUser();

    Timer.periodic(Duration(seconds: 5), (timer) {
      print("Print after 5 seconds");
    });
  }

  void test() async {
    Location locationInstance = Location();
    Position position = await locationInstance.getCurrentLocation();
    print(position);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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

// UserCredential(
//   additionalUserInfo: AdditionalUserInfo(isNewUser: false,
//    profile: {},
//    providerId: null,
//    username: null), credential: null,
// user: User(displayName: null, email: koko@g.com, emailVerified: false, isAnonymous: false,
// metadata: UserMetadata(creationTime: 2021-04-17 08:03:54.658, lastSignInTime: 2021-04-17 12:09:57.641),
//  phoneNumber: null,
//   photoURL:
//    null,
//    providerData,
//    [UserInfo(displayName: null, email: koko@g.com, phoneNumber: null, photoURL: null, providerId: password, uid: koko@g.com)], refreshToken: , tenantId: null, uid: uSVm2l6KUgduqOfTuLTeeMZa4CI3))
