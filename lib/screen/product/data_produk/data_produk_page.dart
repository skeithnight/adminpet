import 'package:flutter/material.dart';
import 'package:adminpet/screen/widget/appbar_widget.dart';

class DataProdukPage extends StatefulWidget {
  _DataProdukPageState createState() => _DataProdukPageState();
}

class _DataProdukPageState extends State<DataProdukPage> {
  Widget content()=> new Container();
  // new FutureBuilder<List<Courier>>(
  //     future: CourierController(context).getData(),
  //     builder: (context, snapshot) {
  //       // print(json.encode(snapshot.data));
  //       if (snapshot.hasData) {
  //         return listData(snapshot.data);
  //       } else if (snapshot.hasError) {
  //         return new Center(child: Text("${snapshot.error}"));
  //       }

  //       return new Center(child: CircularProgressIndicator());
  //     },
  //   );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context).appBar("Daftar Produk"),
      body: content(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => DetailCourierPage("add", null)));
        },
        tooltip: 'Tambah Produk',
        child: Icon(Icons.add),
      ),
    );
  }
}
