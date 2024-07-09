import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/models/user.dart';
import 'package:taskly/provider/LoginProvider.dart'; // Adjust the import to match your file structure

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 240, 171),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Container(
                width: MediaQuery.of(context).size.width,
                child: AvatarGlow(
                  startDelay: const Duration(milliseconds: 2000),
                  glowCount: 2,
                  glowColor: const Color.fromARGB(255, 199, 234, 180),
                  glowShape: BoxShape.circle,
                  animate: true,
                  child: const Material(
                    elevation: 25.0,
                    shape: CircleBorder(),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 120,
                      backgroundImage: AssetImage(
                        'lib/images/logo.png',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 50),
                      TextFormField(
                        cursorColor: Colors.white,
                        controller: _emailController,
                        style:
                            const TextStyle(color: Colors.white), // Text color
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle:
                              TextStyle(color: Colors.white), // Hint text color
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        style:
                            const TextStyle(color: Colors.white), // Text color
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle:
                              TextStyle(color: Colors.white), // Hint text color
                          border: OutlineInputBorder(),
                          fillColor: Color.fromARGB(255, 148, 33, 33),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Provider.of<LoginProvider>(context, listen: false)
                                .login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black), // Button text color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
