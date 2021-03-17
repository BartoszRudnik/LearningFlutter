import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../exception/httpException.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return this._userId;
  }

  String get token {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && this._token != null) {
      return this._token;
    }
    return null;
  }

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDXOcJO7h7WP5XqTg-kRqHzD3z3sd_uEBs';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      this._token = responseData['idToken'];
      this._userId = responseData['localId'];
      this._expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );

      _autoLogout();
      notifyListeners();
      final preferences = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': this._token,
          'userId': this._userId,
          'expiryDate': this._expiryDate.toIso8601String(),
        },
      );
      preferences.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final getPrefs = await SharedPreferences.getInstance();

    if (!getPrefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData = json.decode(getPrefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    this._token = extractedUserData['token'];
    this._userId = extractedUserData['userId'];
    this._expiryDate = expiryDate;

    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    this._token = null;
    this._userId = null;
    this._expiryDate = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();

    final userPreferences = await SharedPreferences.getInstance();
    userPreferences.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final timeToExpire = this._expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(
      Duration(seconds: timeToExpire),
      logout,
    );
  }
}
