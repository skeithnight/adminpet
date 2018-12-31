import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adminpet/model/order_model.dart';

import 'package:adminpet/data.dart' as data1;
import 'package:adminpet/screen/widget/dialog_widget.dart';
import 'package:adminpet/main.dart';

class OrderController {
  SharedPreferences prefs;

  BuildContext context;
  OrderController(this.context);

  Dio dio = new Dio();
  // Get Data
  Future<List<Order>> getListData() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlOrder;

    var response = await dio.get('/petshop/${prefs.getString('idPetshop')}');
    List<dynamic> map = response.data;
    List<Order> listOrder = new List();
    for (var i = 0; i < map.length; i++) {
      // print(map[i]);
      listOrder.add(Order.fromSnapshot(map[i]));
    }
    // print(listOrder);
    return listOrder;
  }

  String getStatus(String status) {
    String result = "";
    if (status.toLowerCase() == "sampai-petshop") {
      result = "proses";
    } else if (status.toLowerCase() == "proses") {
      result = "selesai-petshop";
    }
    return result;
  }

  void changeStatus(Order order) async {
    if (order != null) {
      try {
        prefs = await SharedPreferences.getInstance();
        // print(order.toJsonChangeStatus(prefs.getString('idCourier'), getStatus(order.status)));
        dio.options.headers = {
          "Authorization": "Bearer " + prefs.getString('token') ?? ''
        };
        var response = await dio.post(data1.urlOrder,
            data: order.toJsonChangeStatus(
                prefs.getString('idCourier'), getStatus(order.status)));
        // If server returns an OK response, parse the JSON
        DialogWidget(context: context, dismiss: true)
            .tampilDialog("Success", "Sukses merubah status", MyApp());
      } on DioError catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        print(e.message);
        DialogWidget(context: context, dismiss: false)
            .tampilDialog("Failed", e.message, () {});
      }
    } else {
      DialogWidget(context: context, dismiss: false)
          .tampilDialog("Failed", "The Data cannot empty!", () {});
    }
  }
}
