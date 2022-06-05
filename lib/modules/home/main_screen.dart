import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/home_model.dart';
import '../../shared/Network/local/cached_helper.dart';
import '../../shared/cubit/app_cubit/app_cubit.dart';

Widget MainScreen(context, controller) {

  AppCubit cubit = AppCubit.get(context);
  String name = cubit.getFirstName(CacheHelper.getData(key: 'name'));
  HomeData? homeData = cubit.homeData!.data;
  CarouselController carouselController = CarouselController();


  return SingleChildScrollView(
    controller: controller,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello $name!',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          const Text(
            'let\'s get somethings?',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(
            height: 40,
          ),
          homeData?.products != null
              ? CarouselSlider.builder(
                  itemBuilder: (BuildContext context, int idx, int index) {
                    return Container(
                        decoration: const BoxDecoration(
                            // color: Color(0xFF120C30),
                            ),
                        child: Image.network(homeData!.products[idx].image));
                  },
                  itemCount: homeData!.products.length,
                  options: CarouselOptions(
                      height: 300,
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInQuint
                      // pauseAutoPlayOnTouch: false,
                      ),
                  carouselController: carouselController,
                )
              : const Center(child: CircularProgressIndicator()),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Categories',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  color: Colors.grey.shade200,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Hello'),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 10,
              ),
              itemCount: 10,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: (homeData!.products.length / 2) * 218,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => SizedBox(
                height: 200,
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, idx) => Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFFF8F8EE),
                                  border:
                                      Border.all(color: Colors.grey.shade400)),
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 8),
                                        child: Image.network(homeData
                                            .products[(index * 2) + idx].image),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                          ),
                                          child: SizedBox(
                                            width: 74,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  homeData
                                                      .products[
                                                          (index * 2) + idx]
                                                      .name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                homeData
                                                            .products[
                                                                (index * 2) +
                                                                    idx]
                                                            .discount >
                                                        0
                                                    ? Column(children: [
                                                        Text(
                                                            'EGP${homeData.products[(index * 2) + idx].oldPrice.round()}',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                color: Colors
                                                                    .grey
                                                                    .shade500)),
                                                        RichText(
                                                            textAlign:
                                                                TextAlign.start,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                    text:
                                                                        '${homeData.products[(index * 2) + idx].price.round()}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black)),
                                                                const TextSpan(
                                                                  text: 'EGP',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ))
                                                      ])
                                                    : Text(
                                                        'EGP${homeData.products[(index * 2) + idx].price.round()}',
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                // const SizedBox(height: 10,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  cubit.changeFav((index * 2) + idx, context);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.black26,
                                      radius: 18,
                                    ),
                                    cubit.favItemsIDs.contains(cubit.homeData!.data!.products[(index * 2) + idx].id)
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.favorite_border_outlined,
                                            color: Colors.white70,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () => cubit.addDeleteCartItems(id : cubit.homeData!.data!.products[(index * 2) + idx].id ,context: context, fromCartSaved: false),
                                child: Container(
                                  height: 40,
                                  width: 45,
                                  decoration: const BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0)),
                                  ),
                                  child: const Icon(Icons.add),
                                ),
                              ),
                            )
                          ],
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 20,
                        ),
                    itemCount: 2),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 18,
              ),
              itemCount: (homeData.products.length / 2).floor(),
            ),
          ),
        ],
      ),
    ),
  );
}
