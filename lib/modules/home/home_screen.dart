import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:shop_app/modules/home/account_screen.dart';
import 'package:shop_app/modules/home/cart_screen.dart';
import '../../shared/cubit/app_cubit/app_cubit.dart';
import '../../shared/cubit/app_cubit/app_states.dart';
import '../home/favorite_screen.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: BottomBar(
            showIcon: false,
            borderRadius: BorderRadius.circular(500),
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            width: MediaQuery.of(context).size.width * 0.88,
            barColor: Colors.white,
            body: (context, controller) => PageView(
              onPageChanged: (index) => cubit.changeIndex(index, pageController),
              controller: pageController,
              children: <Widget> [
                MainScreen(context, controller),
                FavScreen(context, controller),
                CartScreen(context, controller),
                AccountScreen(context, controller),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              child: Container(
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black, spreadRadius: 100, blurRadius: 20, blurStyle: BlurStyle.inner ),
                      BoxShadow(color: Colors.black, spreadRadius: 100, blurRadius: 20, blurStyle: BlurStyle.inner )
                    ]
                ),
                child: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  onTap: (idx) => cubit.changeIndex(idx, pageController),

                  iconSize: 30,
                  elevation: 20,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: const Color.fromARGB(255, 8, 60, 82),
                  unselectedItemColor: const Color.fromARGB(255, 103, 108, 128),
                  items: const [
                    BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/shop.png'), size: 20,), label: 'home'),
                    BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/save_out.png'), size: 20), label: 'saved'),
                    BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/shopping-cart.png'), size: 20), label: 'cart'),
                    BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/shopping-bag.png'), size: 20), label: 'account'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}