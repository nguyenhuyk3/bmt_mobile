import 'package:equatable/equatable.dart';

import 'package:rt_mobile/data/models/product/fab.product.dart';

class CartItem extends Equatable {
  final FABProduct fABProduct;
  final int quantity;

  const CartItem({required this.fABProduct, this.quantity = 1});

  CartItem copyWith({int? quantity}) {
    return CartItem(
      fABProduct: fABProduct,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [fABProduct, quantity];
}
