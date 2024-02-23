import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserGetUserEvent>(_onGetUser);
    on<UserGetUserJobsEvent>(_onGetUserJobs);
  }

  _onGetUser (UserGetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    List <User> users = List.generate(event.count, (index) => User(name: 'user name',id: index.toString() ));
    emit(state.copyWith(users: users));
  }

  _onGetUserJobs (UserGetUserJobsEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    List <Job> jobs = List.generate(event.count, (index) => Job(name: 'jobe',id: index.toString() ));
    emit(state.copyWith(jobs: jobs));
  }
}
