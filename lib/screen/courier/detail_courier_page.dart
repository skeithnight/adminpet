import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:adminpet/data.dart' as data1;
import 'package:adminpet/model/courier_model.dart';
import 'package:adminpet/controller/courier_controller.dart';
import 'package:adminpet/screen/widget/maps_widget.dart';

class DetailCourierPage extends StatefulWidget {
  String level = "detail";
  Courier _courier = new Courier();
  DetailCourierPage(this.level, this._courier);
  _DetailCourierPageState createState() => _DetailCourierPageState();
}

class _DetailCourierPageState extends State<DetailCourierPage> {
  final WebSocketChannel channel = IOWebSocketChannel.connect(
      "ws://35.231.59.91:8080/get-ws-courier/5c10af71535a234d990b109f");

  Courier courier = new Courier();
  bool aa = true;
  bool isloading = false;

  var nameEditingController = new TextEditingController();
  var usernameEditingController = new TextEditingController();

  void initState() {
    super.initState();
    if (widget.level != 'add') {
      setState(() {
        courier = widget._courier;
        nameEditingController.text = widget._courier.name;
        usernameEditingController.text = widget._courier.username;
      });
    } else {
      setState(() {
        courier.enabled = aa;
      });
    }
  }

  Widget formContent() => Container(
        padding: EdgeInsets.all(10.0),
        height: 300.0,
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
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
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
              widget.level != 'add'
                  ? Container()
                  : Container(
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
            ],
          ),
        ),
      );

  Future<Courier> showMonitoring(snapshot) async {
    List<dynamic> list = json.decode(snapshot.data);
    List<Courier> listcourier = new List();
    Courier icourier = new Courier();
    for (var item in list) {
      listcourier.add(Courier.fromSnapshot(item));
    }
    for (var item in listcourier) {
      if (item.id == courier.id) {
        icourier = item;
      }
    }
    return icourier;
  }

  Widget mapswidget() => StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new FutureBuilder<Courier>(
              future: showMonitoring(snapshot),
              builder: (context, snapshot) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  height: 300.0,
                  width: double.infinity,
                  child: Card(
                    elevation: 2.0,
                    child: MapsWidget(
                      lat: snapshot.data.latitude != null
                          ? snapshot.data.latitude
                          : -6.934837,
                      lon: snapshot.data.longitude != null
                          ? snapshot.data.longitude
                          : 107.620810,
                      listMarker: [
                        new Marker(
                          width: 80.0,
                          height: 80.0,
                          point: new LatLng(
                              snapshot.data.latitude != null
                                  ? snapshot.data.latitude
                                  : -6.934837,
                              snapshot.data.longitude != null
                                  ? snapshot.data.longitude
                                  : 107.620810),
                          builder: (ctx) => new Container(
                                child: Icon(Icons.place),
                              ),
                        )
                      ],
                    ),
                  ),
                );
                // return Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 24.0),
                //   child: Text(snapshot.hasData ? '${snapshot.data.latitude}' : ''),
                // );
              },
            );
          }
          return new Center(child: CircularProgressIndicator());
        },
      );
  Widget content() => new Center(
          child: Column(
        children: <Widget>[
          widget.level != 'add' ? mapswidget() : Container(),
          formContent(),
        ],
      ));
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
                      CourierController(context).sendData(courier);
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
              ? Text("Add courier")
              : Text("Detail Courier"),
          backgroundColor: Colors.lightGreen,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: content(),
            ),
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
