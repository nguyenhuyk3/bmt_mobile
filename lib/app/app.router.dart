  part of 'app.main.dart';

  class AppRouter extends StatelessWidget {
    final _navigatorKey = GlobalKey<NavigatorState>();

    NavigatorState get _navigator => _navigatorKey.currentState!;

    AppRouter({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    HomePage.route(),
                    (route) => false,
                  );
                case AuthenticationStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                    (route) => false,
                  );
                case AuthenticationStatus.unknown:
                  break;
              }
            },
            child: child,
          );
        },
        home: AppView(),
      );
    }
  }
