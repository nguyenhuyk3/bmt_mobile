import 'package:flutter/material.dart';
import 'package:rt_mobile/core/utils/convetors/color.dart';

part 'film_info.dart';
part 'order_detail.dart';
part 'payment_methods.dart';

class SelectingPaymentMethod extends StatelessWidget {
  const SelectingPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MovieInfoCard(),

                  SizedBox(height: 16),

                  _OrderDetailsCard(),

                  SizedBox(height: 16),

                  _PaymentMethodsSection(),
                ],
              ),
            ),
          ),

          _PaymentButton(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Thanh toán',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}

class _OrderDetailsCard extends StatelessWidget {
  const _OrderDetailsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent, width: 1),
      ),
      child: Column(
        children: [
          SizedBox(height: 8),
          _OrderDetailRow(label: 'Ghế', value: 'H7, H8'),
          SizedBox(height: 12),
          Divider(color: Colors.grey[700]),
          SizedBox(height: 8),
          _OrderDetailRow(
            label: 'Tổng tiền',
            value: '189.000 VND',
            isBold: true,
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
        ),
      ],
    );
  }
}

class _PaymentMethodsSection extends StatelessWidget {
  const _PaymentMethodsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phương thức thanh toán',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        _PaymentMethodsList(),
      ],
    );
  }
}

class _PaymentMethodsList extends StatelessWidget {
  const _PaymentMethodsList();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent, width: 1),
      ),
      child: Column(
        children: [
          _PaymentOption(
            title: 'ZaloPay',
            iconPath: 'assets/zalopay.png',
            value: 'ZaloPay',
          ),
          _Divider(),
          _PaymentOption(
            title: 'MoMo',
            iconPath: 'assets/momo.png',
            value: 'MoMo',
          ),
          _Divider(),
          _PaymentOption(
            title: 'ShopeePay',
            iconPath: 'assets/shopeepay.png',
            value: 'ShopeePay',
            isSelected: true,
          ),
          _Divider(),
          _PaymentOption(
            title: 'ATM Card',
            iconPath: 'assets/atm.png',
            value: 'ATM',
          ),
          _Divider(),
          _PaymentOption(
            title: 'International payments',
            iconPath: 'assets/visa.png',
            value: 'International',
            subtitle: 'Visa, Master, JCB, Amex',
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final String iconPath;
  final String value;
  final bool isSelected;
  final String? subtitle;

  const _PaymentOption({
    required this.title,
    required this.iconPath,
    required this.value,
    this.isSelected = false,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange.withOpacity(0.1) : Colors.transparent,
        border: isSelected ? Border.all(color: Colors.amber, width: 1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: getPaymentMethodColor(value),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: _PaymentMethodIcon(method: value)),
        ),
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
        subtitle:
            subtitle != null
                ? Text(
                  subtitle!,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                )
                : null,
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[400],
          size: 16,
        ),
        onTap: () {},
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey[800],
      height: 1,
      indent: 16,
      endIndent: 16,
    );
  }
}

class _PaymentMethodIcon extends StatelessWidget {
  final String method;

  const _PaymentMethodIcon({required this.method});

  @override
  Widget build(BuildContext context) {
    Widget icon;

    switch (method) {
      case 'ZaloPay':
        icon = Text(
          'Z',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        );
        break;
      case 'MoMo':
        icon = Text(
          'M',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        );
        break;
      case 'ShopeePay':
        icon = Icon(Icons.shopping_bag, color: Colors.white, size: 20);
        break;
      case 'ATM':
        icon = Icon(Icons.credit_card, color: Colors.white, size: 20);
        break;
      case 'International':
        icon = Icon(Icons.payment, color: Colors.white, size: 20);
        break;
      default:
        icon = Icon(Icons.payment, color: Colors.white, size: 20);
    }

    return icon;
  }
}

class _PaymentButton extends StatelessWidget {
  const _PaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: ElevatedButton(
        onPressed: () {
          // Handle payment
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          'Thanh toán',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
