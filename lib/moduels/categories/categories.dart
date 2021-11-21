
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen  extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
        listener: (context , state) {},
    builder:(context , state) {
          return ListView.separated(
              itemBuilder: (context , index) => buildCategorieItem(ShopCubit.get(context).categoriesModel.data.data[index]),
              separatorBuilder: (context , index) => myDiv(),
              itemCount: ShopCubit.get(context).categoriesModel.data.data.length);
    },);
  }


}

Widget buildCategorieItem(DataModel model) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(
        image: NetworkImage(model.image),
        width: 100,
        height: 100,
        fit: BoxFit.cover,),
      SizedBox(width: 20.0,),
      Text(
        model.name,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
      Icon(Icons.arrow_forward_ios),
    ],
  ),
);

