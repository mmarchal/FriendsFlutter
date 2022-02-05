import 'package:flutter/material.dart';

class EditableWidget extends StatefulWidget {
  final String label;
  final String value;
  final TextEditingController controller;

  const EditableWidget(
      {Key? key,
      required this.label,
      required this.controller,
      required this.value})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditableWidgetState();
  }
}

class EditableWidgetState extends State<EditableWidget> {
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.value;
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("${widget.label} : "),
          Expanded(
            child: (isEditable)
                ? TextFormField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(fontSize: 18.0),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0))),
                  )
                : Text(widget.value),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  isEditable = !isEditable;
                });
              },
              icon: Icon((isEditable) ? Icons.check : Icons.edit)),
        ],
      ),
    );
  }
}
