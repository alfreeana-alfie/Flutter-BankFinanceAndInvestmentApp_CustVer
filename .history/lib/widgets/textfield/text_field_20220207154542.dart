import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom(
      {required this.onSaved,
      required this.hintText,
      this.textInputType,
      this.textInputAction,
      this.initialValue, 
      this.obsecure});

  final String hintText;
  final FormFieldSetter<String> onSaved;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final bool? obsecure;
  final Function(String?)? validator;

  @override
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obsecure ?? false,
      initialValue: widget.initialValue,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      onChanged: widget.onSaved,
      validator: ,
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
