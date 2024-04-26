import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson6/controller/auth_controller.dart';
import 'package:lesson6/controller/home_controller.dart';
import 'package:lesson6/model/inventory_model.dart';

import '../model/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen> {
  late TextEditingController controller;
  late HomeController con;
  late HomeModel model;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = HomeController(this);
    model = HomeModel(currentUser!);
    con.loadInventoryList();
    con.loadInventoryNameList();
  }

  void callSetState(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: bodyView(),
      drawer: drawerView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Add a New Item'),
          content: Form(
            key: formKey,
            child: TextFormField(
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Name'),
              validator: model.validateTitle,
              onSaved: model.onSavedTitle,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  con.save();
                  con.loadInventoryList();
                  con.loadInventoryNameList();
                },
                child: const Text('Create')),
            TextButton(
                onPressed: () {
                  con.onCancel();
                },
                child: const Text('Cancel')),
          ],
        ),
      );

  Widget bodyView() {
    if (model.inventoryList == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return showInventoryList();
    }
  }

  Widget showInventoryList() {
    if (model.inventoryList!.isEmpty) {
      return Center(
        child: Text(
          'No Inventory Found!',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: model.inventoryList!.length,
        itemBuilder: (BuildContext context, int index) {
          Inventory inventory = model.inventoryList![index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  selected: model.selectedIndex == index,
                  selectedColor: Colors.redAccent[100],
                  subtitle: index == model.selectedIndex
                      ? selectedIcon(
                          model.inventoryList![index].quantity, inventory)
                      : null,
                  title:
                      Text('${inventory.title} (qty: ${inventory.quantity}) '),
                  tileColor: Colors.pink[200],
                  textColor: Colors.white,
                  onLongPress: () => con.onLongPress(index),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Widget selectedIcon(String quantity, Inventory inventory) {
    int numberquantity = int.parse(quantity);
    if (model.isEdit == false) {
      model.tempQuantity = numberquantity;
      model.isEdit = true;
    }

    return Row(
      children: [
        IconButton(
          onPressed: model.tempQuantity > 0 ? con.minus : null,
          icon: const Icon(Icons.remove),
          color: Colors.red,
        ),
        const SizedBox(width: 8),
        Text('${model.tempQuantity}'),
        IconButton(
          onPressed: con.add,
          icon: const Icon(Icons.add),
          color: Colors.purple,
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () {
            if (model.tempQuantity == 0) {
              con.delete();
              return;
            }
            con.update(inventory);
            con.loadInventoryList();
            con.loadInventoryNameList();
          },
          icon: const Icon(Icons.check),
          color: Colors.purple,
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: con.cancel,
          icon: const Icon(Icons.cancel),
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget drawerView(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: const Text('No profile'),
          accountEmail: Text(model.user.email!),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Sign Out'),
          onTap: con.signOut,
        ),
      ],
    ));
  }
}
