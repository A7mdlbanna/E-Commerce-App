import 'package:flutter/material.dart';

import '../../models/home_model.dart';
import '../../shared/cubit/app_cubit/app_cubit.dart';

Widget FavScreen(context, controller) {

  AppCubit cubit = AppCubit.get(context);
  FavItems? favItems = cubit.favItems;
  return favItems!.data!.data.isEmpty
    ? Center(child: Text('there are no saved items, go and save some', style: TextStyle(color: Colors.grey.shade400, fontSize: 16),),)
    : ListView.separated(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(favItems.data!.data[index].product!.image, height: 100, width: 100,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(favItems.data!.data[index].product!.name, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 10,),
                      Text('EGP ${favItems.data!.data[index].product!.price}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    cubit.changeFavID(favItems.data!.data[index].product!.id);
                    cubit.addDeleteFavItems(id: favItems.data!.data[index].product!.id, context: context, showFavSnack: true, fromFavSaved: true);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 12),
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.orange.shade600,),
                        Text('REMOVE', style: TextStyle(color: Colors.orange.shade600, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),
                    elevation: 5.0,
                    color: Colors.orange.shade600,
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                      onPressed: () => cubit.addDeleteCartItems(id : cubit.favItems!.data!.data[index].product!.id ,context: context, fromCartSaved: false),
                      child: const Text('ADD TO CART', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => const Divider(thickness: 1.4, height: 10,),
      itemCount: favItems.data!.data.length,
    );
}
