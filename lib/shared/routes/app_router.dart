





import 'package:flutter/material.dart';
import 'package:prueba_app/modules/404/page/page_404.dart';
import 'package:prueba_app/modules/auth/login/pages/login_page.dart';

import 'package:prueba_app/modules/splash/pages/splash_page.dart';

class AppRoutes{
  static const initialRoute = '/splash';

  static Map<String, Widget Function(BuildContext)> routes ={
    '/splash' : (_) => const SplashPage(),
    '/login' : (_) =>  const LoginPage(),
    
    // //'/change_password' : (_) =>  const ChangePasswordPage(),
    // // '/home' : (_) => const HomePage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const PageNotFound(),
    );
  }
}
