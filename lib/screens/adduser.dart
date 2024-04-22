// lib/screens/adduser.dart

import 'package:untitled1/model/user.dart';
import 'package:untitled1/screens/viewusers.dart';
import 'package:untitled1/services/userservice.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _userNameController = TextEditingController();
  final _userContactController = TextEditingController();
  final _userDescriptionController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  final _userService=UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PI CRUD-SQLite"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Novo Usuario',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Entre com o Nome',
                    labelText: 'Nome',
                    errorText:
                    _validateName ? 'Nome não pode estar vazio' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userContactController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Entre com Contato',
                    labelText: 'Contato',
                    errorText: _validateContact
                        ? 'Contato não pode estar vazio'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userDescriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Entre com Descrição',
                    labelText: 'Descrição',
                    errorText: _validateDescription
                        ? 'Descrição não pode estar vazio'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,  // Changed from 'primary' to 'foregroundColor'
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _userContactController.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                          _userDescriptionController.text.isEmpty
                              ? _validateDescription = true
                              : _validateDescription = false;
                        });

                        if (!_validateName && !_validateContact && !_validateDescription) {
                          var user = User();
                          user.name = _userNameController.text;
                          user.contact = _userContactController.text;
                          user.description = _userDescriptionController.text;

                          var savedUser = await _userService.SaveUser(user);

                          Navigator.pushReplacement( // Use pushReplacement para substituir a tela atual na pilha
                            context,
                            MaterialPageRoute(builder: (context) => ViewUser(user: savedUser)),
                          );
                        }
                      },

                      child: const Text('Salvar')
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,  // Changed from 'primary' to 'foregroundColor'
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _userNameController.text = '';
                        _userContactController.text = '';
                        _userDescriptionController.text = '';
                      },
                      child: const Text('Limpar')
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}