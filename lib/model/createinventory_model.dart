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
      quantity: '1',
    );
  }

  void onSavedTitle(String? value) {
    if (value != null) {
      String lowerCaseString = value.toLowerCase();
      tempInventory.title = lowerCaseString;
    }
  }
}
