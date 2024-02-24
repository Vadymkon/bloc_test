import 'package:bloc_test/search_bloc/search_bloc.dart';
import 'package:bloc_test/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';
import 'main_screen.dart';
import 'new_main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (
              context) => counterBloc, // CAN MAKE START FUNC ..add(CounterIncEvent()),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(counterBloc),
          lazy: false,
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyText2: TextStyle(fontSize: 33),
            subtitle1: TextStyle(fontSize: 22),),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
