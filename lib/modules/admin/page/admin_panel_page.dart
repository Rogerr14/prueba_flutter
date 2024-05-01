import 'package:flutter/material.dart';
import 'package:prueba_app/shared/widget/layout_widget.dart';


class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  @override
  Widget build(BuildContext context) {
    return const LayoutPageWidget(
      titleAppBar: 'Admin Panel' ,
      child: Center(
        
      ), 
      );
  }
}