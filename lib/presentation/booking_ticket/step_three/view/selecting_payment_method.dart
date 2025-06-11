import 'package:flutter/material.dart';
import 'package:rt_mobile/core/utils/convetors/color.dart';

class SelectingPaymentMethodScreen extends StatefulWidget {
  const SelectingPaymentMethodScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<SelectingPaymentMethodScreen> {
  String selectedPaymentMethod = 'ShopeePay';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.transparent, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 120,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF8B0000),
                                  Color(0xFFFF4500),
                                  Color(0xFFFFD700),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Stack(
                              children: [
                                // Background pattern
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: RadialGradient(
                                        center: Alignment.center,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.3),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Avengers logo simulation
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shield,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'AVENGERS',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      Text(
                                        'INFINITY WAR',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(width: 16),

                        // Movie Details - Updated layout
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8, 12, 0, 10),
                            height: 140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Movie Title
                                Text(
                                  'Avengers: Infinity War',
                                  style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // Movie Details with Icons
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.movie_creation_outlined,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Action, adventure, sci-fi',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Vincom Ocean Park CGV',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '10.12.2022 • 14:15',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Order detail
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.transparent, width: 1),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ghế',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'H7, H8',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12),

                        Divider(color: Colors.grey[700]),

                        SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng tiền',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '189.000 VND',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Payment methods
                  Text(
                    'Phương thức thanh toán',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12),

                  Container(
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
                  ),
                ],
              ),
            ),
          ),

          // Continue Button
          Container(
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
    super.key,
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
