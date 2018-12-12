import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:adminpet/data.dart' as data;
import 'package:adminpet/model/petshop_model.dart';
import 'package:adminpet/screen/widget/dialog_widget.dart';

class RegisterController {
  BuildContext context;
  RegisterController(this.context);
  Dio dio = new Dio();
  void sendData(Petshop petshop) async {
    if (checkData(petshop)) {
      // print(data.urlRegister);
      print(petshop.toJsonRegister());
      var response = await dio.post(
        data.urlRegister, data: petshop.toJsonRegister()
      );
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        DialogWidget(context: context, dismiss: true).tampilDialog("Success", "Success to save data..",(){});
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    } else {
      DialogWidget(context: context).tampilDialog("Failed", "The Data cannot empty!",(){});
    }
  }

  bool checkData(Petshop petshop) {
    if (petshop.username == null ||
        petshop.name == null ||
        petshop.password == null ||
        petshop.latitude == null ||
        petshop.longitude == null ||
        petshop.address == null) {
      return false;
    }
    return true;
  }
}
