import 'package:flutter/material.dart';

import '../../models/home_model.dart';
import '../../shared/cubit/app_cubit/app_cubit.dart';

Widget CartScreen(context, controller) {
  AppCubit cubit = AppCubit.get(context);
  CartItems? cartItems = cubit.cartItems;
  return cartItems!.data!.cartItems.isEmpty
      ? Center(
          child: Text(
            'there are no items in cart, go explore more items',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          ),
        )
      : ListView.separated(
          controller: controller,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => Row(
            children: [
              Image.network(
                cartItems.data!.cartItems[index].product!.image!,
                height: 80,
                width: 80,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItems.data!.cartItems[index].product!.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('${cartItems.data!.cartItems[index].product!.price}'),
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  cubit.changeCartID(cartItems.data!.cartItems[index].product!.id);
                  cubit.addDeleteCartItems(id: cartItems.data!.cartItems[index].product!.id, context: context, fromCartSaved: true);
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
            ],
          ),
          separatorBuilder: (context, index) => SizedBox(height: 10,),
          itemCount: cartItems.data!.cartItems.length,
        );
}
