import 'package:bloc_test/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage ({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(title),
      ),

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              BlocBuilder<CounterBloc,
                  int>( //Covered only Text, for re-rendering only text
                  bloc: counterBloc,
                  builder: (context, state) {
                    // final bloc = BlocProvider.of<UserBloc>(context);
                    //   final bloc = context.watch<UserBloc>();
                    final bloc = context.select((UserBloc bloc) =>
                    bloc.state.jobs);
                    return Column(
                      children: [
                        Text(
                          state.toString(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium,),
                        if (bloc.isNotEmpty)
                          ...bloc.map((e) => Text(e.name)),
                      ],
                    );
                  }
              ),

              ElevatedButton(onPressed: () {
                // final counterBloc = context.read<CounterBloc>();
                counterBloc.add(CounterDecEvent());
              }, child: const Text('DECREMENT')),
              ElevatedButton(onPressed: () {
                // final counterBloc = context.read<CounterBloc>();
                final userBloc = context.read<UserBloc>();
                userBloc.add(UserGetUserEvent(counterBloc.state));
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) =>
                            BlocProvider.value(
                              value: userBloc,
                              child: Users(),
                            )
                    ));
              }, child: const Icon(Icons.person)),
              ElevatedButton(onPressed: () {
                // final counterBloc = context.read<CounterBloc>();
                final userBloc = context.read<UserBloc>();
                userBloc.add(UserGetUserJobsEvent(counterBloc.state));
              }, child: const Icon(Icons.work)),

            ],
          ),
        ),
      ),
      floatingActionButton: BlocConsumer<CounterBloc, int>(
        bloc: counterBloc,
        listenWhen: (prev,curr) => prev > curr, //optimization of listening
        listener: (context, state) {
          if (state == 0) {
            Scaffold.of(context).showBottomSheet
            ((context) =>
              Container
                (
                  height: 30,
                  width: double.infinity,
                  color: Colors.blue,
                  child: const Text('State is 0')));
          }
        },
        builder :(context,state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.toString()),
            FloatingActionButton(
              onPressed: () {
                // final counterBloc = context.read<CounterBloc>();
                counterBloc.add(CounterIncEvent());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}


class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserBloc, UserState>(
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
              // if (jobs.isNotEmpty)
              //   ...jobs.map((e) => Text(e.name)),
            ],
          );
        },
      ),
    );
  }
}
