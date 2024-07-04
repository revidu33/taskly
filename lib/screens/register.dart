import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/provider/RegisterProvider.dart'; // Adjust import as per your file structure

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 240, 171),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<RegisterProvider>(
            builder: (context, registerProvider, _) {
              return Column(
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
                            controller: _usernameController,
                            style: const TextStyle(
                                color: Colors.white), // Text color
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(
                                  color: Colors.white), // Hint text color
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
                            cursorColor: Colors.white,
                            controller: _emailController,
                            style: const TextStyle(
                                color: Colors.white), // Text color
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(
                                  color: Colors.white), // Hint text color
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _passwordController,
                            style: const TextStyle(
                                color: Colors.white), // Text color
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(
                                  color: Colors.white), // Hint text color
                              border: OutlineInputBorder(),
                              fillColor: Color.fromARGB(255, 148, 33, 33),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _confirmPasswordController,
                            style: const TextStyle(
                                color: Colors.white), // Text color
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(
                                  color: Colors.white), // Hint text color
                              border: OutlineInputBorder(),
                              fillColor: Color.fromARGB(255, 148, 33, 33),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          registerProvider.isLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      bool registrationSuccessful =
                                          await registerProvider.register(
                                        _usernameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                      if (!registrationSuccessful) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Email or Username already registered'),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        color:
                                            Colors.black), // Button text color
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
