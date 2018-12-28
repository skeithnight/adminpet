import 'package:flutter/material.dart';
import 'package:adminpet/screen/widget/appbar_widget.dart';

import 'package:adminpet/controller/product_controller.dart';
import 'package:adminpet/model/grooming_model.dart';
import 'detail_grooming_page.dart';

class DataGroomingPage extends StatefulWidget {
  _DataGroomingPageState createState() => _DataGroomingPageState();
}

class _DataGroomingPageState extends State<DataGroomingPage> {
  Widget content() => new FutureBuilder<List<Grooming>>(
        future: ProductController(context).getDataGrooming(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listData(snapshot.data);
          } else if (snapshot.hasError) {
            return new Center(child: Text("${snapshot.error}"));
          }

          return new Center(child: CircularProgressIndicator());
        },
      );

  Widget listData(List<Grooming> listData) {
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5.0,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailGroomingPage('detail', listData[index])));
                },
                title: Text(listData[index].name),
                subtitle: Text(listData[index].price.toString()),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context).appBar("Daftar Grooming"),
      body: content(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailGroomingPage("add", null)));
        },
        tooltip: 'Tambah Produk',
        child: Icon(Icons.add),
      ),
    );
  }
}
