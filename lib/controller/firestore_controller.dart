import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lesson6/model/inventory_model.dart';

const inventoryCollection = 'inventory';

addInventory({required Inventory inventory}) async {
  FirebaseFirestore.instance
      .collection(inventoryCollection)
      .add(inventory.toFirestoreDoc());
}
