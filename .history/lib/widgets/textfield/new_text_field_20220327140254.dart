import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking_app/utils/styles.dart';

// ?? START -- CUSTOM TEXT FIELD
class NewField extends StatefulWidget {
  NewField(
      {this.onSaved,
      this.hintText,
      this.textInputType,
      this.textInputAction,
      this.initialValue,
      this.obsecure,
      this.maxLines,
      this.labelText,
      this.mandatory,
      this.controller, 
      this.readOnly});

  final String? hintText;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final bool? obsecure;
  final int? maxLines;
  final String? labelText;
  final bool? mandatory;
  final TextEditingController? controller;
  final bool? readOnly;

  @override
  _NewFieldState createState() => _NewFieldState();
}

class _NewFieldState extends State<NewField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
              child: Text(
                widget.hintText ?? '',
                style: Styles.primaryTitle,
              ),
            ),
            widget.mandatory == true
                ? const Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                    child: Text(
                      '*',
                      style: TextStyle(color: Styles.dangerColor),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                    child: Text(
                      '',
                      style: TextStyle(color: Styles.dangerColor),
                    ),
                  ),
          ],
        ),
        TextFormField(
          readOnly: widget.readOnly ?? false,
          controller: widget.controller,
          maxLines: widget.maxLines,
          obscureText: widget.obsecure ?? false,
          initialValue: widget.initialValue,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          onChanged: widget.onSaved,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12.withOpacity(0.05),
            hintText: widget.labelText ?? widget.hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}


// ?? START -- CLICKABLE TEXT FIELD
  class NewFieldClickable extends StatefulWidget {
    NewFieldClickable(
        {required this.onSaved,
        required this.hintText,
        this.textInputType,
        this.textInputAction,
        this.initialValue,
        this.obsecure,
        this.maxLines,
        this.labelText,
        this.mandatory,
        this.controller,
        this.onTap});

    final String hintText;
    final FormFieldSetter<String> onSaved;
    final TextInputType? textInputType;
    final TextInputAction? textInputAction;
    final String? initialValue;
    final bool? obsecure;
    final int? maxLines;
    final String? labelText;
    final bool? mandatory;
    final TextEditingController? controller;
    final Function()? onTap;

    @override
    _NewFieldClickableState createState() => _NewFieldClickableState();
  }

  class _NewFieldClickableState extends State<NewFieldClickable> {
    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                child: Text(
                  widget.hintText,
                  style: Styles.primaryTitle,
                ),
              ),
              widget.mandatory == true
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                      child: Text(
                        '*',
                        style: TextStyle(color: Styles.dangerColor),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                      child: Text(
                        '',
                        style: TextStyle(color: Styles.dangerColor),
                      ),
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 5,
                child: TextFormField(
                  readOnly: true,
                  controller: widget.controller,
                  maxLines: widget.maxLines,
                  obscureText: widget.obsecure ?? false,
                  initialValue: widget.initialValue,
                  textInputAction: widget.textInputAction,
                  keyboardType: widget.textInputType,
                  onChanged: widget.onSaved,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12.withOpacity(0.05),
                    hintText: widget.labelText ?? widget.hintText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Expanded(
                flex: 1, 
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ElevatedButton(
                      onPressed: widget.onTap,
                      child: const Icon(Icons.calendar_today, color: Styles.textColor), 
                      style: ElevatedButton.styleFrom(
                        primary: Styles.transparentColor, 
                        elevation: 0.0
                      ),),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
// ?? END -- CLICKABLE TEXT FIELD
