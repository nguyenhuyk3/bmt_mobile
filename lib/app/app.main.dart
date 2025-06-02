import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/repositories/authentication.dart';
import 'package:rt_mobile/data/repositories/cinema.dart';
import 'package:rt_mobile/data/repositories/film.dart';
import 'package:rt_mobile/data/services/authentication/login.dart';
import 'package:rt_mobile/data/services/authentication/register.dart';
import 'package:rt_mobile/data/services/cinema/cinema.dart';
import 'package:rt_mobile/data/services/film/film.dart';
import 'package:rt_mobile/presentation/app/cubit/bottom_nav.dart';
import 'package:rt_mobile/presentation/authentication/forgot_password/bloc/bloc.dart';
import 'package:rt_mobile/presentation/authentication/register/bloc/bloc.dart';

part 'app.view.dart';
part 'app.router.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Authentication
  late final AuthenticationRepository _authenticationRepository;
  late final FilmRepository _filmRepository;
  late final CinemaRepository _cinemaRepository;
  // Authorization
  // late final AuthorizationRepository _authorizationRepository;

  @override
  void initState() {
    super.initState();

    final dioClient = Dio(BaseOptions(baseUrl: BASE_URL));

    _authenticationRepository = AuthenticationRepository(
      registerService: RegisterService(dio: dioClient),
      loginService: LoginService(dio: dioClient),
    );
    _filmRepository = FilmRepository(filmService: FilmService(dio: dioClient));
    _cinemaRepository = CinemaRepository(
      cinemaService: CinemaService(dio: dioClient),
    );

    // _authorizationRepository = AuthorizationRepository();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _filmRepository),
        RepositoryProvider.value(value: _cinemaRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create:
          //       (_) => AuthorizationBloc(
          //         authorizationRepository: _authorizationRepository,
          //       )..add(AuthorizationSubscriptionRequested()),
          // ),
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
