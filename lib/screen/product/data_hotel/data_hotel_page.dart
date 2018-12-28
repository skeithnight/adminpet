import 'package:flutter/material.dart';
import 'package:adminpet/screen/widget/appbar_widget.dart';

import 'package:adminpet/controller/product_controller.dart';
import 'package:adminpet/model/hotel_model.dart';
import 'detail_hotel_page.dart';

class DataHotelPage extends StatefulWidget {
  _DataHotelPageState createState() => _DataHotelPageState();
}

class _DataHotelPageState extends State<DataHotelPage> {
  Widget content() => new FutureBuilder<List<Hotel>>(
        future: ProductController(context).getDataHotel(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listData(snapshot.data);
          } else if (snapshot.hasError) {
            return new Center(child: Text("${snapshot.error}"));
          }

          return new Center(child: CircularProgressIndicator());
        },
      );

  Widget listData(List<Hotel> listData) {
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5.0,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailHotelPage('detail', listData[index])));
                },
                title: Text(listData[index].name),
                subtitle: Text(listData[index].price.toString()),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context).appBar("Daftar Hotel"),
      body: content(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailHotelPage("add", null)));
        },
        tooltip: 'Tambah Produk',
        child: Icon(Icons.add),
      ),
    );
  }
}
