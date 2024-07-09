import 'package:flutter/material.dart';
import 'package:taskly/models/user.dart';
import 'package:taskly/services/db/updateDB.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  User user = User();

  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String password) async {
    await UpdateDB.read().then((snapshot) {
      snapshot.docs.forEach((document) {
        if (email == (document.data()['email']) &&
            UpdateDB.hashPassword(password) == (document.data()['password'])) {
          _isLoggedIn = true;
          user.email = document.data()['email'];
          user.name = document.data()['first name'];

          return true;
        }
        return false;
      });
    });
    return false;
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
