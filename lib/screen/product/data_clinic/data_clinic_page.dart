import 'package:flutter/material.dart';
import 'package:adminpet/screen/widget/appbar_widget.dart';

import 'package:adminpet/controller/product_controller.dart';
import 'package:adminpet/model/clinic_model.dart';
import 'detail_clinic_page.dart';

class DataClinicPage extends StatefulWidget {
  _DataClinicPageState createState() => _DataClinicPageState();
}

class _DataClinicPageState extends State<DataClinicPage> {
  Widget content() => new FutureBuilder<List<Clinic>>(
        future: ProductController(context).getDataClinic(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listData(snapshot.data);
          } else if (snapshot.hasError) {
            return new Center(child: Text("${snapshot.error}"));
          }

          return new Center(child: CircularProgressIndicator());
        },
      );

  Widget listData(List<Clinic> listData) {
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5.0,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailClinicPage('detail', listData[index])));
                },
                title: Text(listData[index].name),
                subtitle: Text(listData[index].price.toString()),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context).appBar("Daftar Clinic"),
      body: content(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailClinicPage("add", null)));
        },
        tooltip: 'Tambah Produk',
        child: Icon(Icons.add),
      ),
    );
  }
}
