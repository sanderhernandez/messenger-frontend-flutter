import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: 170,
      child: Column(
        children: [
          Image(image: AssetImage('assets/tag-logo.png')),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(titulo, style: TextStyle(fontSize: 30)),
          ),
        ],
      ),
    );
  }
}
