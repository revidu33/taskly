import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class UpdateDB {
  static List<String> docsID = [];
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future create(String firstName, String secondName, String email,
      String password) async {
    await FirebaseFirestore.instance.collection('account').add({
      'first name': firstName,
      'second name': secondName,
      'email': email,
      'password': hashPassword(password),
    });
  }

  static Future read() async {
    final result = await FirebaseFirestore.instance.collection('account').get();
    return result;
  }

  static Future<bool> isEmailRegistered(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('account')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isNotEmpty;
  }
}
