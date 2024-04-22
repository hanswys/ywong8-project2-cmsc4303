import 'package:flutter/material.dart';
import 'package:lesson6/controller/auth_controller.dart';
import 'package:lesson6/view/createinventory_screen.dart';

import '../view/home_screen.dart';

class HomeController {
  HomeState state;
  HomeController(this.state);

  Future<void> signOut() async {
    await firebaseSignOut();
  }

  void onLongPress(int index) {}

  void onCancel() {
    // state.callSetState(() {
    Navigator.of(state.context).pop();
    // });
  }

  void onSave() {}

  Future<void> gotoCreateInventory() async {
    final inventory = await Navigator.pushNamed(
        state.context, CreateInventoryScreen.routeName);
    if (inventory == null) {
      // create screen canceled by BACK button
      return;
    }
    // var newMemo = memo as PhotoMemo;
    // state.callSetState(() {
    //   state.model.photoMemoList!.insert(
    //     0,
    //     newMemo,
    //   );
    // });
  }
}
