
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/search_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context , state){},
        builder: (context , state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    textFieldForm(
                        controller: searchController,
                        type: TextInputType.text,
                        label: 'Search',
                        prefix: Icons.search,
                      onSubmit: (String text) {
                        ShopCubit.get(context).search(text : text);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'enter name';
                        }
                        return null;
                      },),
                    SizedBox(
                        height: 15.0,),


                    SizedBox(
                      height: 15.0,
                    ),
                    if(state is LoadingSearchData)
                    LinearProgressIndicator(),
                    if(state is SuccesSearchData)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          itemBuilder: (context , index) =>buildSearchItems(ShopCubit.get(context).searchData.data.data[index], context , isOldPrice: false),
                          separatorBuilder: (context , index) => myDiv(),
                          itemCount: ShopCubit.get(context).searchData.data.data.length),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
