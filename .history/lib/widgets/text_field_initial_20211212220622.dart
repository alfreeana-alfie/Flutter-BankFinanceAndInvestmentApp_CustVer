import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldInitialCustom extends StatefulWidget {
  TextFieldInitialCustom(
      {required this.onSaved,
      required this.hintText,
      this.textInputType,
      this.textInputAction,
      this.initialValue});

  final String hintText;
  final FormFieldSetter<String> onSaved;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String initialValue;

  @override
  _TextFieldInitialCustomState createState() => _TextFieldInitialCustomState();
}

class _TextFieldInitialCustomState extends State<TextFieldInitialCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      onChanged: widget.onSaved,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        hintText: widget.hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none),
      ),
    );
  }
}
