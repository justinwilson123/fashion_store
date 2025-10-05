part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class GetOrederOngoingEvent extends OrderEvent {
  const GetOrederOngoingEvent();
  @override
  List<Object> get props => [];
}

class GetOrederCompletedEvent extends OrderEvent {
  const GetOrederCompletedEvent();
  @override
  List<Object> get props => [];
}

class TranBetweenOngingCompletedEvent extends OrderEvent {
  final int index;
  const TranBetweenOngingCompletedEvent(this.index);
  @override
  List<Object> get props => [index];
}

class RefreshOrderCompletedEvent extends OrderEvent {
  const RefreshOrderCompletedEvent();
  @override
  List<Object> get props => [];
}

class RatingOrderEvent extends OrderEvent {
  final int productID;
  final String comment;
  final int orderID;
  final int colorID;
  final int sizeID;
  const RatingOrderEvent(
    this.productID,
    this.comment,
    this.orderID,
    this.colorID,
    this.sizeID,
  );
  @override
  List<Object> get props => [
        productID,
        comment,
        orderID,
        colorID,
        sizeID,
      ];
}

class ChangeStarRatingEvent extends OrderEvent {
  final int index;
  const ChangeStarRatingEvent(this.index);
  @override
  List<Object> get props => [index];
}
