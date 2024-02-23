import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = CounterBloc();

    return BlocProvider<CounterBloc>(
      create: (context) => bloc, // CAN MAKE START FUNC ..add(CounterIncEvent()),
      child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(title),
            ),

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('You have pushed the button this many times:'),
                  BlocBuilder<CounterBloc, int>( //Covered only Text, for re-rendering only text
                    bloc: bloc,
                    builder: (context, state){
                    //final bloc = BlocProvider.of<CounterBloc>(context);(
                      return Text(
                      state.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,);
                    }
                  ),
                  ElevatedButton(onPressed: (){
                    bloc.add(CounterDecEvent());
                  }, child: const Text('DECREMENT'))
                ],
              ),
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                bloc.add(CounterIncEvent());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
      );
  }
}
