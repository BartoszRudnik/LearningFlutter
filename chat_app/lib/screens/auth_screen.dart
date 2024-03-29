import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  var _isLoading = false;

  void _submitAuthForm(String email, String password, String username, bool isLogin, BuildContext ctx, File userImage) async {
    AuthResult authResult;
    try {
      setState(() {
        this._isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        final imageRef = FirebaseStorage.instance.ref().child('user_image').child(authResult.user.uid + '.jpg');

        await imageRef.putFile(userImage).onComplete;

        final imageUrl = await imageRef.getDownloadURL();

        await Firestore.instance.collection('users').document(authResult.user.uid).setData(
          {
            'username': username,
            'email': email,
            'image_url': imageUrl,
          },
        );
      }
    } on PlatformException catch (error) {
      var message = 'An error occurred, please check your credentials';

      print(email);
      print(password);

      if (error.message != null) {
        message = error.message;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );

      setState(() {
        this._isLoading = false;
      });
    } catch (error) {
      setState(() {
        this._isLoading = false;
      });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submitForm: this._submitAuthForm,
        isLoading: this._isLoading,
      ),
    );
  }
}
