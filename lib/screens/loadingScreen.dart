import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proximax/screens/loginScreen.dart';
import 'package:proximax/screens/taskScreen.dart';
import 'package:proximax/services/locationsFinder.dart';
import 'package:proximax/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  final String id = "landing";
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time;

  void getdata(LocationFinder instance) async {
    await instance.getPermission();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("userId") == null) {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, TaskScreen.id, (_) => false);
    }
  }

  @override
  void initState() {
    LocationFinder instance = LocationFinder();
    getdata(instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Center(
          child: Column(
        children: [
          Text(
            "Proximax",
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.white,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      )),
    );
  }
}
