import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:adminpet/screen/widget/appbar_widget.dart';
import 'package:adminpet/controller/order_controller.dart';
import 'detail_order_page.dart';
import 'package:adminpet/model/order_model.dart';

class OrderPage extends StatefulWidget {
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Widget content() {
    return new FutureBuilder<List<Order>>(
      future: OrderController(context).getListData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data);
          // return Container();
          return listData(snapshot.data);
        } else if (snapshot.hasError) {
          return new Center(child: Text("${snapshot.error}"));
        }

        return new Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget listData(List<Order> listData) {
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5.0,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailOrderPage('detail', listData[index])));
                },
                title: Text(listData[index].customer.name),
                subtitle: Text(listData[index].address),
                trailing: listData[index].status == "waiting"
                    ? Icon(Icons.hourglass_empty)
                    : listData[index].status == "jemput" ||
                            listData[index].status == "antar"
                        ? Icon(Icons.directions_car)
                        : listData[index].status == "sampai-petshop"
                            ? Icon(Icons.flag)
                            : listData[index].status == "proses"
                                ? Icon(Icons.pets)
                                : listData[index].status == "selesai-petshop"
                                    ? Icon(Icons.done)
                                    : listData[index].status == "selesai"
                                        ? Icon(Icons.done_all)
                                        : null,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context).appBar("Order"),
      body: content(),
    );
  }
}
