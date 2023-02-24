import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:socket_flutter/app/core/socket/socket_client.dart';
import 'package:socket_flutter/app/models/user.dart';
import 'package:socket_flutter/app/modules/users/user_state.dart';
import 'package:socket_flutter/app/repository/user_repository.dart';

class UserController extends Cubit<UserState> {
  final tableName = 'users';
  final UserRepository repository;

  UserController({required this.repository}) : super(const UserState.initial());

  void initial() {
    emit(const UserState.initial());
  }

  void sendData() => emit(state);

  void loadUsers() async {
    emit(state.copyWith(status: UserStateStatus.loading));

    final users = await repository.getUsers();

    emit(state.copyWith(status: UserStateStatus.loaded, users: users));
  }

  void bindSocket({required SocketClient socket}) {
    socket.addChannel('POST', tableName, (response) {
      final user = User.fromMap(response['payload']);
      try {
        if (!state.users.contains(user)) {
          emit(state.copyWith(status: UserStateStatus.loading));

          final users = state.users;
          users.add(user);

          emit(state.copyWith(status: UserStateStatus.loaded, users: users));
        }
      } catch (e, s) {
        log(e.toString(), error: e, stackTrace: s);
      }
    });

    socket.addChannel('DELETE', tableName, (response) {
      final deletedId = (response['payload']);
      try {
        final users = state.users;
        if (users.isNotEmpty) {
          emit(state.copyWith(status: UserStateStatus.loading));

          final indexUser = users.indexWhere((user) => user.id == deletedId['id']);
          if (indexUser != -1) {
            users.removeAt(indexUser);
          }
          emit(state.copyWith(status: UserStateStatus.loaded, users: users));
        }
      } catch (e, s) {
        log(e.toString(), error: e, stackTrace: s);
      }
    });

    socket.addChannel('PUT', tableName, (response) {
      final data = (response['payload']) as Map;
      try {
        final users = state.users;
        if (users.isNotEmpty) {
          emit(state.copyWith(status: UserStateStatus.loading));
          final indexUser = users.indexWhere((user) => user.id == data['id']);
          if (indexUser != -1) {
            final myUser = users[indexUser];
            users[indexUser] = myUser.copyWith(
              id: (data['id'] ?? myUser.id),
              name: (data['name'] ?? myUser.name),
              email: (data['email'] ?? myUser.email),
              password: (data['password'] ?? myUser.password),
            );

            emit(state.copyWith(status: UserStateStatus.loaded, users: users));
          }
        }
      } catch (e, s) {
        log(e.toString(), error: e, stackTrace: s);
      }
    });
    // socket.
  }
}
