import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_flutter/app/core/config/env.dart';
import 'package:socket_flutter/app/core/socket/socket_client.dart';

import '../rest_client/custom_dio.dart';

class ApplicationBinding extends StatelessWidget {
  final Widget child;

  const ApplicationBinding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CustomDio(),
        ),
        Provider(create: (context) => SocketClient()..init(ip: Env.i['url_socket'] ?? '', port: Env.i['port_socket'].toString())),
      ],
      child: child,
    );
  }
}
