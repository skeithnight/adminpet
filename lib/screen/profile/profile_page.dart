import 'package:flutter/material.dart';

import 'package:adminpet/screen/widget/appbar_widget.dart';
import 'package:adminpet/controller/login_controller.dart';
import 'package:adminpet/model/petshop_model.dart';

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Petshop petshop = new Petshop();
  bool isloading = false;

  var nameEditingController = new TextEditingController();
  var addressEditingController = new TextEditingController();

  Widget content() => new Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 300.0,
          width: double.infinity,
          child: Card(
            elevation: 2.0,
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                  child: TextField(
                    controller: nameEditingController,
                    onChanged: (text) {
                      setState(() {
                        petshop.name = text;
                      });
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Enter your petshop name",
                      labelText: "Petshop Name",
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                  child: TextField(
                    controller: addressEditingController,
                    onChanged: (text) {
                      setState(() {
                        petshop.address = text;
                      });
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Enter your petshop address",
                      labelText: "Petshop Address",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Petshop>(
      future: LoginController(context).checkSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          nameEditingController.text = snapshot.data.name;
          addressEditingController.text = snapshot.data.address;
          return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(context).appBar("Profile"),
        body: content(),
      ),
    );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
