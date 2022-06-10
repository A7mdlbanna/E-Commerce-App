import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/models/user_login.dart';
import 'package:shop_app/shared/Network/end_points.dart';
import 'package:shop_app/shared/Network/local/cached_helper.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_states.dart';
import '../../Network/remote/dio_helper.dart';
import '../../constants.dart';
import '../app_cubit/app_cubit.dart';
import '../app_cubit/app_states.dart';

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
Future<String?> updateProfile({context, name, email, phone,  password, required bool isImage, required bool pickImage})async {
  XFile? image;
  if(pickImage)image = await ImagePicker().pickImage(source: ImageSource.gallery);
  emit(UpdateProfileLoadingState());
  if(image!=null) {
    await DioHelper.uploadData(
      url: UPDATE,
      token: token,
      data: {
        'name': loginData!.data!.name,
        'email': loginData!.data!.email,
        'phone': loginData!.data!.phone,
        'password': CacheHelper.getData(key: 'password'),
        'image': await toBuffer(image, context),
      }).then((value) {
    print(value);
    loginData = UserLoginData.fromJSON(value?.data);
    emit(UpdateProfileSuccessfulState());
  }).catchError((error) {
    debugPrint(error.toString());
    emit(UpdateProfileErrorState());
  });
  }
  return null;
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


  Future<String> toBuffer(pickImage, context) async{
    // var request = MultipartRequest();
    // request.setUrl();
    // request.addFile("image", pickImage?.path);
    // Response response = request.send();
    // response.onError = () {
    //   print("Error");
    // };
    // response.onComplete = (response) {
    //   print(response);
    // };
    // response.progress.listen((int progress) {
    //   print("progress from response object $progress");
    // });
    // var request = http.MultipartRequest('POST', Uri.parse(url));
    // request.files.add(
    //     await http.MultipartFile.fromPath(
    //     'pdf',
    //     filename
    //   )
    // );
    // var res = await request.send();
    Uint8List imageBytes = await File(pickImage.path).readAsBytes(); //convert to bytes
    AppCubit.get(context).changeImage(MemoryImage(imageBytes));
    print( base64.encode(imageBytes));
    return base64.encode(imageBytes); //convert bytes to base64 string
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,1000}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }



}