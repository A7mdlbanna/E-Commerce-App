
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_cubit.dart';
import '../../shared/cubit/app_cubit/app_cubit.dart';

Widget AccountScreen(context, controller) {
  AppCubit cubit = AppCubit.get(context);
  return Scaffold(
    body: Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              cubit.changePic(await ImagePicker().pickImage(source: ImageSource.gallery));
            },
            child: CircleAvatar(
              radius: 70,
              backgroundImage: userImage,
            ),
          ),
          TextButton(
            onPressed: () {
              StartingCubit.get(context).userLogOut();
              Navigator.pushNamedAndRemoveUntil(context, '/LoginScreen', (route) => false);
            },
            child: Text('Logout'),
          ),
        ],
      ),
    ),
  );
}
