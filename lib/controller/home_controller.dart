import 'package:flutter/material.dart';
import 'package:lesson6/controller/auth_controller.dart';

import '../view/home_screen.dart';

class HomeController {
  HomeState state;
  HomeController(this.state);

  Future<void> signOut() async {
    await firebaseSignOut();
  }

  void onLongPress(int index) {}

  void onCreate() {
    state.callSetState(() {
      state.model.createInProgress = true;
    });
  }

  void onCancel() {
    // state.callSetState(() {
    Navigator.of(state.context).pop();
    // });
  }

  void onConfirm() {}
}
