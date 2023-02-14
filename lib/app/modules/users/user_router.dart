import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_flutter/app/modules/users/user_controller.dart';
import 'package:socket_flutter/app/modules/users/users_page.dart';
import 'package:socket_flutter/app/repository/user_repository.dart';

class UserRouter {
  UserRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => UserRepository(rest: context.read()),
          ),
          Provider(
            create: (context) => UserController(
              repository: context.read(),
            ),
          ),
        ],
        builder: (context, child) {
          return const UsersPage();
        },
      );
}
