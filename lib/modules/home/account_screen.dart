
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_cubit.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_states.dart';
import '../../shared/cubit/app_cubit/app_cubit.dart';

Widget AccountScreen(context, controller) {
  return BlocConsumer<StartingCubit, StartingStates>(
      listener: (context, state) {},
      builder: (ctx, state) {
        StartingCubit cubit = StartingCubit.get(context);
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    cubit.updateProfile(context: context, isImage: true, pickImage: true);
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: userImage,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    StartingCubit.get(context).userLogOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/LoginScreen', (route) => false);
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        );
      }
  );
}
