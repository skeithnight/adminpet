import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:adminpet/data.dart' as data1;
import 'package:adminpet/model/hotel_model.dart';
import 'package:adminpet/controller/product_controller.dart';
import 'package:adminpet/screen/widget/maps_widget.dart';

class DetailHotelPage extends StatefulWidget {
  String level = "detail";
  Hotel _hotel = new Hotel();
  DetailHotelPage(this.level, this._hotel);
  _DetailHotelPageState createState() => _DetailHotelPageState();
}

class _DetailHotelPageState extends State<DetailHotelPage> {
  Hotel hotel = new Hotel();
  bool isloading = false;

  var nameEditingController = new TextEditingController();
  var descriptionEditingController = new TextEditingController();
  var priceEditingController = new TextEditingController();

  void initState() {
    super.initState();
    if (widget.level != 'add') {
      setState(() {
        hotel = widget._hotel;
        nameEditingController.text = widget._hotel.name;
        descriptionEditingController.text = widget._hotel.descrition;
        priceEditingController.text = widget._hotel.price.toString();
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
                      hotel.name = text;
                    });
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Enter your hotel service",
                    labelText: "Hotel Service",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                child: TextField(
                  controller: descriptionEditingController,
                  onChanged: (text) {
                    setState(() {
                      hotel.descrition = text;
                    });
                  },
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter Service description",
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
                      hotel.price = double.parse(text);
                    });
                  },
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Service price",
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
                      ProductController(context).sendDataHotel(hotel);
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
              ? Text("Add Hotel")
              : Text("Detail Hotel"),
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
