// ignore_for_file: avoid_print

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
    FormState? currentState = state.formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;

    currentState.save();
    try {
      state.model.tempInventory.createdBy = state.model.user.email!;
      String docId = await addInventory(inventory: state.model.tempInventory);
      state.model.tempInventory.docId = docId;

      if (state.mounted) {
        Navigator.of(state.context).pop(state.model.tempInventory);
      }
      state.callSetState(() => state.model.progressMessage = null);
    } catch (e) {
      state.callSetState(() => state.model.progressMessage = null);
      if (state.mounted) {
        showSnackbar(
          context: state.context,
          message: 'Save inventory error $e',
          seconds: 10,
        );
      }
    }
  }

  void loadInventoryList() async {
    try {
      state.model.inventoryList =
          await getInventoryList(email: state.model.user.email!);
    } catch (e) {
      print('======== loading error: $e');
      if (state.mounted) {
        showSnackbar(
          context: state.context,
          message: 'Failed to load Inventory list: $e',
          seconds: 10,
        );
      }
    } finally {
      state.callSetState(() {
        state.model.inventoryList!.sort((a, b) {
          return a.title.compareTo(b.title);
        });
      });
    }
  }

  void loadInventoryNameList() async {
    state.model.inventoryNameList =
        await getInventoryDisplayNames(email: state.model.user.email!);
  }

  void update(Inventory inventory) async {
    String quantity = state.model.tempQuantity.toString();

    await updateInventory(
      docId: inventory.docId!,
      update: {
        'quantity': quantity,
      },
    );
    state.callSetState(() {
      state.model.isEdit = false;
      state.model.selectedIndex = null;
    });
  }

  void setUpdatedFields(Map<String, dynamic> fieldsToUpdate) {
    fieldsToUpdate[DocKeyPhotoMemo.quantity.name] = state.model.tempQuantity;
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
      state.model.selectedIndex = null;
    });
  }

  void onCancel() {
    Navigator.of(state.context).pop();
  }

  Future<void> delete() async {
    Inventory p = state.model.inventoryList![state.model.selectedIndex!];
    try {
      await deleteDoc(docId: p.docId!);
      state.callSetState(() {
        state.model.inventoryList!.removeAt(state.model.selectedIndex!);
        state.model.selectedIndex = null;
        state.model.isEdit = false;
      });
    } catch (e) {
      state.callSetState(() {
        state.model.selectedIndex = null;
        state.model.isEdit = false;
      });
      print('========= delete failed $e');
      if (state.mounted) {
        showSnackbar(
          context: state.context,
          message: 'Delete failed: $e',
        );
      }
    }
  }
}
