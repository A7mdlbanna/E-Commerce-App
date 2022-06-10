import 'dart:io';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:multipart_request/multipart_request.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/Network/end_points.dart';
import 'package:shop_app/shared/Network/local/cached_helper.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_cubit.dart';
import '../../../models/user_login.dart';
import '../../Network/remote/dio_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);



  ///////////////App Bar//////////////////////////
  bool isPressedCartIcon = false;
  void changeCartIcon(){
    isPressedCartIcon = !isPressedCartIcon;
  }
  ///////////////bottom nav bar///////////////////////

  List<String> titles = [
        'New Arrival',
        'Saved Items',
        'In Cart',
        'Account',
  ];

  int currentIndex = 0;
  String currentTitle = 'New Arrival';
  void changeIndex(value, PageController controller){
    controller.animateToPage(value, duration: const Duration(microseconds: 500), curve: Curves.ease);
    currentTitle = titles[value];
    currentIndex = value;
    emit(HomeChangeIndexState());
    emit(HomeChangeIndexState());
  }

  late int favID;
  void changeFavID(id){
    favID = id;
    emit(ChangeFavIndexState());
  }
  void showFavSnackBar(context, bool fromFavSaved){
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check, color: Colors.greenAccent,),
          const SizedBox(width: 10,),
          Text(favItemsBeta!.message == 'Added Successfully'? 'Item Saved Successfully!' : 'Item Deleted from Saved!', style: const TextStyle(fontSize: 16),),
        ],
      ),
    action: fromFavSaved ?  SnackBarAction(
        onPressed: () => addDeleteFavItems(id: favID ,context: context, showFavSnack: false),
        label: 'undo',
        textColor: Colors.blue,
      ) : null,
      elevation: 10,
      duration: const Duration(milliseconds: 2000),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      // animation: Animation<>(),
    );
    favItemsBeta!.message != '' ? {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
    ScaffoldMessenger.of(context).showSnackBar(snackBar)
  } : null;
    favItemsBeta!.message = '';
  }

  late int cartID;
  void changeCartID(id){
    cartID = id;
    emit(ChangeCartIndexState());
  }
  void showCartSnackBar(context, bool fromCartSaved){
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check, color: Colors.greenAccent,),
          const SizedBox(width: 10,),
          Text(cartItemsBeta!.message == 'Added Successfully'? 'Item Added To Cart!' : 'Item Deleted from Cart!', style: const TextStyle(fontSize: 18),),
        ],
      ),
      action: fromCartSaved ?  SnackBarAction(
      onPressed: () => addDeleteCartItems(id: cartID ,context: context, showCartSnack: false),
      label: 'undo',
      textColor: Colors.blue,
    ) : null,
      elevation: 10,
      duration: const Duration(milliseconds: 2000),
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
    );
    cartItemsBeta!.message != '' ? {
      ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ScaffoldMessenger.of(context).showSnackBar(snackBar)
    } : null;
    cartItemsBeta!.message = '';
  }


  String getFirstName(String fullName){
    String name = '';
    for(int i = 0; i < fullName.length; i++){
      if(fullName[i] == ' ')break;
      name += fullName[i];
    }
    return name;
  }

///////////////////////////HOME//////////////////////////////////

  HomeModel? homeData;
  Future<void> getHomeData()async{
    emit(HomeLoadingState());
     DioHelper.getData(url: HOME,).then((value){
      // debugPrint(value);
      homeData = HomeModel.fromJSON(value?.data);
      home = true;
      emit(HomeSuccessfulState());
      // debugPrint(homeData.toString());
    }).catchError((error){
      debugPrint(error.toString());
      emit(HomeErrorState());
    });
  }

///////////////////////////FAV//////////////////////////////////

  FavItems? favItems;
  FavItemsBeta? favItemsBeta;
  List<int> favItemsIDs = [];

  void changeFav(index, context){
    addDeleteFavItems(id : homeData!.data!.products[index].id ,context: context, fromFavSaved: false);
    emit(ChangeFavState());
  }

  Future<void> getFavItems({required context, bool? showFavSnack = false, bool fromFavSaved = false})async{
    emit(FavLoadingState());
    DioHelper.getData(url: FAV, token: token).then((value) async{
      favItems = FavItems.fromJSON(value?.data);

      favItemsIDs.clear();
      for (var id in favItems!.data!.data) {
      favItemsIDs.add(id.product!.id);
      }
      debugPrint(favItemsIDs.toString());
      showFavSnack! ? showFavSnackBar(context, fromFavSaved) : null;
      fav = true;
      emit(FavSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(FavErrorState());
    });
  }

  Future<void> addDeleteFavItems({required id, required context, showFavSnack = true, fromFavSaved = false}) async{
    emit(FavLoadingState());
    DioHelper.postData(url: FAV, data: {'product_id' : id}, token: token).then((value){
      // debugPrint(value);
      favItemsBeta = FavItemsBeta.fromJSON(value?.data);
      getFavItems(context: context, showFavSnack: showFavSnack, fromFavSaved: fromFavSaved);
      emit(FavSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(FavErrorState());
    });
  }

///////////////////////////CART//////////////////////////////////

  CartItems? cartItems;
  CartItemsBeta? cartItemsBeta;

  Future<void> getCartItems({required context, bool? showCartSnack = false, bool fromCartSaved = false})async{
    emit(CartLoadingState());
    await DioHelper.getData(url: CART, token: token).then((value){
      // debugPrint(value);
      cartItems = CartItems.fromJSON(value?.data);
      showCartSnack! ? showCartSnackBar(context, fromCartSaved) : null;
      cart = true;
      emit(CartSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(CartErrorState());
    });
  }

  Future<void> addDeleteCartItems({required id, required context, showCartSnack = true, fromCartSaved = false}) async{
    emit(CartLoadingState());
    DioHelper.postData(url: CART, data: {'product_id' : id}, token: token).then((value){
      // debugPrint(value.toString());
      cartItemsBeta = CartItemsBeta.fromJSON(value?.data);
      getCartItems(context: context, showCartSnack: showCartSnack, fromCartSaved: fromCartSaved);
      emit(CartSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(CartErrorState());
    });
  }

  ////////////////////////PROFILE/////////////////////////////////
  void changeImage(imageProv){
    userImage = imageProv;
    emit(ChangePic());
  }
  Future<void> getProfile(context)async{
    emit(GetProfileLoadingState());
    DioHelper.getData(url: PROFILE, token: token).then((value) async{
      print(value);
      // if(value==null) {
      //   showDialog(context: context, builder: (context){
      //   return AlertDialog(
      //     content: const Text('something went wrong'),
      //     actions: [
      //       TextButton(onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false) , child: const Text('Login Again'))
      //     ],
      //   );
      // });
      // }
      StartingCubit.get(context).loginData = UserLoginData.fromJSON(value!.data);
      changeImage(NetworkImage(StartingCubit.get(context).loginData!.data!.image));
      emit(GetProfileSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(GetProfileErrorState());
    });
  }

  ////////////////////////CATEGORIES//////////////////////////////

  CategoriesItems? categoriesItems;

  Future<void> getCategoriesItems()async{
    emit(CategoriesLoadingState());
    await DioHelper.getData(url: CATEGORIES).then((value){
      debugPrint(value.toString());
      categoriesItems = CategoriesItems.fromJSON(value?.data);
      categories = true;
      emit(CategoriesSuccessfulState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(CategoriesErrorState());
    });
  }


}