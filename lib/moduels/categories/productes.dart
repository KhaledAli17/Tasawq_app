
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

class ProductesScreen extends StatelessWidget {
  const ProductesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is SuccesFavoritesData){
          if(!state.changeFavoriteModel.status){
            showToast(
                text: state.changeFavoriteModel.message,
                state: ToastState.ERROR,);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel  != null,
          builder: (context) =>
              productBuilder(ShopCubit.get(context).homeModel , ShopCubit.get(context).categoriesModel , context),
          fallback: (context) =>  Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel homeModel , CategoriesModel categoriesModel , context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
                items: homeModel.data.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval:  Duration(seconds: 3),
                  autoPlayAnimationDuration:  Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
             SizedBox(
              height: 10.0,
            ),
           Padding(
             padding:  EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Text(
                   'Categories',
                   style: TextStyle(
                     fontSize: 24.0,
                     fontWeight: FontWeight.w600,
                   ),
                 ),
                  SizedBox(
                   height: 10.0,
                 ),
                 Container(
                   height: 100.0,
                   child: ListView.separated(
                       physics:  BouncingScrollPhysics(),
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context , index) => buildCategoriesItems(categoriesModel.data.data[index]),
                       separatorBuilder: (context , index) =>  SizedBox(width: 10.0,),
                       itemCount: categoriesModel.data.data.length),
                 ),
                  SizedBox(
                   height: 10.0,
                 ),
                  Text(
                   'New Products',
                   style: TextStyle(
                     fontSize: 24.0,
                     fontWeight: FontWeight.w600,
                   ),
                 ),
               ],
             ),
           ),

            
             SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics:  NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.61,
                children: List.generate(
                    homeModel.data.products.length,
                    (index) =>
                        buildGridProducts(homeModel.data.products[index] , context)),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProducts(Products products , context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(products.image),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (products.discount != 0)
                  Container(
                    color: Colors.red,
                    padding:  EdgeInsets.symmetric(horizontal: 5.0),
                    child:  Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${products.price.round()} ',
                        style:  TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                       SizedBox(
                        width: 10.0,
                      ),
                      if (products.discount != 0)
                        Text(
                          '${products.old_price.round()}',
                          style:  TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                       Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                           ShopCubit.get(context).changeFavorites(products.id);
                            print(products.id);
                          },
                          icon:  CircleAvatar(
                            radius: 15.0,
                            backgroundColor: ShopCubit.get(context).favorites[products.id] ? Colors.red :Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                            color:Colors.white,
                            size: 14.0,),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItems(DataModel model) => Stack
    (
    alignment: AlignmentDirectional.bottomCenter,
    children:  [
     Image(
        image: NetworkImage(model.image),
        height: 100,
        width: 100,
     fit: BoxFit.cover,),
      Container(
        color: Colors.black.withOpacity(.6,),
        width: 100.0,
        child:  Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:  TextStyle(
            fontSize: 12.0,
            color: Colors.white,
          ),

        ),
      ),

    ],
  );
}
