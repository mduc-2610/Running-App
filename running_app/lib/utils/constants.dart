import 'package:flutter/material.dart';

class APIEndpoints {
  static const BASE_URL = 'http://10.0.2.2:8000/api';
  static const ACCOUNT_URL = 'account';
  static const ACTIVITY_URL = 'activity';
  static const PRODUCT_URL = 'product';
  // static const LOGIN = '/auth/login';
  // static const products = '/products';
}

class TColor {
  static Color get PRIMARY => const Color(0xff7b61ff);
  static Color get PRIMARY_TEXT => const Color(0xffffffff);
  static Color get SECONDARY_TEXT => const Color(0xff7b61ff);
  static Color get DESCRIPTION => const Color(0xffcdcdcd);
  static Color get PRIMARY_BACKGROUND => const Color(0xff28333f);
  static Color get SECONDARY_BACKGROUND => const Color(0xff2f3c50);
  static Color get BUTTON => const Color(0xff7b61ff);
  static Color get BORDER_COLOR => const Color(0xff444b5e);
}

class FontSize {
  static const SMALL = 16.0;
  static const NORMAL = 18.0;
  static const LARGE = 20.0;
  static const BUTTON = 24.0;
  static const TITLE = 30.0;
}

class BShadow {
  static final BoxShadow customBoxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.5),
    spreadRadius: 3,
    blurRadius: 7,
    offset: const Offset(0, 3),
  );
}