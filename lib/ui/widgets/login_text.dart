import 'package:flutter/material.dart';
import 'package:life_friends/ui/utils/colors.dart';

class LoginText extends StatefulWidget {
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
  State<StatefulWidget> createState() {
    return LoginTextState();
  }
}

class LoginTextState extends State<LoginText> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: !showPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  widget.icon,
                  color: const Color(bleuCiel),
                ),
                hintText: widget.hint,
              ),
            ),
          ),
          if (widget.isPassword)
            IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon((showPassword)
                    ? Icons.visibility_off
                    : Icons.remove_red_eye))
        ],
      ),
    );
  }
}
