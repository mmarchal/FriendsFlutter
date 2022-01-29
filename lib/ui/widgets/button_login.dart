import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const ButtonLogin({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff6bceff),
                Color(0xFF00abff),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
