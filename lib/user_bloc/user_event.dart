part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserGetUserEvent extends UserEvent {
  final int count;

  UserGetUserEvent(this.count);
}