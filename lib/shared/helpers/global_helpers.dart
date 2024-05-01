



import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class GlobalHelper{
   static final emailRegExp =  RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

 static GlobalKey genKey() {
    GlobalKey key = GlobalKey();
    return key;
  }

  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

    static final logger = Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false));
  static Route navigationFadeIn(BuildContext context, Widget page) {
    return PageRouteBuilder(
      fullscreenDialog: true,
      reverseTransitionDuration: const Duration(milliseconds: 100),
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
    );
  }


  
}