import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_pizza_app/app_view.dart';
import 'package:flutter_pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_pizza_app/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';

import 'package:user_repository/user_repository.dart';
import 'package:pizza_repository/pizza_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final PizzaRepo pizzaRepository;

  const MyApp({
    super.key,
    required this.userRepository,
    required this.pizzaRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(value: userRepository),
        RepositoryProvider<PizzaRepo>.value(value: pizzaRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(userRepository: userRepository),
          ),
          BlocProvider<GetPizzaBloc>(
            create: (_) =>
                GetPizzaBloc(pizzaRepository)
                  ..add(GetPizza()), // sende event ismi farklıysa değiştir
          ),
        ],
        child: const MyAppView(),
      ),
    );
  }
}
