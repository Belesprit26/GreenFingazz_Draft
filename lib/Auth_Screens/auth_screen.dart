import 'package:flutter/material.dart';
import 'package:green_sellers/Auth_Screens/login_tab_page.dart';
import 'package:green_sellers/Auth_Screens/login_tab_page.dart';
import 'package:green_sellers/Auth_Screens/registration_tab_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(color: Color(0xFFFFC107)),
            ),
            title: const Text(
              "Green Fingaz",
              style: TextStyle(
                fontSize: 30,
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.black87,
              indicatorWeight: 4,
              tabs: [
                Tab(
                  text: "Login",
                  icon: Icon(
                    Icons.lock,
                    color: Colors.black87,
                  ),
                ),
                Tab(
                  text: "Registration",
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(color: Color(0xFFFFC107)),
            child: TabBarView(
              children: [
                LoginTabPage(),
                RegistrationTabPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
