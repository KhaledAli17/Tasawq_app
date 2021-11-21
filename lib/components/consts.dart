



import 'package:flutter/material.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/moduels/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';

const Color defaultColor = Color(0xff69A03A);
const MaterialColor kPrimaryColor = MaterialColor(
  0xff69A03A,
  <int, Color>{
    50: const Color(0xFF0E7AC7),
    100: const Color(0xFF0E7AC7),
    200: const Color(0xFF0E7AC7),
    300: const Color(0xFF0E7AC7),
    400: const Color(0xFF0E7AC7),
    500: const Color(0xFF0E7AC7),
    600: const Color(0xFF0E7AC7),
    700: const Color(0xFF0E7AC7),
    800: const Color(0xFF0E7AC7),
    900: const Color(0xFF0E7AC7),
  },
);
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
