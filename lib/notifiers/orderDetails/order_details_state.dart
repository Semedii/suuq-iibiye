
import 'package:suuq_iibiye/models/order.dart';

abstract class OrderDetailsState{}

class OrderDetailsInitialState extends OrderDetailsState{}

class OrderDetailsLoadingState extends OrderDetailsState{}

class OrderDetailsLoadedState extends OrderDetailsState{
  final OrderModel orderModel;

  OrderDetailsLoadedState({required this.orderModel});
}