import 'package:flutter/material.dart';
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
      
      child: Scaffold(
          body: Center(
            child: Text('home page'),
          ),
      ),
    );
  }
}
