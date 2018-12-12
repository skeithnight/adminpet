import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:adminpet/data.dart' as data;
import 'package:adminpet/model/petshop_model.dart';
import 'package:adminpet/screen/widget/dialog_widget.dart';
import 'package:adminpet/screen/main_screen.dart';
import 'package:adminpet/screen/authentication/login_page.dart';

class LoginController {
  BuildContext context;
  LoginController(this.context);
  Dio dio = new Dio();
  void sendData(Petshop petshop) async {
    if (checkData(petshop)) {
      // print(data.urlRegister);
      // print(petshop.toJsonLogin());
      var response = await dio.post(data.urlLogin, data: petshop.toJsonLogin());
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString('token', response.data['token']);
        _prefs.commit();
        DialogWidget( context: context,dismiss: true).tampilDialog("Success", "Success login..",MainScreen());
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    } else {
      DialogWidget(context: context).tampilDialog("Failed", "The Data cannot empty!",(){});
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
}
