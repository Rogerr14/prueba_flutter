
import 'package:flutter/material.dart';
import 'package:prueba_app/env/theme/app_theme.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({
    super.key,  required this.icon,  required this.name, required this.lista,
  });
  final String name;
  final List<dynamic> lista;
  final IconData icon;
  // final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppTheme.secundaryColor,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          // onTap: onPress,
          child:  SizedBox(
            width: 350,
            height: 100,
            child: Center(
              child: Row(
                mainAxisAlignment:   MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name, style: TextStyle(color: AppTheme.white, fontSize: 20, fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      if(lista.isNotEmpty)
                      Text(DateTime.fromMicrosecondsSinceEpoch(lista[0].seconds*1000000).toString(), style: TextStyle(color: AppTheme.white, fontSize: 10, fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      if(lista.isNotEmpty)
                      Text(lista[1], style: TextStyle(color: AppTheme.white, fontSize: 20, fontWeight: FontWeight.w600),),
                      
                      
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}