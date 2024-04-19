import 'dart:async';

import 'package:untitled1/db_helper/repository.dart';
import 'package:untitled1/model/user.dart';

class UserService
{
  late Repository _repository;
  UserService(){
    _repository = Repository();
  }
  //Save User
  Future SaveUser(User user) async => await _repository.insertData('users', user.userMap());
  //Read All Users
  readAllUsers() async{
    return await _repository.readData('users');
  }
  //Edit User
  Future UpdateUser(User user) async => await _repository.updateData('users', user.userMap());

  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }

}