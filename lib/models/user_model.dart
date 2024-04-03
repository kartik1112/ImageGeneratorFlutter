import 'dart:typed_data';

class UserModel {
  final String name;
  final String email;
  final Uint8List image;
  UserModel(this.name, this.email, this.image);
}
