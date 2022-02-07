import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking_app/utils/styles.dart';

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom(
      {required this.onSaved,
      required this.hintText,
      this.textInputType,
      this.textInputAction,
      this.initialValue, 
      this.obsecure, 
      this.validator,
      this.suffixIcon,
      this.suffixIconColor});

  final String hintText;
  final FormFieldSetter<String> onSaved;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final bool? obsecure;
  final String Function(String?)? validator;
  final Color? suffixIconColor;
  final Icon? suffixIcon;

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
      validator: widget.validator,
      decoration: InputDecoration(
        errorMaxLines: 1,
        suffixIcon: widget.suffixIcon,
        suffixIconColor: widget.suffixIconColor,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        hintText: widget.hintText,
        enabledBorder: const OutlineInputBorder(
          
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          borderRadius: BorderRadius.circular(7),
        ),
        // border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(7),
        //     borderSide: BorderSide(color: const Color(0x2596be), width: 23.0),
        //     // borderSide: BorderSide.none,
        // ),
      ),
    );
  }
}
