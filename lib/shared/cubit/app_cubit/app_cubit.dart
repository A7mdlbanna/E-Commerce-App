import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/Network/end_points.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_cubit.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_cubit.dart';
import 'package:shop_app/shared/cubit/starting_cubit/starting_cubit.dart';
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


  late String userImage = '';

  void getImage(context) {
    userImage = StartingCubit
        .get(context)
        .loginData!
        .data!
        .image;
    emit(GetImage());
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
          Icon(Icons.check, color: Colors.greenAccent,),
          SizedBox(width: 10,),
          Text(cartItemsBeta!.message == 'Added Successfully'? 'Item Added To Cart!' : 'Item Deleted from Cart!', style: TextStyle(fontSize: 18),),
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

  void changeFav(index, context){
    addDeleteFavItems(id : homeData!.data!.products[index].id ,context: context, fromFavSaved: false);
    emit(ChangeFavState());
  }

  HomeModel? homeData;
  Future<void> getHomeData()async{
    emit(HomeLoadingState());
     DioHelper.getData(url: HOME,).then((value){
      // print(value);
      homeData = HomeModel.fromJSON(value?.data);
      home = true;
      emit(HomeSuccessfulState());
      // debugPrint(homeData.toString());
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorState());
    });
  }



  FavItems? favItems;
  FavItemsBeta? favItemsBeta;
  List<int> favItemsIDs = [];

  Future<void> getFavItems({required context, bool? showFavSnack = false, bool fromFavSaved = false})async{
    emit(FavLoadingState());
    DioHelper.getData(url: FAV, token: token).then((value) async{
      favItems = FavItems.fromJSON(value?.data);

      favItemsIDs.clear();
      for (var id in favItems!.data!.data) {
      favItemsIDs.add(id.product!.id);
      }
      print(favItemsIDs);
      showFavSnack! ? showFavSnackBar(context, fromFavSaved) : null;
      fav = true;
      emit(FavSuccessfulState());
    }).catchError((error){
      print(error.toString());
      emit(FavErrorState());
    });
  }

  Future<void> addDeleteFavItems({required id, required context, showFavSnack = true, fromFavSaved = false}) async{
    emit(FavLoadingState());
    DioHelper.postData(url: FAV, data: {'product_id' : id}, token: token).then((value){
      print(value);
      favItemsBeta = FavItemsBeta.fromJSON(value?.data);
      getFavItems(context: context, showFavSnack: showFavSnack, fromFavSaved: fromFavSaved);
      emit(FavSuccessfulState());
    }).catchError((error){
      print(error.toString());
      emit(FavErrorState());
    });
  }


  CartItems? cartItems;
  CartItemsBeta? cartItemsBeta;
  // List<int> cartItemsIDs = [];

  Future<void> getCartItems({required context, bool? showCartSnack = false, bool fromCartSaved = false})async{
    emit(CartLoadingState());
    await DioHelper.getData(url: CART, token: token).then((value){
      print(value);
      cartItems = CartItems.fromJSON(value?.data);

      // cartItemsIDs.clear();
      // for (var id in cartItems!.data!.cartItems) {
      //   cartItemsIDs.add(id.product!.id);
      // }
      // print(cartItemsIDs);
      showCartSnack! ? showCartSnackBar(context, fromCartSaved) : null;
      cart = true;
      emit(CartSuccessfulState());
    }).catchError((error){
      print(error.toString());
      emit(CartErrorState());
    });
  }

  Future<void> addDeleteCartItems({required id, required context, showCartSnack = true, fromCartSaved = false}) async{
    emit(CartLoadingState());
    DioHelper.postData(url: CART, data: {'product_id' : id}, token: token).then((value){
      print(value);
      cartItemsBeta = CartItemsBeta.fromJSON(value?.data);
      getCartItems(context: context, showCartSnack: showCartSnack, fromCartSaved: fromCartSaved);
      emit(CartSuccessfulState());
    }).catchError((error){
      print(error.toString());
      emit(CartErrorState());
    });
  }
}