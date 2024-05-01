
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prueba_app/shared/providers/functional_provider.dart';
import 'package:prueba_app/shared/services/firebase_methods.dart';


class WidgetForm extends StatefulWidget {
  const WidgetForm({
    super.key,
  });

  @override
  State<WidgetForm> createState() => _WidgetFormState();
}

class _WidgetFormState extends State<WidgetForm> {
    final _formKey = GlobalKey<FormState>();

    final emailController = TextEditingController();

    final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
       FirebaseAuthentication authMethods = FirebaseAuthentication();
   
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Registrar usuario', style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700
            ),),
            SizedBox(height: 20,),
            textFormFieldWidget(hintText: 'Correo', controller: emailController,),
            SizedBox(height: 20,),
            textFormFieldWidget(hintText: 'Contraseña', controller: passwordController,),
            SizedBox(height: 30,),
            OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                   if(await authMethods.registerWithEmailAndPassword(emailController.text, passwordController.text)){
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                   }
                  }
                },
                child: Text('login'),
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50)),
              ),

          SizedBox(height: 10,),
              TextButton(onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }, child: Text('Inicia Sesion'))
          ],
        
        ),
      ),);
  }
}

class textFormFieldWidget extends StatelessWidget {
  const textFormFieldWidget({
    super.key, required this.hintText, required this.controller,
  });
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo vacio';
                  } else {
                    return null;
                  }
                },
         decoration: InputDecoration(
                  constraints: BoxConstraints(maxWidth: 300),
                  hintText: hintText,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
      
    );
  }
}
