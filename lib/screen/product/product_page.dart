import 'package:flutter/material.dart';

import 'package:adminpet/screen/widget/appbar_widget.dart';
import 'package:adminpet/screen/product/data_produk/data_produk_page.dart';
import 'data_grooming/data_grooming_page.dart';
import 'data_clinic/data_clinic_page.dart';
import 'data_hotel/data_hotel_page.dart';

class ProductPage extends StatefulWidget {
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  void gotoPage(nama) {
    // if (nama == "Produk") {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => DataProdukPage()));
    // } else 
    if (nama == "Grooming") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DataGroomingPage()));
    } else if (nama == "Clinic") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DataClinicPage()));
    } else if (nama == "Hotel") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DataHotelPage()));}
  }

  Widget cardMenu(IconData icon, String nama) => new InkWell(
        onTap: () {
          gotoPage(nama);
        },
        child: Container(
          child: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Icon(
                    icon,
                    size: 100.0,
                  ),
                  Text(nama)
                ],
              ),
            ),
          ),
        ),
      );
  Widget content() => new Center(
      child: Container(
          width: 300.0,
          height: 500.0,
          child: Column(
            children: <Widget>[
              // cardMenu(Icons.fastfood, "Produk"),
              cardMenu(Icons.content_cut, "Grooming"),
              cardMenu(Icons.local_hospital, "Clinic"),
              cardMenu(Icons.hotel, "Hotel")
            ],
          )));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context).appBar("Product"),
      body: content(),
    );
  }
}
