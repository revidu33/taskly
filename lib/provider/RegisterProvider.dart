import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskly/services/db/updateDB.dart';

class RegisterProvider with ChangeNotifier {
  String? _name;
  String? _email;
  String? _password;
  bool isLoading = false;

  String? get name => _name;
  String? get email => _email;
  String? get password => _password;

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    _name = name;
    _email = email;
    _password = password;
    if (await UpdateDB.isEmailRegistered(email)) {
      isLoading = false;
      return false;
    } else {
      UpdateDB.create(name, name, email, password);
      notifyListeners();
      return true;
    }
  }
}
