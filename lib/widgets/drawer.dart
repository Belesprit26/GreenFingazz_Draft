import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_sellers/Brand_Screens/home_screen.dart';
import 'package:green_sellers/Splash_Screen/splash_screen.dart';
import 'package:green_sellers/earningsScreen/earnings_screen.dart';
import 'package:green_sellers/global/global.dart';
import 'package:green_sellers/history/history_screen.dart';
import 'package:green_sellers/ordersScreens/orders_screen.dart';
import 'package:green_sellers/shiftedParcelScreen/shifted_parcels.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
            backgroundColor: Color(0xFFFFC107).withOpacity(0.80),
            child: ListView(children: [
              //header
              Container(
                padding: const EdgeInsets.only(top: 26, bottom: 12),
                child: Column(
                  children: [
                    //user profile image
                    //header
                    Container(
                      padding: const EdgeInsets.only(top: 26, bottom: 12),
                      child: Column(
                        children: [
                          //user profile image
                          SizedBox(
                            height: 130,
                            width: 130,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                sharedPreferences!.getString("photoUrl")!,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          //user name
                          //user name
                          Text(
                            sharedPreferences!.getString("name")!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),

                    //body
                    Container(
                      padding: const EdgeInsets.only(top: 1),
                      child: Column(
                        children: [
                          const Divider(
                            height: 10,
                            color: Color(0xFFFBC02D),
                            thickness: 2,
                          ),

                          //home
                          ListTile(
                            leading: const Icon(
                              Icons.home,
                              color: Colors.black87,
                            ),
                            title: const Text(
                              "Home",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => HomeScreen()));
                            },
                          ),
                          const Divider(
                            height: 10,
                            color: Color(0xFFFBC02D),
                            thickness: 2,
                          ),

                          //earnigs
                          ListTile(
                            leading: const Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.black,
                            ),
                            title: const Text(
                              "My Total Earnings",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => EarningsScreen()));
                            },
                          ),
                          const Divider(
                            height: 10,
                            color: Color(0xFFFBC02D),
                            thickness: 2,
                          ),

                          //my orders
                          ListTile(
                            leading: const Icon(
                              Icons.reorder,
                              color: Colors.black,
                            ),
                            title: const Text(
                              "Open Orders",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => OrdersScreen()));
                            },
                          ),
                          const Divider(
                            height: 10,
                            color: Color(0xFFFBC02D),
                            thickness: 2,
                          ),

                          //not yet received orders
                          ListTile(
                            leading: const Icon(
                              Icons.picture_in_picture_alt_rounded,
                              color: Colors.black,
                            ),
                            title: const Text(
                              "Orders Enroute",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => ShiftedParcelsScreen()));
                            },
                          ),
                          const Divider(
                            height: 10,
                            color: Color(0xFFFBC02D),
                            thickness: 2,
                          ),

                          //history
                          ListTile(
                            leading: const Icon(
                              Icons.access_time,
                              color: Colors.black,
                            ),
                            title: const Text(
                              "History",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => HistoryScreen()));
                            },
                          ),
                          const Divider(
                            height: 10,
                            color: Color(0xFFFBC02D),
                            thickness: 2,
                          ),

                          //logout
                          ListTile(
                            leading: const Icon(
                              Icons.exit_to_app,
                              color: Colors.black,
                            ),
                            title: const Text(
                              "Sign Out",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => MySplashScreen()));
                            },
                          ),
                          const Divider(
                            height: 10,
                            color: Color(0xFFFBC02D),
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
