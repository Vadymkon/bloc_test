import 'package:bloc_test/search_bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
final users = context.select((SearchBloc bloc) => bloc.state.users);

    return Scaffold(
      body: Column(
        children: [
          const Text('Search User'),

          IconButton(onPressed: () => {
            Navigator.push(context,
            MaterialPageRoute(builder: (_) => MyHomePage2(title: 'OAO',)))},
              icon: Icon(Icons.backup_table)),

          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'User name',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              context.read<SearchBloc>().add(SearchUserEvent(value));
            },
          ),
            if (users.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users[index]['username']),
                  );
                },
                itemCount: users.length,
              ),
            ),
        ],
      ),
    );
  }
}