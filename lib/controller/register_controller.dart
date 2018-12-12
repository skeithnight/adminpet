import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as client;

import 'package:adminpet/data.dart' as data;
import 'package:adminpet/model/petshop_model.dart';
import 'package:adminpet/screen/widget/dialog_widget.dart';

class RegisterController {
  BuildContext context;
  RegisterController(this.context);
  void sendData(Petshop petshop) async {
    if (checkData(petshop)) {
      // print(data.urlRegister);
      var response = await client.post(data.urlRegister, body: {
        "username": petshop.username,
        "name": petshop.name,
        "address": petshop.address,
      });
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      DialogWidget(context).tampilDialog("Success", "Success to save data..");
    } else {
      DialogWidget(context).tampilDialog("Failed", "The Data cannot empty!");
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
