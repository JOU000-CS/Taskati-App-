import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/functions/dialogs.dart';

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
                //go to home screen
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
                  hint: 'Enter your Name',
                  controller: nameController,
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
      setState(() {
        path = file.path;
      });
    }
  }
}
