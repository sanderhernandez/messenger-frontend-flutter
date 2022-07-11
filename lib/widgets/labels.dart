import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String textLink;
  final String text;
  final String ruta;

  const Labels(
      {Key? key,
      required this.textLink,
      required this.ruta,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(text,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300)),
        GestureDetector(
          child: Text(
            textLink,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, ruta);
          },
        ),
      ],
    ));
  }
}
