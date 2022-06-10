import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/starting/on_bording_screen.dart';
import 'package:shop_app/shared/Network/local/cached_helper.dart';
import 'package:shop_app/shared/Network/remote/dio_helper.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_states.dart';
import 'package:shop_app/shared/cubit/theme_cubit/app_theme_cubit.dart';
import 'package:shop_app/shared/themes/dark_mode.dart';
import 'package:shop_app/shared/themes/light_mode.dart';
import 'shared/cubit/starting_cubit/starting_cubit.dart';

import 'modules/home/home_screen.dart';
import 'modules/starting/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

   onBoarding = CacheHelper.getData(key : 'onBoarding')??true;
  CacheHelper.saveData('onBoarding', false);

  bool isDark = CacheHelper.getData(key: 'isDark')??SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
  token = CacheHelper.getData(key: 'token')??'';
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  late bool isDark;

  MyApp(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ThemeCubit()..changeTheme(fromShared: isDark),),
        BlocProvider(create: (BuildContext ctx) => StartingCubit()),
        BlocProvider(create: (BuildContext ctx) {
          if(doneLogin){
            return AppCubit()..getHomeData()..getFavItems(context: context)..getProfile(ctx)..getCartItems(context: context, showCartSnack: false)..getCategoriesItems();
          } else {
            return AppCubit()..getProfile(ctx);
          }
        }),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is HomeErrorState || state is FavErrorState || state is CartErrorState || state is GetProfileErrorState){
            showDialog(context: context, builder: (ctx){
              return AlertDialog(
                content: const Text('something went wrong'),
                actions: [
                  TextButton(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false) , child: const Text('Login Again'))
                ],
              );
            });
          }
          return MaterialApp(
            title: 'E Commerce',
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: ThemeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: onBoarding
                  ? OnBoardingScreen()
                  : !doneLogin
                    ? LoginScreen()
                    : const HomeScreen(),
            initialRoute:'/',
            routes:{
              '/onBoardingScreen' : (context) => OnBoardingScreen(),
              '/LoginScreen' : (context) => LoginScreen(),
              '/HomeScreen' : (context) => const HomeScreen(),
            },
          );
        },
      ),
    );
  }
}
