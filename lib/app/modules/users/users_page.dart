import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_flutter/app/core/ui/base_state/base_state.dart';
import 'package:socket_flutter/app/modules/users/user_controller.dart';
import 'package:socket_flutter/app/modules/users/user_state.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends BaseState<UsersPage, UserController> {
  @override
  void onReady() async {
    // await SharedPreferences.getInstance().then((value) => value.clear());
    controller.loadUsers();
    controller.bindSocket(socket: context.read());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('USUARIOS'),
        ),
        body: BlocBuilder<UserController, UserState>(builder: (_, state) {
          return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  leading: Text(user.id.toString()),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              });
        }));
  }
}
