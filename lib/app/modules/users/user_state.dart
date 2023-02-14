// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:socket_flutter/app/models/user.dart';

enum UserStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class UserState extends Equatable {
  final UserStateStatus status;
  final List<User> users;
  final String? errorMessage;

  const UserState({
    required this.status,
    required this.users,
    this.errorMessage,
  });

  const UserState.initial()
      : status = UserStateStatus.initial,
        users = const [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, users, errorMessage];

  UserState copyWith({
    UserStateStatus? status,
    List<User>? users,
    String? errorMessage,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
