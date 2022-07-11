import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                Logo(titulo: 'Registro'),
                _Form(),
                Labels(
                  text: 'Si ya tienes cuenta',
                  textLink: 'Inicia sesion',
                  ruta: 'login',
                ),
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verifyPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.person_outlined,
            labelText: 'Nombre',
            textController: nameController,
            textInputType: TextInputType.text,
          ),
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
          CustomInput(
            labelText: 'Verificar contraseña',
            icon: Icons.lock_outlined,
            textController: verifyPasswordController,
            textInputType: TextInputType.emailAddress,
            isPassword: true,
          ),
          BotonAncho(
            text: 'Crear cuenta',
            color: Colors.blue,
            onPressed: () {
              print(emailController.text);

              print(passwordController.text);

              if (passwordController.text == verifyPasswordController.text) {
                print('Password verificado!');
              }
            },
          ),
        ],
      ),
    );
  }
}
