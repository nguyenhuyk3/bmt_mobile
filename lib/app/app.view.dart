part of 'app.main.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      initialRoute: LOGIN_PAGE,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case LOGIN_PAGE:
            return MaterialPageRoute(builder: (context) => LoginPage());
          case REGISTER_STEP_ONE:
            return MaterialPageRoute(builder: (context) => StepThreePage());
          default:
            return MaterialPageRoute(builder: (context) => SplashPage());
        }
      },
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
      // onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
