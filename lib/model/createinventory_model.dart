import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson6/model/inventory_model.dart';

class CreateInventoryModel {
  User user;
  late Inventory tempInventory;
  String? progressMessage;

  CreateInventoryModel({required this.user}) {
    tempInventory = Inventory(
      createdBy: '',
      title: '',
      quantity: '0',
    );
  }

  void onSavedTitle(String? value) {
    if (value != null) {
      tempInventory.title = value;
    }
  }

  void onSavedQuantity(String? value) {
    if (value != null) {
      tempInventory.quantity = value;
    }
  }
}
