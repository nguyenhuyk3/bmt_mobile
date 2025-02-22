import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_transport_fe/bloc/register/bloc.dart';

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
        leading:
            allowBack
                ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
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

class NextStepButton extends StatelessWidget {
  final String text;
  final RegisterEvent event;
  final bool Function(RegisterState state) stateCondition;
  final Widget nextPage;
  final Key buttonKey;

  const NextStepButton({
    super.key,
    required this.text,
    required this.event,
    required this.stateCondition,
    required this.nextPage,
    required this.buttonKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (stateCondition(state)) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<RegisterBloc>(),
                    child: nextPage,
                  ),
            ),
          );
        }
      },
      child: ElevatedButton(
        key: buttonKey,
        onPressed: () => context.read<RegisterBloc>().add(event),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFF54C392)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: const BorderSide(color: Colors.transparent, width: 1),
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            Size(double.infinity, MediaQuery.of(context).size.height * 0.06),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
