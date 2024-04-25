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

Future<List<String>> getInventoryDisplayNames({required String email}) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(inventoryCollection)
      .where(DocKeyPhotoMemo.createdBy.name, isEqualTo: email)
      .get();

  List<String> displayNames = [];

  for (var doc in querySnapshot.docs) {
    if (doc.data() != null) {
      var document = doc.data() as Map<String, dynamic>;
      var inventory = Inventory.fromFirestoreDoc(doc: document, docId: doc.id);
      displayNames.add(inventory.title);
    }
  }

  return displayNames;
}

Future<void> deleteDoc({required String docId}) async {
  await FirebaseFirestore.instance
      .collection(inventoryCollection)
      .doc(docId)
      .delete();
}

Future<void> updateInventory({
  required String docId,
  required Map<String, dynamic> update,
}) async {
  try {
    await FirebaseFirestore.instance
        .collection(inventoryCollection)
        .doc(docId)
        .update(update);
  } catch (e) {
    print('Error updating field: $e');
  }
}

  void delete({
  required String docId,
}) async{
     await FirebaseFirestore.instance
      .collection(inventoryCollection)
      .doc(docId)
      .delete();
  }