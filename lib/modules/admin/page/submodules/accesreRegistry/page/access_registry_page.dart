import 'package:flutter/material.dart';
import 'package:prueba_app/shared/widget/layout_widget.dart';

class AccesRegistryPage extends StatefulWidget {
  const AccesRegistryPage({super.key});

  @override
  State<AccesRegistryPage> createState() => _AccesRegistryPageState();
}

class _AccesRegistryPageState extends State<AccesRegistryPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutPageWidget(
      titleAppBar: 'Registro de Acceso',
      requiredStack: false,
      child: Scaffold(

      ),
    );
  }
}
