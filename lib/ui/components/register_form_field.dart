import 'package:flutter/material.dart';

FormFieldValidator<String> emptyValidator(String errorString) {
  return (val) {
    if (val.length == 0) return errorString;
    return null;
  };
}

class RegisterFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onSaved;

  RegisterFormField({
    Key key,
    this.hintText,
    this.icon,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w200,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}