





import 'package:flutter/material.dart';
import 'package:prueba_app/modules/404/page/page_404.dart';
import 'package:prueba_app/modules/admin/page/submodules/accesreRegistry/page/access_registry_page.dart';
import 'package:prueba_app/modules/admin/page/submodules/permisionAdmin/page/permission_admin_page.dart';
import 'package:prueba_app/modules/admin/page/submodules/userAdmin/page/admin_user_page.dart';
import 'package:prueba_app/modules/auth/login/pages/login_page.dart';
import 'package:prueba_app/modules/auth/register/page/register_page.dart';
import 'package:prueba_app/modules/home/page/home_page.dart';
import 'package:prueba_app/modules/splash/pages/splash_page.dart';

class AppRoutes{

  static const initialRoute =  "/splash";

  static final Map<String, WidgetBuilder> routes ={
    '/splash' :(context) => const SplashPage(),
    '/login' : (context) => const LoginPage(),
    '/register' : (context) => const RegisterPage(),
    '/' :  (context) => const HomePage(),
    '/adminuser' :  (context) => const AdminUserPage(),
    '/permission' :  (context) => const PermissionAdminPage(),
    '/accessRegistry' :  (context) => const AccesRegistryPage(),
    // '/' :  (context) => const HomePage()

  };


  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(builder: (context) => const PageNotFound());
  }

}