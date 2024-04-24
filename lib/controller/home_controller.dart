import 'package:flutter/material.dart';
import 'package:lesson6/controller/auth_controller.dart';
import 'package:lesson6/controller/firestore_controller.dart';
import 'package:lesson6/model/inventory_model.dart';
import 'package:lesson6/view/show_snackbar.dart';

import '../view/home_screen.dart';

class HomeController {
  HomeState state;
  HomeController(this.state);

  Future<void> signOut() async {
    await firebaseSignOut();
  }

  void onLongPress(int index) {
    state.callSetState(() {
      if (state.model.selectedIndex == null ||
          state.model.selectedIndex != index) {
        state.model.selectedIndex = index;
        state.model.isEdit = false;
      } else {
        state.model.selectedIndex = null; // cancel selection
      }
    });
  }

  Future<void> save() async {
    print('con click');
    FormState? currentState = state.formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;

    currentState.save();
    try {
      // state.callSetState(
      //     () => state.model.progressMessage = 'Saving PhotoMemo ...');
      state.model.tempInventory.createdBy = state.model.user.email!;
      String docId = await addInventory(inventory: state.model.tempInventory);
      state.model.tempInventory.docId = docId;

      if (state.mounted) {
        Navigator.of(state.context).pop(state.model.tempInventory);
      }
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

  // Future<void> gotoCreateInventory() async {
  //   final inventory = await Navigator.pushNamed(
  //       state.context, CreateInventoryScreen.routeName);
  //   if (inventory == null) {
  //     return;
  //   }

  //   var newInventory = inventory as Inventory;
  //   state.callSetState(() {
  //     state.model.inventoryList!.insert(
  //       0,
  //       newInventory,
  //     );
  //   });

  //   state.callSetState(() {
  //     state.model.inventoryList!.sort((a, b) {
  //       return a.title.compareTo(b.title);
  //     });
  //   });
  // }

  void loadInventoryList() async {
    try {
      state.model.inventoryList =
          await getInventoryList(email: state.model.user.email!);
    } catch (e) {
      print('======== loading error: $e');
      if (state.mounted) {
        showSnackbar(
          context: state.context,
          message: 'Failed to load PhotoMemo list: $e',
          seconds: 10,
        );
      }
    } finally {
      state.callSetState(() {});
      // state.callSetState(() {
      //   state.model.inventoryList!.sort((a, b) {
      //     return a.title.compareTo(b.title);
      //   });
      // });
    }
  }

  void delete() {}

  void update() async {
    // Map<String, dynamic> fieldsToUpdate = {};

    // // tempInventory = Inventory.clone();
    // setUpdatedFields(fieldsToUpdate);

    // await updatePhotoMemo(
    //   // docId: state.model.docId!,
    //   update: fieldsToUpdate,
    // );
  }

  void setUpdatedFields(Map<String, dynamic> fieldsToUpdate) {
    fieldsToUpdate[DocKeyPhotoMemo.quantity.name] = state.model.tempQuantity;
    print('$DocKeyPhotoMemo.quantity.name');
  }

  void add() {
    state.callSetState(() {
      state.model.tempQuantity++;
      print('${state.model.tempQuantity}');
    });
  }

  void minus() {
    state.callSetState(() {
      state.model.tempQuantity--;
      print('${state.model.tempQuantity}');
    });
  }

  void cancel() {
    state.callSetState(() {
      state.model.selectedIndex = null; // cancel selection
    });
  }

  void onCancel() {
    Navigator.of(state.context).pop();
  }
}
