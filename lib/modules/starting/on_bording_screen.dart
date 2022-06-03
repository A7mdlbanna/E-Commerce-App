import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gif_view/gif_view.dart';
// import 'package:infinity_page_view/infinity_page_view.dart';
import 'package:shop_app/shared/Network/local/cached_helper.dart';
import 'package:shop_app/shared/cubit/theme_cubit/app_theme_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/cubit/starting_cubit/starting_cubit.dart';
import '../../shared/cubit/starting_cubit/starting_states.dart';
class OnBoardingScreen extends StatelessWidget {


  OnBoardingScreen({Key? key}) : super(key: key);

  // late Timer t;
  late int duration;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StartingCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocConsumer<StartingCubit, StartingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          StartingCubit cubit = StartingCubit.get(context);
          PageController pageController = PageController(initialPage: 0);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemBuilder: (BuildContext context, int pageIndex) =>
                          screenBuilder(context, pageIndex),
                      itemCount: 3,
                      controller: pageController,
                      onPageChanged: (index) => cubit.changePage2(index),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/LoginScreen', (route) => false),
                          child: Text('Skip', style: TextStyle(color: Colors.grey.shade700, fontSize: 20),)),
                      SmoothPageIndicator(
                          controller: pageController,
                          effect: const JumpingDotEffect(
                            dotColor: Colors.grey,
                            activeDotColor: Color.fromARGB(255, 12, 101, 140),
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 6,
                          ),
                          count: 3,
                      ),
                      TextButton(
                        onPressed: () => cubit.changePage(pageController, context),
                          child: Text(cubit.currentPage != 2 ? 'Next' : 'Finish', style: const TextStyle(color: Color.fromARGB(255, 8, 77, 105), fontSize: 20),
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget screenBuilder(context, pageIndex) {
  // InfinityPageController imageController = InfinityPageController(initialPage: 0);
  bool isDark = CacheHelper.getData(key: 'isDark')??SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
    return BlocProvider(create: (context) => StartingCubit(),
      child: BlocConsumer<StartingCubit, StartingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<String> titles = [
            'Choose your product',
            'Pay by card',
            'Get it Delivered'
          ];
          List<String> bodies = [
            'There is more that 30 categories that you can choose from.',
            'The order can be paid by credit card or in cash at time of the delivery.',
            'Modern delivering technologies. \n Shipping to the porch of your apartment with great gifts.'
          ];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expanded(
              //   child: InfinityPageView(
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemBuilder: (BuildContext context, int index) {
              //      return GifView.asset(
              //           "assets/on_boarding/onBoarding${isDark ? 'Dark' : ''}${pageIndex + 1}-${index + 1}.gif",
              //           loop: false,
              //           onFrame: (value) =>
              //           duration = ((value / 15) * pow(10, 3)).round(),
              //           onFinish: () =>
              //           Timer(
              //           Duration(milliseconds: 4000 - duration), () {
              //                 imageController.animateToPage(
              //                     imageController.page + 1,
              //                     duration: const Duration(milliseconds: 1000),
              //                     curve: Curves.ease
              //                 );
              //               }),
              //       );
              //     },
              //     itemCount: 2,
              //     controller: imageController,
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Text(titles[pageIndex], style: const TextStyle(fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 14, 105, 141)),),
                    const SizedBox(height: 15,),
                    Text(bodies[pageIndex], style: const TextStyle(fontSize: 18,),
                      textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}