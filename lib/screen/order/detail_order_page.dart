import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:adminpet/data.dart' as data1;
import 'package:adminpet/model/order_model.dart';
import 'package:adminpet/controller/order_controller.dart';
import 'package:adminpet/screen/widget/maps_widget.dart';

class DetailOrderPage extends StatefulWidget {
  String level = "detail";
  Order _order = new Order();
  DetailOrderPage(this.level, this._order);
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  final WebSocketChannel channel = IOWebSocketChannel.connect(
      "ws://35.231.59.91:8080/get-ws-Order/5c10af71535a234d990b109f");

  Order order = new Order();
  bool aa = true;
  bool isloading = false;

  var nameEditingController = new TextEditingController();
  var usernameEditingController = new TextEditingController();

  void initState() {
    super.initState();
    setState(() {
      order = widget._order;
      nameEditingController.text = widget._order.customer.name;
    });
  }

  Widget orderContent() => Container(
        padding: EdgeInsets.all(10.0),
        height: 300.0,
        width: double.infinity,
        child: Card(
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  order.customer.name,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(order.address),
              ),
              ListTile(
                title: Text("Kurir"),
                subtitle: Text("Belum di jemputr"),
              ),
              ListTile(
                title: Text("Pesanan"),
                subtitle: Card(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Grooming Biasa"),
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              //   child: TextField(
              //     controller: nameEditingController,
              //     onChanged: (text) {
              //       setState(() {
              //         order.customer.name = text;
              //       });
              //     },
              //     maxLines: 1,
              //     decoration: InputDecoration(
              //       hintText: "Enter your Order name",
              //       labelText: "Order Name",
              //     ),
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              //   child: TextField(
              //     controller: usernameEditingController,
              //     onChanged: (text) {
              //       setState(() {
              //         order.username = text;
              //       });
              //     },
              //     maxLines: 1,
              //     decoration: InputDecoration(
              //       hintText: "Enter your Order username",
              //       labelText: "UserName",
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );

  // Future<Order> showMonitoring(snapshot) async {
  //   List<dynamic> list = json.decode(order);
  //   List<Order> listOrder = new List();
  //   Order iOrder = new Order();
  //   for (var item in list) {
  //     listOrder.add(Order.fromSnapshot(item));
  //   }
  //   for (var item in listOrder) {
  //     if (item.id == order.id) {
  //       iOrder = item;
  //     }
  //   }
  //   return iOrder;
  // }

  Widget mapswidget() => new Container(
        padding: EdgeInsets.all(10.0),
        height: 300.0,
        width: double.infinity,
        child: Card(
          elevation: 2.0,
          child: MapsWidget(
            lat: order.latitude != null ? order.latitude : -6.934837,
            lon: order.longitude != null ? order.longitude : 107.620810,
            listMarker: [
              new Marker(
                width: 80.0,
                height: 80.0,
                point: new LatLng(
                    order.latitude != null ? order.latitude : -6.934837,
                    order.longitude != null ? order.longitude : 107.620810),
                builder: (ctx) => new Container(
                      child: Icon(Icons.place),
                    ),
              )
            ],
          ),
        ),
      );
  Widget content() => new Center(
          child: Column(
        children: <Widget>[
          mapswidget(),
          orderContent(),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Detail Order"),
            backgroundColor: Colors.lightGreen,
          ),
          body: SingleChildScrollView(
            child: content(),
          )
          // bottomNavigationBar: widget.level == "add" ? saveButton() : Container(),
          ),
    );
  }
}
