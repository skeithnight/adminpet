import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:adminpet/data.dart' as data;
import 'package:adminpet/model/petshop_model.dart';
import 'package:adminpet/screen/widget/dialog_widget.dart';
import 'package:adminpet/screen/authentication/login_page.dart';
import 'package:adminpet/screen/authentication/sign_up_page.dart';

class RegisterController {
  BuildContext context;
  RegisterController(this.context);
  Dio dio = new Dio();
  Petshop petshop = new Petshop();
  void sendData(Petshop _petshop) async {
    petshop = _petshop;

    if (checkData() && checkData() != null) {
      var response =
          await dio.post(data.urlRegister, data: petshop.toJsonRegister());
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        DialogWidget(context: context, dismiss: true)
            .tampilDialog("Success", "Success to save data..", LoginPage());
      } else {
        // If that response was not OK, throw an error.
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Failed", "Server data error", (){});
      }
    } else {
      DialogWidget(context: context, dismiss: true)
          .tampilDialog("Failed", "The Data cannot empty!", (){});
    }
  }

  bool checkData() {
    bool result = false;
    if (petshop != null) {
      if (petshop.username != null ||
          petshop.name != null ||
          petshop.password != null ||
          petshop.latitude != null ||
          petshop.longitude != null ||
          petshop.address != null) {
        result = true;
      }
    }
    return result;
  }
}
