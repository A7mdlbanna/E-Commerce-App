import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_login.dart';
import 'package:shop_app/shared/Network/end_points.dart';
import 'package:shop_app/shared/Network/local/cached_helper.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_states.dart';
import '../../Network/remote/dio_helper.dart';
import '../../constants.dart';

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
Future<String?> userLogin({required email, required password})async {
  emit(LoginLoadingState());
  return await DioHelper.postData(
      url: LOGIN,
      data: {
        'email' : email,
        'password' : password
      }).then((value) {
        // debugPrint(value.toString());
        loginData = UserLoginData.fromJSON(value?.data);
        CacheHelper.saveData('name', loginData!.data!.name);
        CacheHelper.saveData('token', loginData!.data!.token);
        token = loginData!.data!.token;
        emit(LoginSuccessfulState());
  }).catchError((error){
    debugPrint(error.toString());
    emit(LoginErrorState());
  });
}
Future<String?> updateProfile({name, email, phone,  password, image})async {
    emit(LoginLoadingState());
    return await DioHelper.postData(
        url: LOGIN,
        data: {
          'name': name??loginData!.data!.name,
          'email' : email??loginData!.data!.email,
          'phone': phone??loginData!.data!.phone,
          'password': password??CacheHelper.getData(key: 'password'),
          'image': image??loginData!.data!.image,
        }).then((value) {
      loginData = UserLoginData.fromJSON(value?.data);
      emit(LoginSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(LoginErrorState());
    });
  }

UserSignUpData? signUpData;
Future<void> userSignUp({required name, required email, required password, required phone})async {
  emit(SignUpLoadingState());
  await DioHelper.postData(
      url: SIGNUP,
      data: {
        'name' : name,
        'email' : email,
        'password' : password,
        'phone' : phone,
      }).then((value) {
        if (kDebugMode) {
          debugPrint(value.toString());
        }
        signUpData = UserSignUpData.fromJSON(value?.data);
        // CacheHelper.saveData('token', loginData!.data!.token);
        emit(SignUpSuccessfulState());
  }).catchError((error){
    debugPrint(error.toString());
    emit(SignUpErrorState());
  });}

UserLogOut? logOut;
Future<void> userLogOut()async {
    emit(LogoutLoadingState());
    await DioHelper.postData(url: LOGOUT, token: token).then((value) {
      debugPrint(value.toString());
      logOut = UserLogOut.fromJSON(value?.data);
      emit(LogoutSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(LogoutErrorState());
    });}
}