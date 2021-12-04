import 'package:flutter/material.dart';
import 'package:local_shop/constant/app_color.dart';
import 'package:local_shop/constant/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({required this.onSaved, required this.hintText});

  // final Key fieldKey;
  // final int maxLength;
  final String hintText;
  // final String labelText;
  // final String helperText;
  final FormFieldSetter<String> onSaved;
  // final FormFieldValidator<String> validator;
  // final ValueChanged<String> onFieldSubmitted;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: horizontalValue, vertical: verticalValue),
      child: TextFormField(
        onChanged: widget.onSaved,
        decoration: InputDecoration(
          filled: true,
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
