import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq_iibiye/models/cart_product.dart';
import 'package:suuq_iibiye/models/user_model.dart';
import 'package:suuq_iibiye/utils/enums/order_status.dart';

class OrderModel {
  String? id;
  UserModel customer;
  String sendersPhone;
  List<CartProduct?> cartProducts;
  double totalPrice;
  String address;
  DateTime orderedDate;
  OrderStatus status;
  String paymentOption;
  String currency;

  OrderModel({
    this.id,
    required this.sendersPhone,
    required this.customer,
    required this.cartProducts,
    required this.totalPrice,
    required this.address,
    required this.orderedDate,
    this.status = OrderStatus.pending,
    required this.paymentOption,
    required this.currency,
  });

  factory OrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    Timestamp orderedDate = data?['orderedDate'];
    return OrderModel(
        id: snapshot.id,
        sendersPhone: data?['sendersPhone'],
        customer: UserModel.fromJson(data?['customer']),
        cartProducts: (data?['cartProducts'] as List<dynamic>?)
                ?.map((product) => CartProduct.fromJson(product))
                .toList() ??
            [],
        totalPrice: double.parse(data?['totalPrice'].toString() ?? "0"),
        address: data?['address'],
        orderedDate: orderedDate.toDate(),
        status: OrderStatus.fromString(data?['status']),
        currency: data?['currency'],
        paymentOption: data?['paymentOption']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "customer": customer.toFirestore(),
      "cartProducts":
          cartProducts.map((product) => product?.toFirestore()).toList(),
      "totalPrice": totalPrice.toStringAsFixed(2),
      "address": address,
      "orderedDate": orderedDate,
      'sendersPhone': sendersPhone,
      'status': status.name,
      'paymentOption': paymentOption,
      'currency': currency,
    };
  }
}
