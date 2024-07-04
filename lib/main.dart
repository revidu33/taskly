import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/provider/RegisterProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskly/screens/register.dart';
import 'package:taskly/screens/task.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
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
