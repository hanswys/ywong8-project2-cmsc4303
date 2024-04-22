import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lesson6/model/inventory_model.dart';

const inventoryCollection = 'inventory';

Future<String> addInventory({required Inventory inventory}) async {
  DocumentReference ref = await FirebaseFirestore.instance
      .collection(inventoryCollection)
      .add(inventory.toFirestoreDoc());
  return ref.id;
}
