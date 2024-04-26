import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson6/model/inventory_model.dart';

class HomeModel {
  User user;
  List<Inventory>? inventoryList;
  late Inventory tempInventory;
  List<String>? inventoryNameList;

  HomeModel(this.user) {
    tempInventory = Inventory(
      createdBy: '',
      title: '',
      quantity: '1',
    );
  }

  int? selectedIndex;
  String? progressMessage;
  int tempQuantity = 0;
  bool isEdit = false;

  void onSavedTitle(String? value) {
    if (value != null) {
      String lowerCaseString = value.toLowerCase();
      tempInventory.title = lowerCaseString;
    }
  }

  String? validateTitle(String? value) {
    if (value != null) {
      String lowerCaseString = value.toLowerCase();
      for (var name in inventoryNameList!) {
        if (name == lowerCaseString.trim()) {
          return '$name already exists';
        }
      }
    }

    return value == null || value.trim().length < 2 ? 'Title too short' : null;
  }

  Map<String, dynamic> toFirestoreDoc() {
    return {
      DocKeyPhotoMemo.title.name: tempInventory.title,
      DocKeyPhotoMemo.createdBy.name: tempInventory.createdBy,
      DocKeyPhotoMemo.quantity.name: tempInventory.quantity,
    };
  }
}
