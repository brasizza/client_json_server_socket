// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:socket_flutter/app/core/rest_client/custom_dio.dart';
import 'package:socket_flutter/app/models/user.dart';

class UserRepository {
  final CustomDio rest;
  UserRepository({
    required this.rest,
  });

  Future<List<User>?> getUsers() async {
    final response = await rest.get('/users');
    return (response.data as List).map((e) => User.fromMap(e)).toList();
  }
}
