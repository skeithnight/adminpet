import 'service_model.dart';
import 'petshop_model.dart';
import 'courier_model.dart';
import 'customer_model.dart';

class Order {
  String id;
  Customer customer;
  Petshop petshop;
  Courier courier;
  String address;
  double latitude;
  double longitude;
  List<Service> services;
  int from;
  int to;
  String note;
  String status;

  Order();

  Order.fromSnapshot(Map<dynamic, dynamic> snapshot)
      : id = snapshot["id"],
        customer = Customer.fromSnapshot(snapshot["customer"]),
        petshop = Petshop.fromSnapshot(snapshot["petshop"]),
        // courier = Courier.fromSnapshot(snapshot["courier"]),
        address = snapshot["address"],
        latitude = snapshot["latitude"],
        longitude = snapshot["longitude"],
        // services = ,
        from = snapshot["from"],
        to = snapshot["to"],
        note = snapshot["note"],
        status = snapshot["status"];

}
