part of 'bloc.dart';

class SelectingFABState extends Equatable {
  final List<FABProduct> fABItems;
  final List<CartItem> cart;
  final double totalAmount;
  final bool isLoading;
  final bool orderProcessed;
  final String? errorMessage;

  const SelectingFABState({
    this.fABItems = const [],
    this.cart = const [],
    this.totalAmount = 0.0,
    this.isLoading = false,
    this.orderProcessed = false,
    this.errorMessage,
  });

  SelectingFABState copyWith({
    List<FABProduct>? fABItems,
    List<CartItem>? cart,
    double? totalAmount,
    bool? isLoading,
    bool? orderProcessed,
    String? errorMessage,
  }) {
    return SelectingFABState(
      fABItems: fABItems ?? this.fABItems,
      cart: cart ?? this.cart,
      totalAmount: totalAmount ?? this.totalAmount,
      isLoading: isLoading ?? this.isLoading,
      orderProcessed: orderProcessed ?? this.orderProcessed,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    fABItems,
    cart,
    totalAmount,
    isLoading,
    orderProcessed,
    errorMessage,
  ];
}
