import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserGetUserEvent>(_onGetUser);
  }

  _onGetUser (UserGetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    await Future.delayed(Duration(seconds: 1));
    List <User> users = List.generate(event.count, (index) => User(name: 'user name',id: index.toString() ));
    emit(UserLoadedState(users));
  }
}
