import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prueba_app/env/app_theme.dart';
import 'package:prueba_app/shared/widget/layout_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutPageWidget(
      titleAppBar: 'Home Page',
      requiredStack: false,
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        appBar: AppBar(
          title: Text('Panel Administrador'),
          centerTitle: true,
        ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinebuttonWidget(title: 'Administrar Usuario', icon: Icons.person,onPressed: () =>
                                        Navigator.pushNamed(context, '/adminUser')

                
                ),
                SizedBox(height: 20,),
                OutlinebuttonWidget(title: 'Gestionar Permisos', icon: Icons.admin_panel_settings_rounded,onPressed: () {
                                        Navigator.pushNamed(context, '/permission');
                },),
                SizedBox(height: 20,),
                OutlinebuttonWidget(title: 'Registros de Acceso', icon: Icons.format_align_center,onPressed: () =>
                                        Navigator.pushNamed(context, '/accessRegistry'))

                ,
                SizedBox(height: 20,),
            
              ],
            ),
          )
      ),
    );
  }
}

class OutlinebuttonWidget extends StatelessWidget {
  const OutlinebuttonWidget({
    super.key, required this.title, required this.icon, required this.onPressed,
  });
  final String title;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 120,
      child: OutlinedButton(onPressed: onPressed, child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(title)
                  
        ],
      )),
    );
  }
}
