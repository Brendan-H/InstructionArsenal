/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (user_provider.dart) Last Modified on 12/28/22, 3:20 PM
 *
 */

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