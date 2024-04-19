// lib/main.dart

import 'package:untitled1/model/user.dart';
import 'package:untitled1/screens/edituser.dart';
import 'package:untitled1/screens/adduser.dart';
import 'package:untitled1/screens/viewusers.dart';
import 'package:untitled1/services/userservice.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PI CRUD-Sqlite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userList = <User>[];
  final UserService _userService = UserService();

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  void getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    setState(() {
      _userList = users;
    });
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _deleteFormDialog(BuildContext context, int userId) {
    showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: const Text(
            'Você tem certeza que quer deletar',
            style: TextStyle(color: Colors.teal, fontSize: 20),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white, // foreground
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                var result = await _userService.deleteUser(userId);
                if (result != null) {
                  Navigator.pop(context);
                  getAllUserDetails();
                  _showSuccessSnackBar('Detalhes do usuário excluídos com sucesso');
                }
              },
              child: const Text('Excluir'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white, // foreground
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
      ),
      body: ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewUser(
                      user: _userList[index],
                    ),
                  ),
                );
              },
              leading: const Icon(Icons.person),
              title: Text(_userList[index].name ?? ''),
              subtitle: Text(_userList[index].contact ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUser(
                            user: _userList[index],
                          ),
                        ),
                      ).then((data) {
                        if (data != null) {
                          getAllUserDetails();
                          _showSuccessSnackBar('User Detail Updated Success');
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.teal,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _deleteFormDialog(context, _userList[index].id!);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUser(),
            ),
          ).then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar('User Detail Added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}