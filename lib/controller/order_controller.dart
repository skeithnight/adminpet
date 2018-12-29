import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adminpet/model/order_model.dart';

import 'package:adminpet/data.dart' as data1;

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
}