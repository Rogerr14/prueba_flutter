import 'package:flutter/material.dart';
import 'package:prueba_app/shared/widget/layout_widget.dart';

class PermissionAdminPage extends StatefulWidget {
  const PermissionAdminPage({super.key});

  @override
  State<PermissionAdminPage> createState() => _PermissionAdminPageState();
}

class _PermissionAdminPageState extends State<PermissionAdminPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutPageWidget(
      titleAppBar: 'Permisos Usuarios',
      child: Container(),
    );
  }
}
