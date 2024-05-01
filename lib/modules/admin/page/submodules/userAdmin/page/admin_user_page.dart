import 'package:flutter/material.dart';
import 'package:prueba_app/shared/widget/layout_widget.dart';

class AdminUserPage extends StatefulWidget {
  const AdminUserPage({super.key});

  @override
  State<AdminUserPage> createState() => _AdminUserPageState();
}

class _AdminUserPageState extends State<AdminUserPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutPageWidget(
      titleAppBar: 'Administrar Usuarios',
      child:Container()
  );}
}
