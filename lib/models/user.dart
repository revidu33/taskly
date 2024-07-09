import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String? _email;
  String? _name;
  String? _password;

  String? get email => _email;
  String? get password => _password;
  set email(String? email) {
    _email = email;
    notifyListeners();
  }

  set name(String? name) {
    _name = name;
    notifyListeners();
  }

  set password(String? newPassword) {
    _password = newPassword;
    notifyListeners();

    void login(String username, String password) {
      _email = username;
      _password = password;
      notifyListeners();
    }
  }
}
