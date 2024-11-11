import 'dart:io';

import 'package:doc_saver_app/common/app_theme_data.dart';
import 'package:doc_saver_app/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? selectedImage;
  late HomeProvider homeProvider;

  @override
  void initState() {
    homeProvider = HomeProvider();
    super.initState();
  }

  @override
  void dispose() {
    homeProvider.homePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('checkkk build home');
    context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('DocSaver'),
      ),
      body: PageView(
        controller: homeProvider.homePageController,
        onPageChanged: homeProvider.onHomePageSelected,
        children: [
          selectedImage != null
              ? Column(
                  children: [
                    Image.file(selectedImage!),
                  ],
                )
              : const Text('No image'),
          const Text('page 2'),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(CupertinoIcons.doc_plaintext), label: 'Documents'),
          NavigationDestination(icon: Icon(Icons.privacy_tip_outlined), label: 'Passwords'),
        ],
        selectedIndex: homeProvider.selectedIndex,
        onDestinationSelected: homeProvider.onHomePageSelected,
      ),
      floatingActionButton: homeProvider.selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _onAddDocument,
              child: const Icon(CupertinoIcons.plus),
            )
          : null,
    );
  }

  _onAddDocument() async => showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: _onUploadFromGallery,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                    child: Icon(
                      Icons.add_photo_alternate,
                      color: AppThemeData.primaryColor,
                    ),
                  ),
                  const Text(
                    'Upload from Gallery',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: _onScanWithCamera,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: AppThemeData.primaryColor,
                    ),
                  ),
                  const Text(
                    'Scan with Camera',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _onUploadFromGallery() async {
    Navigator.of(context).pop();

    final ImagePicker picker = ImagePicker();

    // Step 1: Pick image from gallery or camera
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); // or ImageSource.camera for camera

    if (image != null) {
      // Step 2: Crop the selected image
      final croppedFile = await ImageCropper().cropImage(sourcePath: image.path, uiSettings: [
        AndroidUiSettings(
          activeControlsWidgetColor: AppThemeData.primaryColor,
          lockAspectRatio: false,
          toolbarColor: AppThemeData.primaryColor,
          statusBarColor: AppThemeData.primaryColor,
          //toolbarWidgetColor: AppThemeData.primaryColor,
        )
      ]);

      if (croppedFile != null) {
        // Step 3: Get a directory path to save the cropped image
        final directory = await getApplicationDocumentsDirectory();
        final String newPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}_DocSaver_image.png';

        // Step 4: Save the cropped image
        final File savedImage = await File(croppedFile.path).copy(newPath);

        print('Cropped image saved to $newPath');
      } else {
        print('Image cropping canceled');
      }
    } else {
      print('No image selected');
    }
  }

  _onScanWithCamera() async {
    Navigator.of(context).pop();

    final ImagePicker picker = ImagePicker();

    // Step 1: Pick image from gallery or camera
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); // or ImageSource.camera for camera

    if (image != null) {
      // Step 2: Crop the selected image
      final croppedFile = await ImageCropper().cropImage(sourcePath: image.path, uiSettings: [
        AndroidUiSettings(
          activeControlsWidgetColor: AppThemeData.primaryColor,
          lockAspectRatio: false,
          toolbarColor: AppThemeData.primaryColor,
          statusBarColor: AppThemeData.primaryColor,
        )
      ]);

      if (croppedFile != null) {
        // Step 3: Get a directory path to save the cropped image
        final directory = await getApplicationDocumentsDirectory();
        final String newPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}_DocSaver_image.png';

        // Step 4: Save the cropped image
        final File savedImage = await File(croppedFile.path).copy(newPath);

        print('Cropped image saved to $newPath');
      } else {
        print('Image cropping canceled');
      }
    } else {
      print('No image selected');
    }
  }
}
