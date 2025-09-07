import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/navigation.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/functions/dialogs.dart';
import 'package:taskati/features/home/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String path = '';
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (path.isNotEmpty && nameController.text.isNotEmpty) {
                //save data to hive
               LocalHelper.putUserData(nameController.text, path);
                print('Name: ${LocalHelper.getData(LocalHelper.kname)}');
                print('Image: ${LocalHelper.getData(LocalHelper.kimage)}');
              
                pushWithReplacment(context, HomeScreen());
              } else if (path.isNotEmpty && nameController.text.isEmpty) {
                showErrorDialog(context, 'Please enter your name');
              } else if (path.isEmpty && nameController.text.isNotEmpty) {
                showErrorDialog(context, 'Please upload your image');
              } else {
                showErrorDialog(
                  context,
                  'Please enter your name and upload your image',
                );
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColors.primaryColor,
                  backgroundImage: path.isNotEmpty
                      ? FileImage(File(path))
                      : AssetImage(AppImages.emptyUser),
                ),
                Gap(20),
                MainButton(
                  onPressed: () async {
                    await uplaodImage(isCamera: true);
                  },
                  text: 'Upload From Camera',
                  width: 300,
                ),
                Gap(15),
                MainButton(
                  onPressed: () async {
                    await uplaodImage(isCamera: false);
                  },
                  text: 'Upload From Gallery',
                  width: 300,
                ),
                Gap(20),
                Divider(),
                Gap(20),
                CustomTextField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  hint: 'Enter your Name',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uplaodImage({required bool isCamera}) async {
    XFile? file = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (file != null) {
      // Copy the image to app's documents directory for permanent storage
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String fileName = 'user_profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String newPath = '${appDocDir.path}/$fileName';
      
      // Copy the file to permanent location
      final File newFile = await File(file.path).copy(newPath);
      
      setState(() {
        path = newFile.path;
      });
      
      print('Image copied to permanent location: $path');
    }
  }
}
