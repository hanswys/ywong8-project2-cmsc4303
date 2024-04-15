import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson6/controller/auth_controller.dart';
import 'package:lesson6/controller/home_controller.dart';

import '../model/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen> {
  late HomeController con;
  late HomeModel model;
  @override
  void initState() {
    super.initState();
    con = HomeController(this);
    model = HomeModel(currentUser!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Text('test'),
      drawer: drawerView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('Add a New Item'),
                content: TextField(
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                actions: [
                  TextButton(onPressed: null, child: Text('Create')),
                  TextButton(onPressed: null, child: Text('Cancel')),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Widget bodyView() {
  //   if (model.photoMemoList == null) {
  //     return const Center(child: CircularProgressIndicator());
  //   } else {
  //     return showPhotoMemoList();
  //   }
  // }

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
