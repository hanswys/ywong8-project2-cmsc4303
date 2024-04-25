import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson6/model/inventory_model.dart';

class EditInventory {
  final User user;
  final Inventory inventory;
  late Inventory tempInventory;

  EditInventory({required this.user, required this.inventory}) {
    tempInventory = inventory.clone();
  }
}
