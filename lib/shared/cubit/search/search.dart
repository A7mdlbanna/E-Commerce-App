import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/Network/remote/dio_helper.dart';
import 'package:shop_app/shared/cubit/search/search_states.dart';

import '../../../models/Search.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  Search? search;
  List<ProductData> searchList = [];
  void searchProducts(String keyMap){
    DioHelper.postData(url: 'products/search', data: {'text': keyMap}).then((value) {
      search = Search.fromJson(value?.data);
      searchList = search!.data!.data!;
      emit(SearchSuccessState());
    }).catchError((error){
      print(error);
      emit(SearchErrorState());
      });
  }
}