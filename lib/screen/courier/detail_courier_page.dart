import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:adminpet/data.dart' as data1;
import 'package:adminpet/model/courier_model.dart';
import 'package:adminpet/controller/courier_controller.dart';

class DetailCourierPage extends StatefulWidget {
  String level = "detail";
  Courier _courier = new Courier();
  DetailCourierPage(this.level, this._courier);
  _DetailCourierPageState createState() => _DetailCourierPageState();
}

class _DetailCourierPageState extends State<DetailCourierPage> {
  Courier courier = new Courier();
  bool aa = true;

  var nameEditingController = new TextEditingController();
  var usernameEditingController = new TextEditingController();

  void initState() {
    super.initState();
    print(widget.level);
    print(widget._courier.name);
    if (widget.level != 'add') {
      setState(() {
        courier = widget._courier;
        nameEditingController.text = widget._courier.name;
        usernameEditingController.text = widget._courier.username;
      });
    } else {
      setState(() {
        courier.idPetshop = "5c10af71535a234d990b109f";
        courier.enabled = aa;
      });
    }
  }

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
                        courier.name = text;
                      });
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Enter your courier name",
                      labelText: "Courier Name",
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                  child: TextField(
                    controller: usernameEditingController,
                    onChanged: (text) {
                      setState(() {
                        courier.username = text;
                      });
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Enter your courier username",
                      labelText: "UserName",
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        courier.password = text;
                      });
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter your courier password",
                      labelText: "Password",
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(30.0),
                //   width: double.infinity,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Text(
                //         "Enabled",
                //         style: TextStyle(
                //           fontSize: 16.0,
                //           fontWeight: FontWeight.w700,
                //         ),
                //       ),
                //       SizedBox(
                //         height: 5.0,
                //       ),
                //       Wrap(
                //         alignment: WrapAlignment.spaceBetween,
                //         children: data1.listEnabled
                //             .map((pc) => Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: ChoiceChip(
                //                     selectedColor: Colors.yellow,
                //                     label: Text(
                //                       pc,
                //                       style: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                     selected:
                //                         aa == (pc.toLowerCase() == 'true'),
                //                     onSelected: (selected) {
                //                       setState(() {
                //                         aa = selected
                //                             ? (pc.toLowerCase() == 'true')
                //                             : false;
                //                         courier.enabled = aa;
                //                       });
                //                     },
                //                   ),
                //                 ))
                //             .toList(),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      );
  Widget saveButton() => new Container(
        margin: EdgeInsets.all(10.0),
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            height: 50.0,
            child: new RaisedButton(
              color: Colors.lightGreen,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                CourierController(context).sendData(courier);
              },
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: content(),
            ),
            Expanded(
              flex: 1,
              child: widget.level == "add" ? saveButton() : Container(),
            ),
          ],
        ),
        // bottomNavigationBar: widget.level == "add" ? saveButton() : Container(),
      ),
    );
  }
}
