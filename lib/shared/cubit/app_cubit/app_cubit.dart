import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/Network/end_points.dart';
import 'package:shop_app/shared/constants.dart';
import '../../Network/remote/dio_helper.dart';
import '../starting_cubit/starting_states.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  ///////////////bottom nav bar///////////////////////

  int currentIndex = 0;
  void changeIndex(value, PageController controller){
    currentIndex = value;
    controller.animateToPage(currentIndex, duration: Duration(microseconds: 800), curve: Curves.ease);
    emit(HomeChangeIndexState());
  }

  String getFirstName(String fullName){
    String name = '';
    for(int i = 0; i < fullName.length; i++){
      if(fullName[i] == ' ')break;
      name += fullName[i];
    }
    return name;
  }

  void changeFav(index){
    print(index);
    homeData!.data!.products[index].inFavourite = !homeData!.data!.products[index].inFavourite;
    emit(ChangeFavState());
    addDeleteFavItems(id : homeData!.data!.products[index].id);
  }

  HomeModel? homeData;
  Future<void> getHomeData()async{
    emit(HomeLoadingState());
     DioHelper.getData(url: HOME,).then((value){
      // print(value);
      homeData = HomeModel.fromJSON(value?.data);
      emit(HomeSuccessfulState());
      // debugPrint(homeData.toString());
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorState());
    });
  }



  FavItems? favItems;
  FavItemsBeta? favItemsBeta;

  Future<void> getFavItems()async{
    emit(FavLoadingState());
    DioHelper.getData(url: FAV, token: token).then((value) {
      // print(value);
      favItems = FavItems.fromJSON(value?.data);
      print(favItems?.status);
      print(favItems?.data?.data?[0].mainId);
      // print(favItems?.data?.data?.length);
      emit(FavSuccessfulState());
      // debugPrint(homeData.toString());
    }).catchError((error){
      print(error.toString());
      emit(FavErrorState());
    });
  }

  Map<dynamic, dynamic> favItemsID = {1 : false, 2 : false};
  Future<void> addDeleteFavItems({required id}) async{
    emit(FavLoadingState());
    DioHelper.postData(url: FAV, data: {'product_id' : id}, token: token).then((value){
      // print(value);
      favItemsBeta = FavItemsBeta.fromJSON(value?.data);
      favItemsID[favItemsBeta?.data?.products?.id] = favItemsBeta?.message == 'Added Successfully';
      // print(favItemsID);
      // print(favItemsBeta?.message == 'Added Successfully');
      getFavItems();
      emit(FavSuccessfulState());
    }).catchError((error){
      print(error.toString());
      emit(FavErrorState());
    });
  }
}