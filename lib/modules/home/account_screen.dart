import 'package:flutter/material.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_cubit.dart';

Widget AccountScreen(context, controller) {
  return Scaffold(
    body: Center(
      child: TextButton(
        onPressed: () {
          StartingCubit.get(context).userLogOut();
          Navigator.pushNamedAndRemoveUntil(context, '/LoginScreen', (route) => false);
        },
        child: Text('Logout'),
      ),
    ),
  );
}
