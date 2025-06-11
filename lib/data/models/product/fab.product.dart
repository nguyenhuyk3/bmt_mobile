import 'package:equatable/equatable.dart';

class FABProduct extends Equatable {
  final String id;
  final String name;
  final String type;
  final String imageUrl;
  final double price;

  const FABProduct({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object> get props => [id, name, type, imageUrl, price];
}
