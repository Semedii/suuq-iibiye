import 'package:suuq_iibiye/models/order.dart';

abstract class OrderHistoryState{}

class OrderHistoryInitialState extends OrderHistoryState{}

class OrderHistoryLoadingState extends OrderHistoryState{}

class OrderHistoryLoadedState extends OrderHistoryState{
  final List<OrderModel?> orderModelList;

  OrderHistoryLoadedState({required this.orderModelList});
}