part of 'saved_bloc.dart';

sealed class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object> get props => [];
}

class GetAllSavedProdutEvent extends SavedEvent {
  const GetAllSavedProdutEvent();
  @override
  List<Object> get props => [];
}

class AddToSavedProductEvent extends SavedEvent {
  final int productID;
  const AddToSavedProductEvent(this.productID);
  @override
  List<Object> get props => [productID];
}

class RemoveFromSavedProductEvent extends SavedEvent {
  final int productID;
  const RemoveFromSavedProductEvent(this.productID);
  @override
  List<Object> get props => [productID];
}

class RemoveAllSavedProductEvent extends SavedEvent {
  const RemoveAllSavedProductEvent();
  @override
  List<Object> get props => [];
}

class RefreshSavedProductEvent extends SavedEvent {
  const RefreshSavedProductEvent();
  @override
  List<Object> get props => [];
}

class AddToMapSavedEvent extends SavedEvent {
  final Map savedProduct;
  const AddToMapSavedEvent(this.savedProduct);
  @override
  List<Object> get props => [savedProduct];
}
