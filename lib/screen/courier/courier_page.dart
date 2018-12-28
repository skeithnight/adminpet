import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:adminpet/screen/widget/appbar_widget.dart';
import 'package:adminpet/controller/courier_controller.dart';
import 'detail_courier_page.dart';
import 'package:adminpet/model/courier_model.dart';
import 'monitor_courier_page.dart';

class CourierPage extends StatefulWidget {
  _CourierPageState createState() => _CourierPageState();
}

class _CourierPageState extends State<CourierPage> {
  Widget buttonMonitor() => new Container(
        margin: EdgeInsets.all(10.0),
        child: Align(
          alignment: FractionalOffset.topCenter,
          child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: new RaisedButton(
                color: Colors.lightGreen,
                child: Text(
                  "Check Location All Courier",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MonitorCourierPage()));
                },
              )),
        ),
      );
  Widget content() {
    return new FutureBuilder<List<Courier>>(
      future: CourierController(context).getData(),
      builder: (context, snapshot) {
        // print(json.encode(snapshot.data));
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Expanded(
                child: buttonMonitor(),
              ),
              Expanded(
                flex: 8,
                child: listData(snapshot.data),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return new Center(child: Text("${snapshot.error}"));
        }

        return new Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget listData(List<Courier> listData) {
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5.0,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailCourierPage('detail', listData[index])));
                },
                title: Text(listData[index].name),
                subtitle: Text(listData[index].username),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context).appBar("Courier"),
      body: content(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailCourierPage("add", null)));
        },
        tooltip: 'Add Courier',
        child: Icon(Icons.add),
      ),
    );
  }
}
