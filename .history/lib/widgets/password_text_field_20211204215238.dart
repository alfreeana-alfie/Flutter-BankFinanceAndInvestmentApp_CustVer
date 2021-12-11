import 'package:flutter/material.dart';
import 'package:local_shop/constant/app_color.dart';
import 'package:local_shop/constant/constants.dart';

class CustomPassword extends StatefulWidget {
  const CustomPassword({required this.onSaved, required this.hintText, required this.isObsecureText});

  // final Key fieldKey;
  // final int maxLength;
  final String hintText;
  // final String labelText;
  // final String helperText;
  final FormFieldSetter<String> onSaved;
  final bool isObsecureText;
  // final FormFieldValidator<String> validator;
  // final ValueChanged<String> onFieldSubmitted;

  @override
  _CustomPasswordState createState() => _CustomPasswordState();
}

class _CustomPasswordState extends State<CustomPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
      horizontal: horizontalValue, vertical: verticalValue),
      child: TextFormField(
        onChanged: widget.onSaved,
        obscureText: true,
        decoration: InputDecoration(
          filled: widget.isObsecureText,
          fillColor: Colors.black12.withOpacity(0.05),
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
