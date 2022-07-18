import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/services.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(
                  titulo: 'Messenger',
                ),
                _Form(),
                Labels(
                    text: '¿No tienes cuenta?',
                    textLink: 'Crea una cuenta ahora!',
                    ruta: 'register'),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final TextEditingController emailController =
      TextEditingController(text: 'test1@test.com');
  final TextEditingController passwordController =
      TextEditingController(text: '123');

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email_outlined,
            labelText: 'Email',
            textController: emailController,
            textInputType: TextInputType.emailAddress,
          ),
          CustomInput(
            labelText: 'Contraseña',
            icon: Icons.lock_outlined,
            textController: passwordController,
            textInputType: TextInputType.emailAddress,
            isPassword: true,
          ),
          BotonAncho(
            text: 'Iniciar sesion',
            color: Colors.blue,
            onPressed: authService.autenticando
                ? null
                : () async {
                    // print(emailController.text);
                    // print(passwordController.text);

                    FocusScope.of(context).unfocus();

                    final loginOK = await authService.login(
                        emailController.text.trim(),
                        passwordController.text.trim());

                    if (loginOK == true) {
                      // print(await AuthService.getToken());

                      //TODO: Contectar a nuestro socket server.

                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      //mostrarAlerta(context, 'Error', 'Revise sus credenciales nuevamente');

                      mostrarAlerta(context, loginOK['titulo'], loginOK['msg']);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
