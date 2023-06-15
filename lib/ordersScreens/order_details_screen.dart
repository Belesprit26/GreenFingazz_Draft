import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:green_sellers/ordersScreens/status_banner_widget.dart';
import '../global/global.dart';
import '../models/address.dart';
import 'address_design_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  String? orderID;

  OrderDetailsScreen({
    this.orderID,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("orders")
              .doc(widget.orderID)
              .get(),
          builder: (c, AsyncSnapshot dataSnapshot) {
            Map? orderDataMap;
            if (dataSnapshot.hasData) {
              orderDataMap = dataSnapshot.data.data() as Map<String, dynamic>;
              orderStatus = orderDataMap["status"].toString();

              return Column(
                children: [
                  StatusBanner(
                    status: orderDataMap["isSuccess"],
                    orderStatus: orderStatus,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "R ${orderDataMap["totalAmount"]}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Order ID = ${orderDataMap["orderId"]}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Order at = ${DateFormat("dd MMMM, yyyy - hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(int.parse(orderDataMap["orderTime"])))}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.yellowAccent,
                  ),
                  orderStatus != "ended"
                      ? Image.asset("assets/images/packing.jpg")
                      : Image.asset("assets/images/delivered.jpg"),
                  const Divider(
                    thickness: 1,
                    color: Colors.yellowAccent,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(orderDataMap["orderBy"])
                        .collection("userAddress")
                        .doc(orderDataMap["addressID"])
                        .get(),
                    builder: (c, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return AddressDesign(
                          model: Address.fromJson(
                              snapshot.data.data() as Map<String, dynamic>),
                          orderStatus: orderStatus,
                          orderId: widget.orderID,
                          sellerId: orderDataMap!["sellerUID"],
                          orderByUser: orderDataMap["orderBy"],
                          totalAmount: orderDataMap["totalAmount"].toString(),
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "No data exists.",
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  "No data exists.",
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
