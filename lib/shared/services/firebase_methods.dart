import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:prueba_app/env/config/base_config.dart';
import 'package:http/http.dart' as http;

class FirebaseAuthentication {
  
 FirebaseAuth auth = FirebaseAuth.instance;


 Future<bool> registerWithEmailAndPassword(String email, String password) async {
  try {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
   
    
    return true;

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('La contraseña debe ser más segura.');
    } else if (e.code == 'email-already-in-use') {
      print('El correo electrónico ya está en uso.');
    } else {
      print('Error de registro: ${e.code}');
    }
    return false;
  }}

Future<bool> signInWithEmailAndPassword(String email, String password) async {
  try {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
    
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('Usuario no encontrado.');
    } else if (e.code == 'wrong-password') {
      print('Contraseña incorrecta.');
    } else {
      print('Error de autenticación: ${e.code}');
    }
    return false;
  }
}




}
