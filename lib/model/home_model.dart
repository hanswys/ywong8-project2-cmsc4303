import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson6/model/inventory_model.dart';

class HomeModel {
  User user;
  List<Inventory>? inventoryList;
  HomeModel(this.user);
  bool createInProgress = false;
  int? selectedIndex;
}
