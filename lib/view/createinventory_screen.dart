import 'package:flutter/material.dart';
import 'package:lesson6/controller/auth_controller.dart';
import 'package:lesson6/controller/createinventory_controller.dart';
import 'package:lesson6/model/createinventory_model.dart';
import 'package:lesson6/model/inventory_model.dart';

class CreateInventoryScreen extends StatefulWidget {
  const CreateInventoryScreen({super.key});

  static const routeName = '/CreateInventoryScreen';

  @override
  State<StatefulWidget> createState() {
    return CreateInventoryState();
  }
}

class CreateInventoryState extends State<CreateInventoryScreen> {
  late CreateInventoryModel model;
  late CreateInventoryController con;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    model = CreateInventoryModel(user: currentUser!);
    con = CreateInventoryController(this);
  }

  void callSetState(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                  autocorrect: true,
                  validator: Inventory.validateTitle,
                  onSaved: model.onSavedTitle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget photoPreview() {
  //   return Stack(
  //     children: [
  //       SizedBox(
  //         height: MediaQuery.of(context).size.height * 0.25,
  //         child: model.photo == null
  //             ? const FittedBox(
  //                 child: Icon(Icons.photo_library),
  //               )
  //             : (kIsWeb ? Image.memory(model.photo) : Image.file(model.photo)),
  //       ),
  //       Positioned(
  //         right: 0.0,
  //         bottom: 0.0,
  //         child: Container(
  //           color: Colors.blue[100],
  //           child: PopupMenuButton(
  //             onSelected: con.getPhoto,
  //             itemBuilder: (BuildContext context) {
  //               if (kIsWeb) {
  //                 return [
  //                   PopupMenuItem(
  //                     value: CameraOrGallery.gallery,
  //                     child: Text(CameraOrGallery.gallery.name.toUpperCase()),
  //                   )
  //                 ];
  //               } else {
  //                 return [
  //                   for (var source in CameraOrGallery.values)
  //                     PopupMenuItem(
  //                       value: source,
  //                       child: Text(source.name.toUpperCase()),
  //                     ),
  //                 ];
  //               }
  //             },
  //           ),
  //         ),
  //       ),
  //       if (model.progressMessage != null)
  //         Positioned(
  //           bottom: 0.0,
  //           left: 0.0,
  //           child: Container(
  //             color: Colors.blue[100],
  //             child: Text(
  //               model.progressMessage!,
  //               style: Theme.of(context).textTheme.titleMedium,
  //             ),
  //           ),
  //         )
  //     ],
  //   );
  // }
}
