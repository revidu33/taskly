import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:taskly/services/db/updateDB.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _email = '';

  bool get isLoggedIn => _isLoggedIn;
  String get email => email;

  void setEmail(String email) {
    _email = email;
  }

  Future<bool> login(String username, String password) async {
    await UpdateDB.read().then((snapshot) {
      snapshot.docs.forEach((document) {
        if (email == (document.data()['email']) &&
            UpdateDB.hashPassword(password) == (document.data()['password'])) {
          _isLoggedIn = true;

          return true;
        }
        return false;
      });
    });
    return false;

    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
