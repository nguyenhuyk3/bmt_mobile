import 'package:authentication_repository/authorization_repository.export.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:authentication_repository/authentication_repository.export.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/repositories/authentication.dart';
import 'package:rt_mobile/data/services/authentication/register.dart';
import 'package:rt_mobile/data/services/authentication/session.dart';
import 'package:rt_mobile/presentation/app/cubit/bottom_nav.dart';
import 'package:rt_mobile/presentation/authorization/bloc/bloc.dart';
import 'package:rt_mobile/presentation/authentication/forgot_password/bloc/bloc.dart';
import 'package:rt_mobile/presentation/authentication/login/view/export.dart';
import 'package:rt_mobile/presentation/authentication/register/bloc/bloc.dart';
import 'package:rt_mobile/presentation/home/page.dart';

part 'app.view.dart';
part 'app.router.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final AuthorizationRepository _authorizationRepository;
  // late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();

    final dioClient = Dio(BaseOptions(baseUrl: BASE_URL));

    _authenticationRepository = AuthenticationRepository(
      registerService: RegisterService(dio: dioClient),
      sessionService: SessionService(dio: dioClient),
    );
    _authorizationRepository = AuthorizationRepository();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationRepository>.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (_) => AuthorizationBloc(
                  authorizationRepository: _authorizationRepository,
                ),
          ),
          BlocProvider(
            create:
                (_) => RegisterBloc(
                  authenticationRepository: _authenticationRepository,
                ),
          ),
          BlocProvider(create: (_) => ForgotPasswordBloc()),
        ],
        child: AppRouter(),
      ),
    );
  }
}
