import 'package:cet_hostel/models/user.dart';
import 'package:cet_hostel/resources/auth_methods.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getuser => _user!;
  Future<void> refreshuser() async {
    print("987");
    User user = await _authMethods.getUserdetails();
    print("78");
    _user = user;
    notifyListeners();
  }
}
