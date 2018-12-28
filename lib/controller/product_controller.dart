import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:adminpet/data.dart' as data1;
// import 'package:adminpet/model/courier_model.dart';
import 'package:adminpet/screen/widget/dialog_widget.dart';
import 'package:adminpet/screen/main_screen.dart';
import 'package:adminpet/model/grooming_model.dart';
import 'package:adminpet/model/clinic_model.dart';
import 'package:adminpet/model/hotel_model.dart';
class ProductController {
  SharedPreferences prefs;
  BuildContext context;
  ProductController(this.context);
  Dio dio = new Dio();

  Future<String> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  // Grooming
  Future<List<Grooming>> getDataGrooming() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlGrooming;

    var response = await dio.get('/petshop/${prefs.getString('idPetshop')}');
    List<dynamic> map = response.data;
    List<Grooming> listgrooming = new List();
    for (var i = 0; i < map.length; i++) {
      listgrooming.add(Grooming.fromSnapshot(map[i]));
    }
    return listgrooming;
  }
  void sendDataGrooming(Grooming grooming) async {
    if (checkDataGrooming(grooming)) {
      getToken().then((onValue) {
        insertDataGrooming(grooming, onValue);
      });
    } else {
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Failed", "The Data cannot empty!", () {});
    }
  }

  void insertDataGrooming(Grooming grooming, String token) async {
    prefs = await SharedPreferences.getInstance();
    grooming.idPetshop = prefs.getString("idPetshop");
    // print(json.encode(courier.idPetshop));
    dio.options.headers = {"Authorization": "Bearer " + token};
    dio.options.data = grooming.toJsonInsert();
    dio.options.baseUrl = data1.urlGrooming;

    var response = await dio.post('');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Success", "Success on saving data...", MainScreen());
    } else {
      // If that response was not OK, throw an error.
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Failed", "Error on saving data", () {});
    }
  }

  bool checkDataGrooming(Grooming grooming) {
    if (grooming.name == null ||
        grooming.descrition == null ||
        grooming.price == null) {
      return false;
    }
    return true;
  }

  // Clinic
  Future<List<Clinic>> getDataClinic() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlClinic;

    var response = await dio.get('/petshop/${prefs.getString('idPetshop')}');
    List<dynamic> map = response.data;
    List<Clinic> listclinic = new List();
    for (var i = 0; i < map.length; i++) {
      listclinic.add(Clinic.fromSnapshot(map[i]));
    }
    return listclinic;
  }
  void sendDataClinic(Clinic clinic) async {
    if (checkDataClinic(clinic)) {
      getToken().then((onValue) {
        insertDataClinic(clinic, onValue);
      });
    } else {
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Failed", "The Data cannot empty!", () {});
    }
  }

  void insertDataClinic(Clinic clinic, String token) async {
    prefs = await SharedPreferences.getInstance();
    clinic.idPetshop = prefs.getString("idPetshop");
    // print(json.encode(courier.idPetshop));
    dio.options.headers = {"Authorization": "Bearer " + token};
    dio.options.data = clinic.toJsonInsert();
    dio.options.baseUrl = data1.urlClinic;

    var response = await dio.post('');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Success", "Success on saving data...", MainScreen());
    } else {
      // If that response was not OK, throw an error.
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Failed", "Error on saving data", () {});
    }
  }

  bool checkDataClinic(Clinic clinic) {
    if (clinic.name == null ||
        clinic.descrition == null ||
        clinic.price == null) {
      return false;
    }
    return true;
  }

  // Clinic
  Future<List<Hotel>> getDataHotel() async {
    prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    dio.options.baseUrl = data1.urlHotel;

    var response = await dio.get('/petshop/${prefs.getString('idPetshop')}');
    List<dynamic> map = response.data;
    List<Hotel> listhotel = new List();
    for (var i = 0; i < map.length; i++) {
      listhotel.add(Hotel.fromSnapshot(map[i]));
    }
    return listhotel;
  }
  void sendDataHotel(Hotel hotel) async {
    if (checkDataHotel(hotel)) {
      getToken().then((onValue) {
        insertDataHotel(hotel, onValue);
      });
    } else {
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Failed", "The Data cannot empty!", () {});
    }
  }

  void insertDataHotel(Hotel hotel, String token) async {
    prefs = await SharedPreferences.getInstance();
    hotel.idPetshop = prefs.getString("idPetshop");
    // print(json.encode(courier.idPetshop));
    dio.options.headers = {"Authorization": "Bearer " + token};
    dio.options.data = hotel.toJsonInsert();
    dio.options.baseUrl = data1.urlHotel;

    var response = await dio.post('');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Success", "Success on saving data...", MainScreen());
    } else {
      // If that response was not OK, throw an error.
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Failed", "Error on saving data", () {});
    }
  }

  bool checkDataHotel(Hotel hotel) {
    if (hotel.name == null ||
        hotel.descrition == null ||
        hotel.price == null) {
      return false;
    }
    return true;
  }
}
