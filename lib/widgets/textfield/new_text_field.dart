import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking_app/utils/styles.dart';

class NewField extends StatefulWidget {
  NewField(
      {required this.onSaved,
      required this.hintText,
      this.textInputType,
      this.textInputAction,
      this.initialValue,
      this.obsecure,
      this.maxLines});

  final String hintText;
  final FormFieldSetter<String> onSaved;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final bool? obsecure;
  final int? maxLines;

  @override
  _NewFieldState createState() => _NewFieldState();
}

class _NewFieldState extends State<NewField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(7,0,0, 10),
          child: Text(
            widget.hintText,
            style: const TextStyle(
                color: Styles.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          maxLines: widget.maxLines,
          obscureText: widget.obsecure ?? false,
          initialValue: widget.initialValue,
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
        ),
      ],
    );
  }
}
