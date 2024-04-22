import 'package:flutter/material.dart';
import 'package:lesson6/controller/auth_controller.dart';
import 'package:lesson6/controller/firestore_controller.dart';
import 'package:lesson6/model/inventory_model.dart';
import 'package:lesson6/view/createinventory_screen.dart';
import 'package:lesson6/view/show_snackbar.dart';

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
    // Navigator.of(state.context).pop();
    // });
  }

  void onSave() {
    // Navigator.of(context).pop(controller.text);
  }
  Future<void> save() async {
    try {
      state.callSetState(
          () => state.model.progressMessage = 'Saving PhotoMemo ...');
      state.model.tempInventory.createdBy = state.model.user.email!;
      String docId = await addInventory(inventory: state.model.tempInventory);
      state.model.tempInventory.docId = docId;
      state.callSetState(() => state.model.progressMessage = null);
    } catch (e) {
      state.callSetState(() => state.model.progressMessage = null);
      print('************** Save photomemo erro $e');
      if (state.mounted) {
        showSnackbar(
          context: state.context,
          message: 'Save photomemo error $e',
          seconds: 10,
        );
      }
    }
  }

  Future<void> gotoCreateInventory() async {
    final inventory = await Navigator.pushNamed(
        state.context, CreateInventoryScreen.routeName);
    if (inventory == null) {
      // create screen canceled by BACK button
      // return;
    }
    var newInventory = inventory as Inventory;
    state.callSetState(() {
      state.model.inventoryList!.insert(
        0,
        newInventory,
      );
    });

    // void gotoCreateInventory() {
    //   Navigator.pushNamed(state.context, CreateInventoryScreen.routeName);
    // }
  }
}
