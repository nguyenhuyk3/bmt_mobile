import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_transport_fe/bloc/bloc.dart';

import 'package:user_repository/user_repository.dart';

import '../views/home/page.dart';
import '../views/login/page.dart';
import '../views/spash_view.dart';

part 'app.view.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _authenticationRepository.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /** 
      RepositoryProvider is a Flutter BLoC "InheritableWidget",
      used to provide a repository for the child widget tree.
    */
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        lazy: false,
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        )..add(
            AuthenticationSubscriptionRequested(),
          ),
        child: const AppView(),
      ),
    );
  }
}
