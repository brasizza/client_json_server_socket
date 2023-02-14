import 'package:flutter/material.dart';
import 'package:socket_flutter/app/core/config/env.dart';
import 'package:socket_flutter/app/core/providers/application_binding.dart';
import 'package:socket_flutter/app/modules/home/home_page.dart';
import 'package:socket_flutter/app/modules/users/user_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  loadEnv();

  runApp(const MyApp());
}

void loadEnv() {
  Env.i.load();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const HomePage(),
          '/usuarios': (context) => UserRouter.page,
        },
      ),
    );
  }
}
