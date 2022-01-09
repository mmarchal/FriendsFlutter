import 'package:flutter/material.dart';
import 'package:life_friends/ui/utils/colors.dart';

class LoginText extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool isPassword;

  const LoginText(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.hint,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            icon,
            color: const Color(bleuCiel),
          ),
          hintText: hint,
        ),
      ),
    );
  }
}
