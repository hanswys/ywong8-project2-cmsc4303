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
      // .orderBy(DocKeyPhotoMemo.title)
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
