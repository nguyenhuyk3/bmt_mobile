part of 'app.main.dart';

class AppRouter extends StatelessWidget {
  /*
    Concept: GlobalKey<NavigatorState>(): is a global key that allows you to access and control the Navigator directly,
    from anywhere in the code, without the need for a BuildContext.
    Purpose of use:
    - Control the Navigator directly (eg: push, pop, pushAndRemoveUntil,...)
  */
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(navigatorKey: _navigatorKey, home: AppView());
  }
}
