import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/models/get_fav_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/moduels/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';

import 'consts.dart';

void navigateAndEnd(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void removeToken(context) =>
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        navigateAndEnd(context, LoginScreen());
      }
    });

Widget textFieldForm({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String label,
  @required IconData prefix,
  @required Function validate,
  Function onTap,
  IconData suffix,
  Function onSubmit,
  Function suffixPressed,
  bool isPassword = false,
  bool obsecure = true,
}) =>
    TextFormField(
      cursorColor: defaultColor,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.grey),
        labelText: label,
        prefixIcon: Icon(
          prefix,
          color: defaultColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: defaultColor,
                ))
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Color(0xff69A03A),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
          borderSide: const BorderSide(
            color: Color(0xff69A03A),
          ),
        ),
      ),
      keyboardType: type,
      validator: validate,
      controller: controller,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpper = true,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: background,
      ),
    );

void showToast({
  @required String text,
  @required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;

    case ToastState.ERROR:
      color = Colors.red;
      break;

    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget myDiv () => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0, ),
  child:   Container(
    height: 1.0,
    width: double.infinity,
    color: Colors.grey[300],
  ),
);

Widget buildFavItems(
    model ,
    context,
{bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.product.image),
              width: 120.0,
              height: 120.0,
            ),
            if (model.product.discount != 0 && isOldPrice)
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
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.product.price.toString()} ',
                    style:  TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  if (model.product.discount != 0 && isOldPrice)
                    Text(
                      '${model.product.oldPrice.toString()}',
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
                        ShopCubit.get(context).changeFavorites(model.product.id);
                        print(model.product.id);
                      },
                      icon:  CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubit.get(context).favorites[model.product.id] ? Colors.red :Colors.grey,
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
  ),
);


Widget buildSearchItems(ProductSearch productSearch , context, {bool isOldPrice = false}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(productSearch.image),
              width: 120.0,
              height: 120.0,
            ),
            if (productSearch.discount != 0 && isOldPrice)
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
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productSearch.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    productSearch.price.toString() ,
                    style:  TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  if (productSearch.discount != 0 && isOldPrice)
                    Text(
                      productSearch.oldPrice.toString(),
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
                        ShopCubit.get(context).changeFavorites(productSearch.id);
                        print(productSearch.id);
                      },
                      icon:  CircleAvatar(
                        radius: 15.0,
                        // backgroundColor: ShopCubit.get(context).favorites??[{productSearch.id }] ? Colors.red :Colors.grey,
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
  ),
);