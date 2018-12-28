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

class MonitorCourierPage extends StatefulWidget {
  _MonitorCourierPageState createState() => _MonitorCourierPageState();
}

class _MonitorCourierPageState extends State<MonitorCourierPage> {
  final WebSocketChannel channel = IOWebSocketChannel.connect(
      "ws://35.231.59.91:8080/get-ws-courier/5c10af71535a234d990b109f");

  Courier courier = new Courier();
  bool isloading = false;

  Future<List<Marker>> showMonitoring(snapshot) async {
    List<dynamic> list = json.decode(snapshot.data);
    List<Courier> listcourier = new List();
    List<Marker> listMarker = new List();
    for (var item in list) {
      listcourier.add(Courier.fromSnapshot(item));
    }
    for (var item in listcourier) {
      LatLng latLng = item.latitude != null
          ? new LatLng(item.latitude, item.longitude)
          : new LatLng(-6.934837, 107.620810);
      listMarker
          .add(new Marker(
                          width: 80.0,
                          height: 80.0,
                          point: latLng,
                          builder: (ctx) => new Container(
                                child: Icon(Icons.place),
                              ),
                        ));
    }
    return listMarker;
  }

  Widget mapswidget() => StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new FutureBuilder<List<Marker>>(
              future: showMonitoring(snapshot),
              builder: (context, snapshot) {
                return MapsWidget(
                  lat: -6.934837,
                  lon: 107.620810,
                  listMarker: snapshot.data,
                );
                // return Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 24.0),
                //   child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                // );
              },
            );
          }
          return new Center(child: CircularProgressIndicator());
        },
      );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Monitor Courier"),
            backgroundColor: Colors.lightGreen,
          ),
          body: mapswidget()),
    );
  }
}
