part of 'home_bloc_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetGategoreisEvent extends HomeEvent {
  const GetGategoreisEvent();
  @override
  List<Object> get props => [];
}

class GetAllProductEvent extends HomeEvent {
  const GetAllProductEvent();
  @override
  List<Object> get props => [];
}

class AddToSavedHomeEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class RemoveFromSavedHomeEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class ChooseGategoryEvent extends HomeEvent {
  final int currntIndex;
  final int catergoryID;
  const ChooseGategoryEvent(this.currntIndex, this.catergoryID);
  @override
  List<Object> get props => [currntIndex, catergoryID];
}

class GetProductEvent extends HomeEvent {
  const GetProductEvent();
  @override
  List<Object> get props => [];
}

class ChooseFilterTypeEvent extends HomeEvent {
  final int currentIndex;
  const ChooseFilterTypeEvent(this.currentIndex);
  @override
  List<Object> get props => [currentIndex];
}

class RangeSliderFilterEvent extends HomeEvent {
  final double rangeValueStart;
  final double rangeValueEnd;
  const RangeSliderFilterEvent(this.rangeValueStart, this.rangeValueEnd);
  @override
  List<Object> get props => [rangeValueStart, rangeValueEnd];
}

class GetMaxPriceAllProductEvent extends HomeEvent {
  const GetMaxPriceAllProductEvent();
  @override
  List<Object> get props => [];
}

class GetMaxPriceProductEvent extends HomeEvent {
  const GetMaxPriceProductEvent();
  @override
  List<Object> get props => [];
}

class ApplayFilterEvnet extends HomeEvent {
  const ApplayFilterEvnet();
  @override
  List<Object> get props => [];
}

class MapSavedProductEvent extends HomeEvent {
  final int productID;
  final int isSaved;
  const MapSavedProductEvent(this.productID, this.isSaved);
  @override
  List<Object> get props => [productID, isSaved];
}

class AddRemoveFromMapSavedProductEvent extends HomeEvent {
  final int productID;
  final int value;
  const AddRemoveFromMapSavedProductEvent(this.productID, this.value);
  @override
  List<Object> get props => [productID, value];
}

class ShowAndHideAppBar extends HomeEvent {
  final bool showHide;
  const ShowAndHideAppBar(this.showHide);
  @override
  List<Object> get props => [showHide];
}
