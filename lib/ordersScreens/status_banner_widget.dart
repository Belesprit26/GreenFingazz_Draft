import 'package:flutter/material.dart';

import '../Brand_Screens/home_screen.dart';

class StatusBanner extends StatelessWidget {
  bool? status;
  String? orderStatus;

  StatusBanner({
    this.status,
    this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? iconData;

    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = "Successful" : message = "UnSuccessful";

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFC107),
        ),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              orderStatus == "ended"
                  ? "Parcel Delivered $message"
                  : orderStatus == "shifted"
                      ? "Parcel Shifted $message"
                      : orderStatus == "normal"
                          ? "Order Placed $message"
                          : "",
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(
              width: 6,
            ),
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.black,
              child: Center(
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
