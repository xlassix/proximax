import 'package:flutter/material.dart';

class DeviceTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  return Card(elevation: 5,child:
   Row(
     children: [
       CircleAvatar(child:Icon(Icons.ac_unit)),
       SizedBox(width: 20,),
       Padding(
         padding: const EdgeInsets.symmetric(vertical: 14.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            Text("Name: OKI Ayobami",
                                  style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,)),
            SizedBox(height: 5,),
            Text("Proximity: 50m"),
           ],
         ),
       )
     ],
     
    ),);
  }
}
