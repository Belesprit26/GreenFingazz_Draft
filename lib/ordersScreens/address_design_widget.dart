import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_sellers/global/global.dart';
import '../models/address.dart';
import '../Splash_Screen/splash_screen.dart';
import 'package:http/http.dart' as http;

class AddressDesign extends StatelessWidget {
  Address? model;
  String? orderStatus;
  String? orderId;
  String? sellerId;
  String? orderByUser;
  String? totalAmount;

  AddressDesign({
    this.model,
    this.orderStatus,
    this.orderId,
    this.sellerId,
    this.orderByUser,
    this.totalAmount,
  });

  sendNotificationToUser(userUID, orderID) async {
    String userDeviceToken = "";

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userUID)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["userDeviceToken"] != null) {
        userDeviceToken = snapshot.data()!["userDeviceToken"].toString();
      }
    });

    notificationFormat(
      userDeviceToken,
      orderID,
      sharedPreferences!.getString("name"),
    );
  }

  notificationFormat(userDeviceToken, orderID, sellerName) {
    Map<String, String> headerNotification = {
      'Content-Type': 'application/json',
      'Authorization': fcmServerToken,
    };

    Map bodyNotification = {
      'body':
          "Dear User, your Parcel (# $orderID) has been Confirmed Successfully by $sellerName and is Enroute  . \nPlease Check Now",
      'title': "Parcel Confirmed",
    };

    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "userOrderId": orderID,
    };

    Map officialNotificationFormat = {
      'notification': bodyNotification,
      'data': dataMap,
      'priority': 'high',
      'to': userDeviceToken,
    };

    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Shipping Details:',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              //name
              TableRow(
                children: [
                  const Text(
                    "Name:",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    model!.name.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const TableRow(
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),

              //phone
              TableRow(
                children: [
                  const Text(
                    "Phone Number:",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    model!.phoneNumber.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.completeAddress.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (orderStatus == "normal") {
              //update earnings
              FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(sharedPreferences!.getString("uid"))
                  .update({
                "earnings": (double.parse(previousEarning)) +
                    (double.parse(totalAmount!)),
              }).whenComplete(() {
                //change order status to shifted
                FirebaseFirestore.instance
                    .collection("orders")
                    .doc(orderId)
                    .update({
                  "status": "shifted",
                }).whenComplete(() {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(orderByUser)
                      .collection("orders")
                      .doc(orderId)
                      .update({
                    "status": "shifted",
                  }).whenComplete(() {
                    //send notification to user - order shifted
                    sendNotificationToUser(orderByUser, orderId);

                    Fluttertoast.showToast(msg: "Confirmed Successfully.");

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MySplashScreen()));
                  });
                });
              });
            } else if (orderStatus == "shifted") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MySplashScreen()));
            } else if (orderStatus == "ended") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MySplashScreen()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MySplashScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFFFFC107)),
              width: MediaQuery.of(context).size.width - 40,
              height: orderStatus == "ended"
                  ? 60
                  : MediaQuery.of(context).size.height * .10,
              child: Center(
                child: Text(
                  orderStatus == "ended"
                      ? "Go Back"
                      : orderStatus == "shifted"
                          ? "Go Back"
                          : orderStatus == "normal"
                              ? "Parcel Packed & \nEnroute to Nearest PickUp Point. \nClick to Confirm"
                              : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
