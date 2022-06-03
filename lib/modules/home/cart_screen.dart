import 'package:flutter/material.dart';

Widget CartScreen(context, controller) {
  return ListView.separated(
    itemBuilder: (context, index) => Row(),
    separatorBuilder: (context, index) => SizedBox(
      height: 10,
    ),
    itemCount: 10,
  );
}
