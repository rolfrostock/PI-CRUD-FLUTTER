import 'dart:async';

import 'package:untitled1/db_helper/repository.dart';
import 'package:untitled1/model/user.dart';

class UserService {
  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

  // Salva o usuário e retorna o objeto User
  Future<User> SaveUser(User user) async {
    int userId = await _repository.insertData('users', user.userMap());
    var result = await _repository.readDataById('users', userId);
    return User.fromMap(result.first);  // Assumindo que você tem um método de fábrica `fromMap` no modelo User
  }

  // Lê todos os usuários
  Future<List<User>> readAllUsers() async {
    var result = await _repository.readData('users');
    return result.map((item) => User.fromMap(item)).toList();
  }

  // Atualiza um usuário
  Future<int> UpdateUser(User user) async {
    return await _repository.updateData('users', user.userMap());
  }

  // Deleta um usuário pelo ID
  deleteUser(int userId) async {
    return await _repository.deleteDataById('users', userId);
  }
}
