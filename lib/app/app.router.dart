  part of 'app.main.dart';

  class AppRouter extends StatelessWidget {
    final _navigatorKey = GlobalKey<NavigatorState>();

    NavigatorState get _navigator => _navigatorKey.currentState!;

    AppRouter({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        builder: (context, child) {
          return BlocListener<AuthorizationBloc, AuthorizationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthorizationStatus.authorized:
                  _navigator.pushAndRemoveUntil<void>(
                    HomeScreen.route(),
                    (route) => false,
                  );
                case AuthorizationStatus.unauthorized:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginScreen.route(),
                    (route) => false,
                  );
                case AuthorizationStatus.unknown:
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
