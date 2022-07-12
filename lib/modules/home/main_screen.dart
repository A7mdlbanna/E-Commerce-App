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
                    return Image.network(homeData!.banners[idx].image);
                  },
                  itemCount: homeData!.banners.length,
                  options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInQuint
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
            height: 88,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                width: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200,
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Image.network(cubit.categoriesItems!.data!.data[index].image, width: 40, height: 40,)),
                      Text(cubit.categoriesItems!.data!.data[index].name, textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 10,
              ),
              itemCount: cubit.categoriesItems!.data!.data.length,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1 / 1.4,
            crossAxisCount: 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            children: List.generate(homeData!.products.length, (index) => Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
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
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
                            child: Image.network((homeData.products[index].image)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0,),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeData.products[index].name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5,),
                              homeData.products[index].discount > 0 ? Column(
                                  children: [
                                    Text(
                                        'EGP${homeData.products[index].oldPrice.round()}',
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
                                                '${homeData.products[index].price.round()}',
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
                                  ]) : RichText(
                                  textAlign:
                                  TextAlign.start,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text:
                                          '${homeData.products[index].price.round()}',
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
                              // const SizedBox(height: 10,)
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      cubit.changeFav(index, context);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.black26,
                          radius: 18,
                        ),
                        cubit.favItemsIDs.contains(cubit.homeData!.data!.products[index].id)
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
                    onTap: () => cubit.addDeleteCartItems(id : cubit.homeData!.data!.products[index].id ,context: context, fromCartSaved: false),
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
                ),
                homeData.products[index].discount > 0 ? Positioned(
                  top: 1, left: 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const ImageIcon(
                        AssetImage('assets/icons/discount.png'),
                        color: Colors.red,
                        size: 28,
                      ),
                      Column(
                        children: [
                          Text('${cubit.homeData!.data!.products[index].discount}', style: const TextStyle(color: Colors.white, fontSize: 10),),
                          const Text('OFF', style: TextStyle(fontSize: 10, color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
                ) : Container(),
              ],
            ),)
          ),
        ],
      ),
    ),
  );
}
