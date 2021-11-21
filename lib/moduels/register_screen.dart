import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/moduels/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  // bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopSucssesRegisterState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigateAndEnd(context, HomeScreen());
              });
            } else {
              print(state.loginModel.message);

              showToast(
                  text: state.loginModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
                    height: 100.0,
                    color: defaultColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BerthaMelanie',
                            ),
                          ),
                          const Text(
                            'let\'s join to us',
                            style: TextStyle(
                              fontSize: 20.0,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'BerthaMelanie',
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          textFieldForm(
                            controller: nameController,
                            type: TextInputType.name,
                            label: 'name',
                            prefix: Icons.person,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          textFieldForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'email',
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          textFieldForm(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'password',
                            prefix: Icons.lock,
                            suffix: ShopCubit.get(context).suffix,
                            isPassword: ShopCubit.get(context).isPassword,
                            suffixPressed: () {
                              ShopCubit.get(context).changePassVisibility();
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'enter correct password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          textFieldForm(
                            controller: phoneController,
                            type: TextInputType.phone,
                            label: 'phone',
                            prefix: Icons.phone,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your phone';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoadingRegisterState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    ShopCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                text: 'Register'),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Have an account?',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateAndEnd(context, LoginScreen());
                                  },
                                  child: const Text(
                                    'login with account',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                        ]),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
