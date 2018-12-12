import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:userpet/screens/dashboard/dashboard_one.page.dart';

import 'package:adminpet/screen/authentication/login_page.dart';

class MainScreen extends StatefulWidget {
  static String tag = 'main-page';
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String id;
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
    // setState(() {
    //   id = prefs.getString('id') ?? '';
    // });
  }

  void checkSession() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('id') == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginPage())));
    } else {
      setState(() {
        id = prefs.getString('id') ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      color: Colors.yellow,
      home: Scaffold(
        body: Container(),
      ),
      // home: DashboardOnePage()
    );
  }
}
