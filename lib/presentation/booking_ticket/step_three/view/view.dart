import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rt_mobile/core/utils/convetors/color.dart';
import 'package:rt_mobile/presentation/booking_ticket/bloc/bloc.dart';
import 'package:rt_mobile/presentation/cubit/change_tab/change_tab.dart';

part 'film_info.dart';
part 'order_detail.dart';
part 'payment_methods.dart';

class StepThreeView extends StatelessWidget {
  const StepThreeView({super.key});

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
                  _FilmInfoCard(),

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
