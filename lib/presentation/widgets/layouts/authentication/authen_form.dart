import 'package:flutter/material.dart';
import 'package:rt_mobile/presentation/authentication/login/view/export.dart';

class AuthenForm extends StatelessWidget {
  final Widget child;
  final bool allowBack;
  final String title;

  const AuthenForm({
    super.key,
    required this.child,
    this.allowBack = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        elevation: 0.7,
        shadowColor: const Color(0xFFEFF3EA),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: allowBack,
        leading:
            allowBack
                ? Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed:
                        () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        ),
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
