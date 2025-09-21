import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/core/functions/dialogs.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? imagePath;
  var nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    imagePath = LocalHelper.getData(LocalHelper.kimage);
    nameController.text = LocalHelper.getData(LocalHelper.kname) ?? '';
  }

  Future<void> _updateProfileImage() async {
    try {
      final source = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.light 
              ? Colors.white 
              : Colors.grey[900],
          title: Text(
            'Select Image Source',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light 
                  ? Colors.black 
                  : Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).brightness == Brightness.light 
                      ? Colors.black 
                      : Colors.white,
                ),
                title: Text(
                  'Camera',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light 
                        ? Colors.black 
                        : Colors.white,
                  ),
                ),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Theme.of(context).brightness == Brightness.light 
                      ? Colors.black 
                      : Colors.white,
                ),
                title: Text(
                  'Gallery',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light 
                        ? Colors.black 
                        : Colors.white,
                  ),
                ),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      );

      if (source != null) {
        final XFile? file = await ImagePicker().pickImage(source: source);
        
        if (file != null) {
          final Directory appDocDir = await getApplicationDocumentsDirectory();
          final String fileName = 'user_profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final String newPath = '${appDocDir.path}/$fileName';
          
          final File newFile = await File(file.path).copy(newPath);
          
          setState(() {
            imagePath = newFile.path;
          });
          
          print('Profile image updated: ${newFile.path}');
        }
      }
    } catch (e) {
      print('Error updating profile image: $e');
    }
  }

  void _updateProfile() {
    if (nameController.text.isNotEmpty) {
      LocalHelper.putUserData(nameController.text, imagePath ?? '');

      Navigator.pop(context);
    } else {
      showErrorDialog(context, 'Please enter your name');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool imageExists = imagePath != null && imagePath!.isNotEmpty && File(imagePath!).existsSync();
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.wb_sunny_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(60),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: AppColors.primaryColor,
                    backgroundImage: imageExists
                        ? FileImage(File(imagePath!))
                        : const AssetImage(AppImages.emptyUser) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _updateProfileImage,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(40),
              Container(
                height: 1,
                color: Colors.grey[300],
                margin: EdgeInsets.symmetric(horizontal: 20),
              ),
              Gap(40),
              CustomTextField(
                controller: nameController,
                hint: 'Enter your Name',
              ),
              Gap(60),
              MainButton(
                onPressed: _updateProfile,
                text: 'Update Your Name',
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
