import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Added for kIsWeb
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data'; // Use for web images
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' if (dart.library.html) 'dart:html'; // Conditional import

class ImageUploadTest extends StatefulWidget {
  const ImageUploadTest({super.key});

  @override
  ImageUploadTestState createState() => ImageUploadTestState(); // Renamed to be public
}

class ImageUploadTestState extends State<ImageUploadTest> { // Renamed to public
  Uint8List? _webImage; // For web image
  File? _image; // For mobile image
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          if (kIsWeb) {
            // For Flutter Web
            pickedFile.readAsBytes().then((bytes) {
              setState(() {
                _webImage = bytes;
              });
            });
          } else {
            // For Mobile platforms
            _image = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      debugPrint('Image selection failed: $e'); // Replaced print
    }
  }

  Future<String?> _uploadImageToFirebase(dynamic imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('test_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      if (kIsWeb) {
        // For Web, use data in Uint8List form
        final uploadTask = storageRef.putData(imageFile);
        final taskSnapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        // For Mobile, upload the file directly
        final uploadTask = storageRef.putFile(imageFile);
        final taskSnapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();
        return downloadUrl;
      }
    } catch (e) {
      debugPrint('Error uploading image: $e'); // Replaced print
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload Test'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display image for both web and mobile
          _image == null && _webImage == null
              ? const Text('No image selected.')
              : kIsWeb && _webImage != null
                  ? Image.memory(_webImage!)
                  : _image != null
                      ? Image.file(_image!)
                      : const Text('No image selected.'), // Fallback
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Pick Image'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_image != null || _webImage != null) {
                final imageFile = kIsWeb ? _webImage : _image;
                final url = await _uploadImageToFirebase(imageFile!);
                if (url != null) {
                  debugPrint('Uploaded Image URL: $url'); // Replaced print
                }
              }
            },
            child: const Text('Upload to Firebase'),
          ),
        ],
      ),
    );
  }
}
