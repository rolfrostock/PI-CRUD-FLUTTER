// lib/model/user.dart

class User {
  int? id;
  String? name;
  String? contact;
  String? description;

  User({this.id, this.name, this.contact, this.description});

  factory User.fromMap(Map<String, dynamic> data) => User(
    id: data['id'],
    name: data['name'],
    contact: data['contact'],
    description: data['description'],
  );

  Map<String, dynamic> userMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'description': description,
    };
  }
}
