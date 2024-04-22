import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson6/model/inventory_model.dart';

class CreateInventory {
  User user;
  late Inventory tempInventory;
  String? progressMessage;

  CreateMemoModel({required this.user}) {
    tempInventory = Inventory(
      createdBy: '',
      name: '',
      quantity: 0,
    );
  }

  void onSavedName(String? value) {
    if (value != null) {
      tempInventory.name = value;
    }
  }

  void onSavedQuantity(int? value) {
    if (value != null) {
      tempInventory.quantity = value;
    }
  }
}
