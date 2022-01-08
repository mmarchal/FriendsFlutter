import 'package:flutter/material.dart';

class LoginRightText extends StatelessWidget{

  final String title;

  const LoginRightText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: 32,
            right: 32
        ),
        child: Text(title,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18
          ),
        ),
      ),
    );
  }

}