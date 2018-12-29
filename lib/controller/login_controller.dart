import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:adminpet/data.dart' as data1;
import 'package:adminpet/model/petshop_model.dart';
import 'package:adminpet/screen/widget/dialog_widget.dart';
import 'package:adminpet/screen/main_screen.dart';
import 'package:adminpet/screen/authentication/login_page.dart';

class LoginController {
  BuildContext context;
  LoginController(this.context);
  Dio dio = new Dio();
  void sendData(Petshop petshop) async {
    try {
      if (checkData(petshop)) {
        try {
          var response =
              await dio.post(data1.urlLogin, data: petshop.toJsonLogin());
          // If server returns an OK response, parse the JSON
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          _prefs.setString('token', response.data['token']);
          _prefs.commit();
          DialogWidget(context: context, dismiss: true)
              .tampilDialog("Success", "Success login..", MainScreen());
        } on DioError catch (e) {
          // The request was made and the server responded with a status code
          // that falls out of the range of 2xx and is also not 304.
          DialogWidget(context: context)
              .tampilDialog("Failed", e.message, () {});
        }
      } else {
        DialogWidget(context: context)
            .tampilDialog("Failed", "The Data cannot empty!", () {});
      }
    } catch (e) {
      DialogWidget(context: context)
          .tampilDialog("Failed", "The Data cannot empty!", () {});
    }
  }

  bool checkData(Petshop petshop) {
    if (petshop.username == null || petshop.password == null) {
      return false;
    }
    return true;
  }

  void logout() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginPage())));
    } catch (e) {
      throw (e);
    }
  }

  Future<String> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      checkSession();
      if (prefs.getString('token') == null ||
          prefs.getString('idPetshop') == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => LoginPage())));
      }
    } catch (e) {
      DialogWidget(context: context)
          .tampilDialog("Failed", "The Data cannot empty!", () {});
    }
    return prefs.getString('token');
  }

  Future<Petshop> checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.headers = {
      "Authorization": "Bearer " + prefs.getString('token') ?? ''
    };
    Response response;
    try {
      response = await dio.get(data1.urlCheckSession);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginPage())));
    }
    // print(response.data);
    Petshop petshop = Petshop.fromSnapshot(response.data);
    prefs.setString("idPetshop", petshop.id);
    prefs.commit();
    return petshop;
  }
}
