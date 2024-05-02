import 'package:flutter/material.dart';
import 'package:prueba_app/env/theme/app_theme.dart';
import 'package:prueba_app/modules/admin/submodules/accesreRegistry/widget/user_card_widget.dart';
import 'package:prueba_app/shared/services/db_service.dart';
import 'package:prueba_app/shared/widget/layout_widget.dart';

class AccessRegistryPage extends StatefulWidget {
    final GlobalKey<State<StatefulWidget>>? keyPage;
  final String title;
  final IconData icon;
  const AccessRegistryPage({super.key, this.keyPage, required this.title, required this.icon});

  @override
  State<AccessRegistryPage> createState() => _AccessRegistryPageState();
}

class _AccessRegistryPageState extends State<AccessRegistryPage> {
  FirebaseDatabaseServices databaseServices = FirebaseDatabaseServices();
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      nameInterceptor: 'accessRegistry',
      requiredStack: false,
      keyDismiss: widget.keyPage,
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        appBar: AppBar(
          backgroundColor: AppTheme.secundaryColor,
          elevation: 20,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
              SizedBox(width: 10,),
              Icon(widget.icon, color: AppTheme.primaryColor,size: 30,)
            ],
          ),
          centerTitle: true,
          //  backgroundColor: AppTheme.secundaryColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SizedBox(height: 20,),
            // FilledButtonWidget(text: 'Agregar usuarios', onPressed: (){},),
            Expanded(
              child: FutureBuilder(
                future: databaseServices.getAllRegistry(),
                builder:(context, snapshot) => 
                 ListView.builder(
                  itemCount:databaseServices.usuarios.length,    
                  itemBuilder: (context, index) {
                    final user = databaseServices.usuarios[index];
                     return UserCardWidget(name: user.name, icon: Icons.abc, lista: user.singin,);},
                  ),
              ),
            ),
          ],
        ),
      ), 
      );
  }
}