import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Firebase_StorageHelper {
  static Firebase_StorageHelper instance = Firebase_StorageHelper();
  final FirebaseStorage _firebaseFirestore = FirebaseStorage.instance;

  Future<String> upLoadImage(File image) async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    TaskSnapshot taskSnapshot =
        await _firebaseFirestore.ref(userID).putFile(image);
    String imageURL = await taskSnapshot.ref.getDownloadURL();
    return imageURL;
  }
}
