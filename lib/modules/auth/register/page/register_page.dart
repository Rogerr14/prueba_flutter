import 'package:flutter/material.dart';
import 'package:prueba_app/env/app_theme.dart';
import 'package:prueba_app/modules/auth/register/widget/widget_form.dart';
import 'package:prueba_app/shared/widget/layout_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.keyPage});
  final GlobalKey<State<StatefulWidget>>? keyPage;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

