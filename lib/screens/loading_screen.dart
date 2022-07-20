import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/screens/screens.dart';
import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Cargando..."),
                ],
              ),
            );

            // } else if (snapshot.hasError) {
            //   return Center(child: Icon(Icons.error_outline));
            // } else {
            //   return
            // }
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    final socketService = Provider.of<SocketService>(context, listen: false);

    // await Future.delayed(Duration(seconds: 10));

    if (autenticado == true) {
      /// isLoggedIn = true (está logeado):

      /// Conectar al socket server.
      socketService.connect();

      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => UsuariosScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    } else if (autenticado == false) {
      /// isLoggedIn = false (No está logeado):

      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      mostrarAlerta(context, autenticado['titulo'], autenticado['msg']);
      // SnackBar(
      //   content: Text(autenticado['msg']),
      // );
    }
  }
}
