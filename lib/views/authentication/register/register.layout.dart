import 'package:flutter/material.dart';

class RegisterLayout extends StatelessWidget {
  final Widget child;
  final bool allowBack;

  const RegisterLayout({
    super.key,
    required this.child,
    this.allowBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Đăng kí',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 21,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        elevation: 0.7,
        shadowColor: const Color(0xFFEFF3EA),
        backgroundColor: const Color(0xFFFBFBFB),
        automaticallyImplyLeading: allowBack,
        leading:
            allowBack
                ? Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black87,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
                : null,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: Divider(height: 0.1, thickness: 0.1, color: Colors.grey),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Expanded(child: child)],
        ),
      ),
    );
  }
}
