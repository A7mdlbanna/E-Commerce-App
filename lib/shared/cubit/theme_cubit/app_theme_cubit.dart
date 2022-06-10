import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/theme_cubit/theme_states.dart';

import '../../Network/local/cached_helper.dart';


class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  late bool isDark = SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
  Color fillColor =  Colors.white;
  Color hintColor =  Colors.grey.shade500;
  void changeTheme({fromShared}){
    if(fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.saveData('isDark', isDark).then((value){
        emit(ChangeAppThemeState());
      });
    }
    fillColor = isDark ? Colors.white : Colors.black;
    hintColor = isDark ? Colors.grey.shade500 : Colors.grey;
    emit(ChangeAppThemeState());

  }
}