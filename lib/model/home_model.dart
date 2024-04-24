import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson6/model/inventory_model.dart';

class HomeModel {
  User user;
  List<Inventory>? inventoryList;
  HomeModel(this.user);
  int? selectedIndex;
  late Inventory tempInventory;
  String? progressMessage;
  int tempQuantity = 0;
  bool isEdit = false;

  void onSavedTitle(String? value) {
    if (value != null) {
      tempInventory.title = value;
    }
  }
}
