import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class InstructionArsenalUser {
  InstructionArsenalUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

InstructionArsenalUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<InstructionArsenalUser>
InstructionArsenalUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
    ? TimerStream(true, const Duration(seconds: 1))
    : Stream.value(user))
    .map<InstructionArsenalUser>((user) =>
currentUser = InstructionArsenalUser(user));