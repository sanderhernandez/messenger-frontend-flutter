import 'package:flutter/material.dart';

class BotonAncho extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color;
  const BotonAncho(
      {Key? key, required this.text, required this.color, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
      onPressed: onPressed,
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
          // shape: MaterialStateProperty<StadiumBorder>(),
          ),
    );
  }
}
