import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:userpet/screens/dashboard/dashboard_one.page.dart';

import 'package:adminpet/screen/authentication/login_page.dart';
import 'package:adminpet/data.dart' as data;
import 'package:adminpet/controller/login_controller.dart';
import 'package:adminpet/screen/courier/courier_page.dart';
import 'package:adminpet/screen/product/product_page.dart';
import 'profile/profile_page.dart';
import 'widget/appbar_widget.dart';

class MainScreen extends StatefulWidget {
  static String tag = 'main-page';
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String token;
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
  }

  void checkSession() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginPage())));
    } else {
      setState(() {
        token = prefs.getString('token') ?? '';
      });
    }
  }

  
  Widget bottomNavigator() => TabBar(
        labelColor: Colors.black,
        tabs: <Widget>[
          Tab(
            icon: new Icon(
              Icons.shopping_basket,
              color: Colors.black,
            ),
            text: "Product",
          ),
          Tab(
              icon: new Icon(
                Icons.local_shipping,
                color: Colors.black,
              ),
              text: "Courier"),
          Tab(
              icon: new Icon(
                Icons.store,
                color: Colors.black,
              ),
              text: "Profile"),
        ],
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      color: Colors.yellow,
      home: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            body: TabBarView(
              children: <Widget>[
                new ProductPage(),
                new CourierPage(),
                new ProfilePage(),
              ],
            ),
            bottomNavigationBar: bottomNavigator(),
          ),
        ),
      ),
    );
  }
}
