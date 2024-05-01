


import 'package:flutter/material.dart';
import 'package:prueba_app/env/app_theme.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
          const Duration(seconds: 3),
          () => Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: AppTheme.secundaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text('Splash Page', style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700
            ),),
          ),
        ),
      ),
    );
  }
}