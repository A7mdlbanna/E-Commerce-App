import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/search/search.dart';
import 'package:shop_app/shared/cubit/search/search_states.dart';
import 'package:shop_app/shared/themes/style/icons.dart';

import '../../models/Search.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
          TextEditingController searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          Search? search = SearchCubit.get(context).search;
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Container(
                height: 40,
                child: Align(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Products',
                      suffixIcon: IconButton(
                        icon: const Icon(MyIcons.Search), onPressed: () => cubit.searchProducts(searchController.text),
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(50.0)),
                    ),
                    onChanged: (String value) {
                      cubit.searchProducts(value);
                    },
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  MyIcons.Arrow___Left_2,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: searchController.text.isEmpty ? Container() : cubit.searchList.isEmpty ? const LinearProgressIndicator()
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) => Row(
                    children: [
                      Image.network(
                        search!.data!.data![index].image!,
                        height: 100,
                        width: 80,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              search.data!.data![index].name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('${search.data!.data![index].price}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: 10,),
                  itemCount: search!.data!.data!.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
