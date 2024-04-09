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
  static Color get SECONDARY => const Color(0xff3362f5);
  // static Color get PRIMARY => Colors.green;
  static Color get PRIMARY_TEXT => const Color(0xffffffff);
  static Color get SECONDARY_TEXT => const Color(0xff7b61ff);
  static Color get DESCRIPTION => const Color(0xffcdcdcd);
  static Color get PRIMARY_BACKGROUND => const Color(0xff28333f);
  static Color get SECONDARY_BACKGROUND => const Color(0xff2f3c50);
  static Color get BUTTON => const Color(0xff7b61ff);
  static Color get WARNING => const Color(0xffCD452A);
  static Color get BACKGROUND_WARNING => const Color(0xfffdf2f0);
  static Color get BORDER_COLOR => const Color(0xff444b5e);
  static Color get BUTTON_DISABLED => const Color(0xff979797);
  static Color get ACCEPTED => const Color(0xff6cb64f);
}

class TImage {
  static String get PRIMARY_BACKGROUND_IMAGE => "assets/img/home/background_1.png";
}

class FontSize {
  static const EXTRA_SMALL = 14.0;
  static const SMALL = 16.0;
  static const NORMAL = 18.0;
  static const LARGE = 20.0;
  static const EXTRA_LARGE = 22.0;
  static const BUTTON = 24.0;
  static const TITLE = 30.0;
}

class TxtStyle {
  static TextStyle get normalText => TextStyle(
      color: TColor.PRIMARY_TEXT,
      fontSize: FontSize.NORMAL,
      fontWeight: FontWeight.w600,
      // letterSpacing: 0.8
  );
  static TextStyle get normalTextDesc => TextStyle(
      color: TColor.DESCRIPTION,
      fontSize: FontSize.SMALL,
      // fontWeight: FontWeight.w600,
      // letterSpacing: 0.8
  );
  static TextStyle get largeTextDesc => TextStyle(
    color: TColor.DESCRIPTION,
    fontSize: FontSize.NORMAL,
    // fontWeight: FontWeight.w600,
    // letterSpacing: 0.8
  );
  static TextStyle get normalTextWarning => TextStyle(
    color: TColor.WARNING,
    fontSize: FontSize.SMALL,
    // fontWeight: FontWeight.w600,
    // letterSpacing: 0.8
  );

  static TextStyle get extraLargeText => TextStyle(
      color: TColor.PRIMARY_TEXT,
      fontSize: FontSize.EXTRA_LARGE,
      fontWeight: FontWeight.w900,
      letterSpacing: 0.8
  );
  static TextStyle get headSection => TextStyle(
    color: TColor.PRIMARY_TEXT,
    fontSize: FontSize.LARGE,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.95
  );

  static TextStyle get headSectionExtra => TextStyle(
      color: TColor.PRIMARY_TEXT,
      fontSize: FontSize.EXTRA_LARGE,
      fontWeight: FontWeight.w900,
      letterSpacing: 0.95
  );

  static TextStyle get headSectionWarning => TextStyle(
      color: TColor.WARNING,
      fontSize: FontSize.LARGE,
      fontWeight: FontWeight.w900,
      letterSpacing: 0.95
  );

  static TextStyle get descSection => TextStyle(
      color: TColor.DESCRIPTION,
      fontSize: FontSize.EXTRA_SMALL,
  );
  static TextStyle get descSectionNormal => TextStyle(
    color: TColor.DESCRIPTION,
    fontSize: FontSize.SMALL,
  );
}

class Month {
  static final Map<String, int> MONTH_MAP = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12,
  };

  static final Map<int, String>  REVERSED_MONTH_MAP = MONTH_MAP.map((key, value) =>
      MapEntry(value, key));
}

class PrivacyConvert {
  static final Map<String, String> CONVERT = {
    "Free to follow": "NO_APPROVAL",
    "Request to follow": "APPROVAL",
    "Public": "EVERYONE",
    "Followers Only": "FOLLOWER",
    "Only me": "ONLY_ME",
  };

  static final Map<String, String> REVERSED_CONVERT = CONVERT.map((key, value) => MapEntry(value, key));
}

class BtnState {
  static Map<String, dynamic> get buttonStateClicked => {
    "iconColor": TColor.PRIMARY,
    "backgroundColor": Colors.transparent,
    "borderColor": TColor.PRIMARY,
    "textColor": TColor.PRIMARY,
  };

  static Map<String, dynamic> get buttonStateUnClicked => {
    "iconColor": TColor.PRIMARY_TEXT,
    "backgroundColor": TColor.SECONDARY_BACKGROUND,
    "borderColor": TColor.BORDER_COLOR,
    "textColor": TColor.PRIMARY_TEXT,
  };

}
class BShadow {
  static final BoxShadow customBoxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.5),
    spreadRadius: 3,
    blurRadius: 7,
    offset: const Offset(0, 3),
  );
}