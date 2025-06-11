import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/models/product/cart.dart';

import 'package:rt_mobile/data/models/product/fab.product.dart';

part 'event.dart';
part 'state.dart';

class SelectingFABBloc extends Bloc<SelectingFABEvent, SelectingFABState> {
  SelectingFABBloc() : super(const SelectingFABState()) {
    on<SelectingFABLoadFoodItems>(_onLoadFoodItems);
    on<SelectingFABAddToCart>(_onAddToCart);
    on<SelectingFABRemoveFromCart>(_onRemoveFromCart);
    on<SelectingFABClearCart>(_onClearCart);
    on<SelectingFABProcessOrder>(_onProcessOrder);
  }

  final List<FABProduct> _mockFABItems = [
    const FABProduct(
      id: '1',
      name: 'Bắp rang bơ lớn',
      type: 'Snack',
      imageUrl:
          'https://images.unsplash.com/photo-1578849278619-e73505e9610f?w=300',
      price: 85000,
    ),
    const FABProduct(
      id: '2',
      name: 'Coca Cola',
      type: 'Drink',
      imageUrl:
          'https://images.unsplash.com/photo-1561758033-d89a9ad46330?w=300',
      price: 45000,
    ),
    const FABProduct(
      id: '3',
      name: 'Combo Bắp + Nước',
      type: 'Combo',
      imageUrl:
          'https://images.unsplash.com/photo-1585647347483-22b66260dfff?w=300',
      price: 120000,
    ),
    const FABProduct(
      id: '4',
      name: 'Kẹo gấu Haribo',
      type: 'Snack',
      imageUrl:
          'https://images.unsplash.com/photo-1582058091505-f87a2e55a40f?w=300',
      price: 35000,
    ),
    const FABProduct(
      id: '5',
      name: 'Sprite',
      type: 'Drink',
      imageUrl:
          'https://images.unsplash.com/photo-1527960471264-932f39eb5846?w=300',
      price: 45000,
    ),
    const FABProduct(
      id: '6',
      name: 'Nachos phô mai',
      type: 'Snack',
      imageUrl:
          'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=300',
      price: 65000,
    ),
  ];

  FutureOr<void> _onLoadFoodItems(
    SelectingFABLoadFoodItems event,
    Emitter<SelectingFABState> emit,
  ) {
    emit(state.copyWith(isLoading: true));

    emit(state.copyWith(fABItems: _mockFABItems, isLoading: false));
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   emit(state.copyWith(fABItems: _mockFABItems, isLoading: false));
    // });
  }

  FutureOr<void> _onAddToCart(
    SelectingFABAddToCart event,
    Emitter<SelectingFABState> emit,
  ) {
    final currentCart = List<CartItem>.from(state.cart);
    final existingIndex = currentCart.indexWhere(
      (cartItem) => cartItem.fABProduct.id == event.item.id,
    );

    if (existingIndex >= 0) {
      currentCart[existingIndex] = currentCart[existingIndex].copyWith(
        quantity: currentCart[existingIndex].quantity + 1,
      );
    } else {
      currentCart.add(CartItem(fABProduct: event.item));
    }

    final totalAmount = _calculateTotal(currentCart);

    emit(state.copyWith(cart: currentCart, totalAmount: totalAmount));
  }

  FutureOr<void> _onRemoveFromCart(
    SelectingFABRemoveFromCart event,
    Emitter<SelectingFABState> emit,
  ) {
    final currentCart = List<CartItem>.from(state.cart);
    final cartItem = event.cartItem;

    if (cartItem.quantity > 1) {
      final index = currentCart.indexWhere(
        (item) => item.fABProduct.id == cartItem.fABProduct.id,
      );
      if (index >= 0) {
        currentCart[index] = cartItem.copyWith(quantity: cartItem.quantity - 1);
      }
    } else {
      currentCart.removeWhere(
        (item) => item.fABProduct.id == cartItem.fABProduct.id,
      );
    }

    final totalAmount = _calculateTotal(currentCart);

    emit(state.copyWith(cart: currentCart, totalAmount: totalAmount));
  }

  FutureOr<void> _onClearCart(
    SelectingFABClearCart event,
    Emitter<SelectingFABState> emit,
  ) {
    emit(state.copyWith(cart: [], totalAmount: 0.0, orderProcessed: false));
  }

  void _onProcessOrder(
    SelectingFABProcessOrder event,
    Emitter<SelectingFABState> emit,
  ) {
    emit(state.copyWith(orderProcessed: true));
  }

  double _calculateTotal(List<CartItem> cart) {
    return cart.fold(
      0.0,
      (sum, item) => sum + (item.fABProduct.price * item.quantity),
    );
  }
}
