import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:adminpet/data.dart' as data1;
import 'package:adminpet/model/clinic_model.dart';
import 'package:adminpet/controller/product_controller.dart';
import 'package:adminpet/screen/widget/maps_widget.dart';

class DetailClinicPage extends StatefulWidget {
  String level = "detail";
  Clinic _clinic = new Clinic();
  DetailClinicPage(this.level, this._clinic);
  _DetailClinicPageState createState() => _DetailClinicPageState();
}

class _DetailClinicPageState extends State<DetailClinicPage> {
  Clinic clinic = new Clinic();
  bool isloading = false;

  var nameEditingController = new TextEditingController();
  var descriptionEditingController = new TextEditingController();
  var priceEditingController = new TextEditingController();

  void initState() {
    super.initState();
    if (widget.level != 'add') {
      setState(() {
        clinic = widget._clinic;
        nameEditingController.text = widget._clinic.name;
        descriptionEditingController.text = widget._clinic.descrition;
        priceEditingController.text = widget._clinic.price.toString();
      });
    }
  }

  Widget formContent() => Container(
        padding: EdgeInsets.all(10.0),
        height: 400.0,
        width: double.infinity,
        child: Card(
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                child: TextField(
                  controller: nameEditingController,
                  onChanged: (text) {
                    setState(() {
                      clinic.name = text;
                    });
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Enter your service",
                    labelText: "Service Name",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                child: TextField(
                  controller: descriptionEditingController,
                  onChanged: (text) {
                    setState(() {
                      clinic.descrition = text;
                    });
                  },
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter Clinic description",
                    labelText: "Description",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                child: TextField(
                  controller: priceEditingController,
                  onChanged: (text) {
                    setState(() {
                      clinic.price = double.parse(text);
                    });
                  },
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Clinic price",
                    labelText: "Price",
                  ),
                ),
              ),
            ],
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
            child: isloading == false
                ? new RaisedButton(
                    color: Colors.lightGreen,
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      ProductController(context).sendDataClinic(clinic);
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: widget.level == 'add'
              ? Text("Add Clinic")
              : Text("Detail Clinic"),
          backgroundColor: Colors.lightGreen,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(child: formContent()),
            Expanded(
              child: widget.level == "add" ? saveButton() : Container(),
            ),
          ],
        ),
        // bottomNavigationBar: widget.level == "add" ? saveButton() : Container(),
      ),
    );
  }
}
