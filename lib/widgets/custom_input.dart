import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final TextEditingController textController;
  final TextInputType textInputType;
  final bool? isPassword;

  const CustomInput(
      {Key? key,
      this.icon,
      required this.labelText,
      required this.textController,
      required this.textInputType,
      this.isPassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(left: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: textInputType,
        obscureText: isPassword ?? false,
        decoration: InputDecoration(
          // hintText: 'Email',
          labelText: labelText,
          prefixIcon: Icon(icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
