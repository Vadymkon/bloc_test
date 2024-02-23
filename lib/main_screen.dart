import 'package:bloc_test/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(), // CAN MAKE START FUNC ..add(CounterIncEvent()),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: const MyHomePage(title: 'home page'),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(title),
            ),

            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('You have pushed the button this many times:'),
                    BlocBuilder<CounterBloc, int>( //Covered only Text, for re-rendering only text
                      // bloc: counterBloc,
                      builder: (context, state){
                      //final bloc = BlocProvider.of<CounterBloc>(context);(
                        return Text(
                        state.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,);
                      }
                    ),
                    BlocBuilder<UserBloc,UserState>(
                        // bloc: userBloc,
                      builder: (context, state) {
                        final users = state.users;
                        final jobs = state.jobs;
                        return Column(
                          children: [
                            if (state.isLoading)
                              const CircularProgressIndicator(),
                            if (users.isNotEmpty)
                              ...users.map((e) => Text(e.name)),
                            if (jobs.isNotEmpty)
                              ...jobs.map((e) => Text(e.name)),
                          ],
                        );
                      },

                    ),
                    ElevatedButton(onPressed: (){
                      final counterBloc = BlocProvider.of<CounterBloc>(context);
                      counterBloc.add(CounterDecEvent());
                    }, child: const Text('DECREMENT')),
                    ElevatedButton(onPressed: (){
                      // userBloc.add(UserGetUserEvent(counterBloc.state));
                    }, child: const Icon(Icons.person)),
                    ElevatedButton(onPressed: (){
                      // userBloc.add(UserGetUserJobsEvent(counterBloc.state));
                    }, child: const Icon(Icons.work)),
                  ],
                ),
              ),
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // counterBloc.add(CounterIncEvent());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),

);
  }
}
