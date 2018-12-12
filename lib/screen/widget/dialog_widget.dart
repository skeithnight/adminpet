import 'package:flutter/material.dart';
class DialogWidget {
  BuildContext context;
  DialogWidget(this.context);
  void tampilDialog(String tittle, String message){
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(tittle),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                if (tittle == "Failed") {
                  Navigator.of(context).pop();
                } else if (tittle == "Success") {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}