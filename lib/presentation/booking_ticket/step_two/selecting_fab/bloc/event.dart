part of 'bloc.dart';

sealed class SelectingFABEvent extends Equatable {
  const SelectingFABEvent();

  @override
  List<Object> get props => [];
}

class SelectingFABLoadFoodItems extends SelectingFABEvent {}

class SelectingFABAddToCart extends SelectingFABEvent {
  final FABProduct item;

  const SelectingFABAddToCart(this.item);

  @override
  List<Object> get props => [item];
}

class SelectingFABRemoveFromCart extends SelectingFABEvent {
  final CartItem cartItem;

  const SelectingFABRemoveFromCart(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class SelectingFABClearCart extends SelectingFABEvent {}

class SelectingFABProcessOrder extends SelectingFABEvent {}
