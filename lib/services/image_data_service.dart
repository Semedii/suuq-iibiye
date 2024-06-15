import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageDataService {
  final storageRef = FirebaseStorage.instance.ref();

  uploadImage(
    List<XFile?> imageFiles,
    List<String> ids,
  ) async {
    for (int i = 0; i < imageFiles.length; i++) {
      final imageRef = storageRef.child("images/products/${ids[i]}.jpg");
      File selectedImagePath = File(imageFiles[i]!.path);
      await imageRef.putFile(selectedImagePath);
    }
  }

  Future<String> retrieveImageUrl(id) async {
    final imageRef = storageRef.child("images/products/$id.jpg");
    var url = await imageRef.getDownloadURL();
    return url;
  }

  Future<void> deleteImage(List<String?> ids) async {
    if (ids.isEmpty) return;
    for (String? id in ids) {
      if (id == null) return;
      Uri uri = Uri.parse(id);
      String filename = uri.pathSegments.last;
      final imageRef = storageRef.child("images/products/$filename");
      await imageRef.delete();
    }
  }
}
