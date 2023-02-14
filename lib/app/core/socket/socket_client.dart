import 'dart:convert';
import 'dart:developer';
import 'dart:io';

class SocketClient {
  Socket? socket;

  Map<String, Function> channels = {};
  // Avoid self isntance

  init({required String ip, required String port}) async {
    if (ip != '' && port != '') {
      try {
        socket = await Socket.connect(ip, int.parse(port), timeout: const Duration(seconds: 5));
        if (socket != null) {
          socket!.listen(
            (data) {
              Map<String, dynamic> serverResponse = jsonDecode(String.fromCharCodes(data));
              if (serverResponse.containsKey('method') && serverResponse.containsKey('table')) {
                final String key = serverResponse['method'] + serverResponse['table'];
                if (channels.containsKey(key)) {
                  channels[key]!(serverResponse);
                }
              }
            },
          );
        }
      } catch (e, s) {
        log('Socket server is not reachable: $e', error: e, stackTrace: s);
      }
    }
  }

  addChannel(String method, String table, Function(dynamic) f) {
    String key = method + table;
    if (!channels.containsKey(key)) {
      channels[key] = f;
    }
  }
}
