
import 'package:suuq_iibiye/models/order.dart';

abstract class OrderState{}

class OrderInitialState extends OrderState{}

class OrderLoadingState extends OrderState{}

class OrderLoadedState extends OrderState{
  final List<OrderModel?> orderModelList;

  OrderLoadedState({required this.orderModelList});
}