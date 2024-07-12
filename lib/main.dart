import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/provider/LoginProvider.dart';
import 'package:taskly/provider/RegisterProvider.dart';
import 'package:taskly/provider/TaskProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskly/screens/login.dart';
import 'package:taskly/screens/register.dart';
import 'package:taskly/screens/task.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskPage(),
    );
  }
}
