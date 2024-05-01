import 'package:flutter/material.dart';
import 'package:prueba_app/env/app_theme.dart';
import 'package:prueba_app/modules/auth/login/widget/widget_form.dart';
import 'package:prueba_app/shared/widget/layout_widget.dart';

class LoginPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>>? keyPage;
  const LoginPage({super.key, this.keyPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutPageWidget(
      titleAppBar: '',
      
      child: Center(
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.6,
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: WidgetForm(),
        ),
      ),
    );
  }
}

