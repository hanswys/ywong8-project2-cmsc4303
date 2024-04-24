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

  @override
  void initState() {
    super.initState();
    con = HomeController(this);
    model = HomeModel(currentUser!);
    con.loadInventoryList();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
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
        onPressed: con.gotoCreateInventory,
        // async {
        //   final name = await openDialog();

        //   // print('${name}');
        // },
        // con.gotoCreateInventory,
        // print('click');
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: const Text('Add a New Item'),
        //       content: const TextField(
        //         decoration: InputDecoration(hintText: 'Name'),
        //       ),
        //       actions: [
        //         TextButton(onPressed: submit, child: Text('Create')),
        //         TextButton(
        //             onPressed: con.onCancel, child: const Text('Cancel')),
        //       ],
        //     );
        //   },
        // );
        child: const Icon(Icons.add),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Add a New Item'),
          content: TextFormField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Name'),
            // controller: controller,
            validator: Inventory.validateTitle,
            onSaved: model.onSavedTitle,
          ),
          actions: [
            TextButton(onPressed: con.save, child: Text('Create')),
            TextButton(onPressed: onCancel, child: Text('Cancel')),
          ],
        ),
      );

  void submit() {
    Navigator.of(context).pop(controller.text);
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

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
              ListTile(
                selected: model.selectedIndex == index,
                selectedColor: Colors.redAccent[100],
                subtitle: index == model.selectedIndex
                    ? selectedIcon(model.inventoryList![index].quantity)
                    : null,
                title: Text('${inventory.title} (qty: ${inventory.quantity}) '),
                tileColor: Colors.green,
                onLongPress: () => con.onLongPress(index),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      );
    }
  }

  Widget selectedIcon(String quantity) {
    int numberquantity = int.parse(quantity);
    if (model.isEdit == false) {
      model.tempQuantity = numberquantity;
      model.isEdit = true;
    }

    return Row(
      children: [
        IconButton(
          onPressed: model.tempQuantity > 0 ? con.minus : null,
          icon: Icon(Icons.remove),
          color: Colors.red,
        ),
        SizedBox(width: 8),
        Text('${model.tempQuantity}'),
        IconButton(
          onPressed: con.add,
          icon: Icon(Icons.add),
          color: Colors.purple,
        ),
        SizedBox(width: 12),
        IconButton(
          onPressed: () {
            // con.save;
          },
          icon: Icon(Icons.check),
          color: Colors.purple,
        ),
        SizedBox(width: 12),
        IconButton(
          onPressed: () {
            // con.cancel
          },
          icon: Icon(Icons.cancel),
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
