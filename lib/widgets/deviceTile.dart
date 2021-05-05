import 'package:flutter/material.dart';

class DeviceTile extends StatelessWidget {
  //set up required fields in which every device tile must posses
  DeviceTile({@required this.fullName, @required this.proximity,@required this.accuracy});
  final String fullName;
  final String proximity;
  final String accuracy;

  @override
  Widget build(BuildContext context) {
    return Card(
      //color was set to varies based on Proximity/distance between users
      color: double.parse(proximity)==0.0?
      Colors.red: double.parse(proximity)<1.0?
      Colors.yellow:Colors.green,
      elevation: 5,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CircleAvatar(child: Icon(Icons.ac_unit)),
          ),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fullName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    )),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Proximity:" + proximity + "m",
                    style: TextStyle(
                      color: Colors.white,)),
                    SizedBox(width: 20),
                    Text("Accuracy:" + accuracy + "m",style: TextStyle(
                      color: Colors.white,)),
                  ],
                  
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
