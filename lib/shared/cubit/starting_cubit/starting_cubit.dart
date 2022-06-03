import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_login.dart';
import 'package:shop_app/shared/Network/end_points.dart';
import 'package:shop_app/shared/Network/local/cached_helper.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_states.dart';
import '../../Network/remote/dio_helper.dart';

class StartingCubit extends Cubit<StartingStates>{
  StartingCubit() : super(StartingInitialState());
  static StartingCubit get(context) => BlocProvider.of(context);

////////onBoarding//////
int currentPage = 0;
void tCancel(Timer t){
    t.cancel();
    emit(TimerCancel());
  }
void changePage2(value){
  // tCancel(t);
 currentPage = value;
  emit(ChangeOnBoardingPage());
}
void changePage(PageController controller, context){
  // tCancel(t);
  currentPage++;
  emit(ChangeOnBoardingPage());
  currentPage < 3 ?
  controller.animateToPage(
    currentPage,
    duration: const Duration(milliseconds: 1000),
    curve: Curves.ease,
  ) : Navigator.pushNamedAndRemoveUntil(
    context,
    '/LoginScreen',
        (route) => false,
  );
}

///////login/////////////
  bool forgetPassword = false;
  void changeForgetPassword(bool value){
    forgetPassword = value;
    emit(ChangeForgetPasswordState());
  }

UserLoginData? loginData;
Future<void> userLogin({required email, required password})async {
  emit(LoginLoadingState());
  await DioHelper.postData(
      url: LOGIN,
      data: {
        'email' : email,
        'password' : password
      }).then((value) {
        if (kDebugMode) {
          print(value);
        }
        loginData = UserLoginData.fromJSON(value?.data);
        CacheHelper.saveData('name', loginData!.data!.name);
        CacheHelper.saveData('token', loginData!.data!.token);
        emit(LoginSuccessfulState(loginData!));
  }).catchError((error){
    print(error.toString());
    emit(LoginErrorState());
  });}
}