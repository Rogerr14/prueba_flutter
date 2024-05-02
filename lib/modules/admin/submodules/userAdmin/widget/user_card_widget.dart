import 'package:flutter/material.dart';
import 'package:prueba_app/env/theme/app_theme.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({
    super.key,  required this.icon, required this.onPress, required this.name, required this.lastName, required this.email, required this.acces,
  });
  final String name;
  final String lastName;
  final String email;
  final List<dynamic> acces;
  final IconData icon;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppTheme.secundaryColor,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onPress,
          child:  SizedBox(
            width: 350,
            height: 100,
            child: Center(
              child: Row(
                mainAxisAlignment:   MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nombre: $name', style: TextStyle(color: AppTheme.white, fontSize: 15, fontWeight: FontWeight.w600),),
                      Text('Apellido: $lastName', style: TextStyle(color: AppTheme.white, fontSize: 15, fontWeight: FontWeight.w600),),
                      Text('Correo: $email', style: TextStyle(color: AppTheme.white, fontSize: 15, fontWeight: FontWeight.w600),),
                      // Text('Accesos: $acces', style: TextStyle(color: AppTheme.white, fontSize: 10, fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}