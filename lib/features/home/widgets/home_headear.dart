import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/profile/edit_profile_screen.dart';

class HomeHeadear extends StatefulWidget {
  const HomeHeadear({
    super.key,
  });

  @override
  State<HomeHeadear> createState() => _HomeHeadearState();
}

class _HomeHeadearState extends State<HomeHeadear> {
  String? imagePath;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    imagePath = LocalHelper.getData(LocalHelper.kimage);
    userName = LocalHelper.getData(LocalHelper.kname);
  }

  @override
  Widget build(BuildContext context) {

    bool imageExists = imagePath != null && imagePath!.isNotEmpty && File(imagePath!).existsSync();
    
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( "Hello, ${userName ?? 'User'}",  style: TextStyles.titleStyle(color: AppColors.primaryColor),),
              Text('Have a nice day' , style: TextStyles.bodyStyle(color: Colors.grey),)
            ],
          ),
        ),
        IconButton(onPressed: (){LocalHelper.changeTheme();}, icon: Icon(Icons.dark_mode , color: AppColors.OrangeColor,)),
        GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileScreen()),
            );
            _loadUserData();
            setState(() {});
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryColor,
            backgroundImage: imageExists
              ? FileImage(File(imagePath!))
              : const AssetImage(AppImages.emptyUser) as ImageProvider,
          ),
        ),
      ],
    );
  }
}