part of 'view.dart';

class _OrderDetailsCard extends StatelessWidget {
  const _OrderDetailsCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTicketBloc, BookingTicketState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.transparent, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OrderDetailRow(
                label: 'Ghế',
                value: extractSeatNumber(seats: state.seats),
              ),

              SizedBox(height: 12),

              // Hiển thị FAB items nếu có
              if (state.fABs.isNotEmpty) ...[
                Divider(color: Colors.grey[700]),
                SizedBox(height: 8),

                Text(
                  'Đồ ăn & Thức uống',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                // Danh sách FAB items
                ...state.fABs
                    .map((cartItem) => _FABOrderItemCard(cartItem: cartItem))
                    .toList(),

                SizedBox(height: 8),
              ],

              Divider(color: Colors.grey[700]),

              SizedBox(height: 8),

              _OrderDetailRow(
                label: 'Tổng tiền',
                value: formatCurrency(state.totalAmount),
                isBold: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FABOrderItemCard extends StatelessWidget {
  final CartItem cartItem;

  const _FABOrderItemCard({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // fab image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              cartItem.fABProduct.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[600],
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                );
              },
            ),
          ),

          SizedBox(width: 12),

          // fab infor
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.fABProduct.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 6),

                Text(
                  '${cartItem.fABProduct.price.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} VNĐ',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // quantity
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amberAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'x${cartItem.quantity}',
              style: TextStyle(
                color: Colors.amberAccent,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _OrderDetailRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTicketBloc, BookingTicketState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }
}
