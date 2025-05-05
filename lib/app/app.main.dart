import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_repository/authentication_repository.export.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/repositories/authentication.dart';
import 'package:rt_mobile/data/services/authentication/register.dart';
import 'package:rt_mobile/data/services/authentication/session.dart';
import 'package:rt_mobile/presentation/app/cubit/bottom_nav.dart';

import 'package:rt_mobile/presentation/authentication/bloc/bloc.dart';
import 'package:rt_mobile/presentation/authentication/forgot_password/bloc/bloc.dart';
import 'package:rt_mobile/presentation/authentication/login/bloc/bloc.dart';
import 'package:rt_mobile/presentation/authentication/login/view/export.dart';
import 'package:rt_mobile/presentation/authentication/register/bloc/bloc.dart';
import 'package:user_repository/user_repository.export.dart';

import '../presentation/home/page.dart';

part 'app.view.dart';
part 'app.router.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  late final AuthenticationRepositoryy _authenticationRepositoryy;

  @override
  void initState() {
    super.initState();

    final dioClient = Dio(BaseOptions(baseUrl: BASE_URL));

    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
    _authenticationRepositoryy = AuthenticationRepositoryy(
      registerService: RegisterService(dio: dioClient),
      sessionService: SessionService(dio: dioClient),
    );
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /** 
      RepositoryProvider is a Flutter BLoC "InheritableWidget",
      used to provide a repository for the child widget tree.
    */
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create:
              (_) => AuthenticationBloc(
                authenticationRepository: _authenticationRepository,
                userRepository: _userRepository,
              )..add(AuthenticationSubscriptionRequested()),
        ),
        BlocProvider(
          create:
              (_) => LoginBloc(
                authenticationRepositoryy: _authenticationRepositoryy,
                authenticationRepository: _authenticationRepository,
              ),
        ),
        BlocProvider(
          create:
              (_) => RegisterBloc(
                authenticationRepository: _authenticationRepositoryy,
              ),
        ),
        BlocProvider(create: (_) => ForgotPasswordBloc()),
      ],
      child: AppRouter(),
    );
  }
}
