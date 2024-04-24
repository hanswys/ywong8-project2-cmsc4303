import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lesson6/model/inventory_model.dart';

const inventoryCollection = 'inventory';

Future<String> addInventory({required Inventory inventory}) async {
  DocumentReference ref = await FirebaseFirestore.instance
      .collection(inventoryCollection)
      .add(inventory.toFirestoreDoc());
  return ref.id;
}

Future<List<Inventory>> getInventoryList({required String email}) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(inventoryCollection)
      .where(DocKeyPhotoMemo.createdBy.name, isEqualTo: email)
      .get();
  var result = <Inventory>[];
  for (var doc in querySnapshot.docs) {
    if (doc.data() != null) {
      var document = doc.data() as Map<String, dynamic>;
      var p = Inventory.fromFirestoreDoc(doc: document, docId: doc.id);
      result.add(p);
    }
  }

  return result;
}

// Future<void> displayInventoryNames({required String email}) async {
//   List<Inventory> inventoryList = await getInventoryList(email: email);
//   // Extract titles from the inventory items
//   // List<String> inventoryNames =
//   //     inventoryList.map((item) => item.title).toList();
//   state.model.inventoryNameList =
//       inventoryList.map((item) => item.title).toList();

//   // Display the inventory names
//   print('Inventory Names:');
//   for (var name in inventoryNames) {
//     print(name);
//   }
// }

// Future<void> updatePhotoMemo({
//   required String docId,
//   required Map<String, dynamic> update,
// }) async {
//   await FirebaseFirestore.instance
//       .collection(inventoryCollection)
//       .doc(docId)
//       .update(update);
// }
