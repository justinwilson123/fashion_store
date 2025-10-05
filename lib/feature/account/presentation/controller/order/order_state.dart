part of 'order_bloc.dart';

enum OrderOngoinStatus {
  loading,
  loaded,
  noData,
}

enum OrderCompletedStatus {
  loading,
  loaded,
  noData,
}

class OrderState extends Equatable {
  final List<OrderEntity> orderOngoing;
  final List<OrderEntity> orderCompleted;
  final OrderOngoinStatus orderOngoinStatus;
  final OrderCompletedStatus orderCompletedStatus;
  final int initIndex;
  final String errorMessage;
  final bool hasRechedMax;
  final bool loadingRating;
  final int indexStar;

  const OrderState({
    this.orderOngoing = const [],
    this.orderCompleted = const [],
    this.orderOngoinStatus = OrderOngoinStatus.loading,
    this.orderCompletedStatus = OrderCompletedStatus.loading,
    this.initIndex = 0,
    this.errorMessage = "",
    this.hasRechedMax = false,
    this.loadingRating = false,
    this.indexStar = 4,
  });

  OrderState copyWith({
    List<OrderEntity>? orderOngoing,
    List<OrderEntity>? orderCompleted,
    OrderOngoinStatus? orderOngoinStatus,
    OrderCompletedStatus? orderCompletedStatus,
    int? initIndex,
    String? errorMessage,
    bool? hasRechedMax,
    bool? loadingRating,
    int? indexStar,
  }) {
    return OrderState(
      orderOngoing: orderOngoing ?? this.orderOngoing,
      orderCompleted: orderCompleted ?? this.orderCompleted,
      orderOngoinStatus: orderOngoinStatus ?? this.orderOngoinStatus,
      orderCompletedStatus: orderCompletedStatus ?? this.orderCompletedStatus,
      initIndex: initIndex ?? this.initIndex,
      errorMessage: errorMessage ?? this.errorMessage,
      hasRechedMax: hasRechedMax ?? this.hasRechedMax,
      loadingRating: loadingRating ?? this.loadingRating,
      indexStar: indexStar ?? this.indexStar,
    );
  }

  @override
  List<Object> get props => [
        orderOngoing,
        orderCompleted,
        orderOngoinStatus,
        orderCompletedStatus,
        initIndex,
        hasRechedMax,
        loadingRating,
        indexStar,
      ];
}

final class OrderInitial extends OrderState {}
