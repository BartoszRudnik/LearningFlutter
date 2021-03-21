import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import 'screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
        primaryColor: Colors.teal,
        accentColor: Colors.indigo,
      ),
      home: StreamBuilder(
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return ChatScreen();
          } else {
            return AuthScreen();
          }
        },
        stream: FirebaseAuth.instance.onAuthStateChanged,
      ),
    );
  }
}
