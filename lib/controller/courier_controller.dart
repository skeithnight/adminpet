import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:adminpet/data.dart' as data1;
import 'package:adminpet/model/courier_model.dart';
import 'package:adminpet/screen/widget/dialog_widget.dart';
import 'package:adminpet/screen/main_screen.dart';

class CourierController {
  SharedPreferences prefs;
  BuildContext context;
  CourierController(this.context);
  Dio dio = new Dio();
  Future<String> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  void sendData(Courier courier) async {
    if (checkData(courier)) {
      getToken().then((onValue) {
        insertData(courier, onValue);
      });
    } else {
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Failed", "The Data cannot empty!", () {});
    }
  }

  void insertData(Courier courier, String token) async {
    prefs = await SharedPreferences.getInstance();
    courier.idPetshop = prefs.getString("idPetshop");
    dio.options.headers = {"Authorization": "Bearer " + token};
    dio.options.data = courier.toJsonInsert();
    dio.options.baseUrl = data1.urlCourier;

    var response = await dio.post(data1.pathCourierRegister);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Success", "Success login..", MainScreen());
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  bool checkData(Courier courier) {
    if (courier.username == null ||
        courier.password == null ||
        courier.name == null ||
        courier.idPetshop == null) {
      return false;
    }
    return true;
  }

  // Get Data
  Future<List<Courier>> getData() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlCourier;

    var response = await dio.get('/5c10af71535a234d990b109f');
    List<dynamic> map = response.data;
    List<Courier> listCourier = new List();
    for (var i = 0; i < map.length; i++) {
      listCourier.add(Courier.fromSnapshot(map[i]));
    }
    return listCourier;
  }
}