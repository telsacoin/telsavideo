import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  final String? uid;
  final String? userName;
  final String? emailId;
  final String? dateOfBirth;
  bool isDone;

  User(
      {this.uid,
      this.userName,
      this.emailId,
      this.dateOfBirth,
      this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
