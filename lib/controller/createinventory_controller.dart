import 'package:flutter/material.dart';
import 'package:lesson6/view/createinventory_screen.dart';
import 'package:lesson6/view/show_snackbar.dart';

class CreateInventoryController {
  CreateInventoryState state;

  CreateInventoryController(this.state);

  // Future<void> save() async {
  //   FormState? currentState = state.formKey.currentState;
  //   if (currentState == null) return;
  //   if (!currentState.validate()) return;
  //   currentState.save();

  //   try {
  //     var (filename, downloadURL) = await uploadPhotoFile(
  //       photo: state.model.photo,
  //       uid: state.model.user.uid,
  //       photoMimeType: state.model.photoMimeType,
  //       listener: (int progress) {
  //         state.callSetState(() {
  //           if (progress == 100) {
  //             state.model.progressMessage = null;
  //           } else {
  //             state.model.progressMessage = 'Uploading: $progress %';
  //           }
  //         });
  //       },
  //     );
  //     state.callSetState(
  //         () => state.model.progressMessage = 'Saving PhotoMemo ...');
  //     state.model.tempInventory.photoURL = downloadURL;
  //     state.model.tempInventory.createdBy = state.model.user.email!;
  //     state.model.tempMemo.timestamp = DateTime.now();
  //     String docId = await addPhotoMemo(photoMemo: state.model.tempMemo);
  //     state.model.tempMemo.docId = docId;
  //     if (state.mounted) {
  //       Navigator.of(state.context).pop(state.model.tempMemo);
  //     }
  //   } catch (e) {
  //     state.callSetState(() => state.model.progressMessage = null);
  //     print('************** Save photomemo erro $e');
  //     if (state.mounted) {
  //       showSnackbar(
  //         context: state.context,
  //         message: 'Save photomemo error $e',
  //         seconds: 10,
  //       );
  //     }
  //   }
  // }
}
