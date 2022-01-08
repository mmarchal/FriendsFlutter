import 'package:flutter/material.dart';

class SignTextField extends StatelessWidget {

  final String title;
  final TextEditingController controller;

  const SignTextField({Key? key, required this.title, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.2,
      height: 45,
      padding: const EdgeInsets.only(
          top: 4,left: 16, right: 16, bottom: 4
      ),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(50)
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5
            )
          ]
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title,
        ),
      ),
    );
  }

}