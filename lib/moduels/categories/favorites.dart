
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/get_fav_model.dart';

class FavoriteScreen  extends StatelessWidget {
  const FavoriteScreen({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state) {},
      builder:(context , state) {
        return ConditionalBuilder(
          condition: state is! LoadingGetFavoritesData,
          builder:(context) => ListView.separated(
              itemBuilder: (context , index) =>buildFavItems(ShopCubit.get(context).getFavoriteData.data.data[index],context),
              separatorBuilder: (context , index) => myDiv(),
              itemCount: ShopCubit.get(context).getFavoriteData.data.data.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },);
  }



}
