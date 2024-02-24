import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../counter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CounterBloc counterBloc;
  late final StreamSubscription counterBlocSubscription;

  UserBloc(this.counterBloc) : super( UserState()) {
    on<UserGetUserEvent>(_onGetUser);
    on<UserGetUserJobsEvent>(_onGetUserJobs);
    counterBlocSubscription = counterBloc.stream.listen((state) {
      if (state <= 0)
        {
          add( UserGetUserEvent(0) );
          add( UserGetUserJobsEvent(0) );
        }
    });
  }


  @override
  Future<void> close() async {
    counterBlocSubscription.cancel();
    return super.close();
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
