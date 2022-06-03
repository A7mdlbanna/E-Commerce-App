import 'package:flutter/material.dart';

import '../../models/home_model.dart';
import '../../shared/cubit/app_cubit/app_cubit.dart';

Widget FavScreen(context, controller) {

  AppCubit cubit = AppCubit.get(context);
  FavItems? favItems = cubit.favItems;
  return ListView.separated(
    itemBuilder: (context, index) => Row(
      children: [
        Image.network(favItems!.data!.data![index].product!.image),
        Column(
          children: [
            Text(favItems.data!.data![index].product!.name),
            Text('${favItems.data!.data![index].product!.price}'),
          ],
        ),

      ],
    ),
    separatorBuilder: (context, index) => SizedBox(
      height: 10,
    ),
    itemCount: 10,
  );
}
