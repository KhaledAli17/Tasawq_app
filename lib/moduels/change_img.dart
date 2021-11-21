import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/models/login_model.dart';

class ChangeImg extends StatefulWidget {
  const ChangeImg({Key key}) : super(key: key);

  @override
  _ChangeState createState() => _ChangeState();
}

class _ChangeState extends State<ChangeImg> {
  File img;
  @override
  Widget build(
    BuildContext context,
  ) {
    return buildSetting(
      ShopCubit.get(context).userData.data,
      context,
    );
  }

  Widget buildSetting(
    UserData userData,
    context,
  ) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black26,
              border: Border.all(
                color: defaultColor,
                width: 3,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image(
                            width: 120.0,
                            height: 120.0,
                            image: img == null
                                ? NetworkImage(userData.image)
                                : FileImage(img)),
                        CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.grey[300],
                          child: IconButton(
                            iconSize: 20.0,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Center(
                                        child: Text(
                                          'Choose option',
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            Center(
                                              child: InkWell(
                                                onTap: () {
                                                  pickImg(ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.camera),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      'Camera',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15.0,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                pickImg(ImageSource.gallery);
                                                Navigator.pop(context, [img]);
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(Icons.photo),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Text(
                                                    'Gallery',
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: defaultColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildProfileItem(icon: Icons.person, text: userData.name),
                  myDiv(),
                  buildProfileItem(
                      icon: Icons.email_outlined, text: userData.email),
                  myDiv(),
                  buildProfileItem(icon: Icons.phone, text: userData.phone),
                  SizedBox(
                    height: 70.0,
                  ),
                  defaultButton(
                      isUpper: false,
                      function: () {
                        removeToken(context);
                      },
                      text: 'LogOut'),
                ],
              ),
            ),
          ),
        ),
      );
  Widget buildProfileItem({IconData icon, String text}) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 26.0,
              color: defaultColor,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      );
  void showDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Choose option',
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        pickImg(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.camera),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Camera',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: () {
                      pickImg(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.photo),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Gallery',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void pickImg(source) async {
    var image = await ImagePicker().pickImage(source: source);
    File file = File(image.path);

    setState(() {
      img = file;
    });
  }
}
