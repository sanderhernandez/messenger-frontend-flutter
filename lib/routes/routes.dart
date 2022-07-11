import 'package:chat/screens/screens.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'loading': (_) => LoadingScreen(),
  'register': (_) => RegisterScreen(),
  'login': (_) => LoginScreen(),
  'usuarios': (_) => UsuariosScreen(),
  'chat': (_) => ChatScreen(),
};
