import 'package:flutter/material.dart';

FormFieldValidator<String> passwordValidator(String errorString) {
  return (val) {
    if (val.length == 0) return errorString;
    return null;
  };
}

class PasswordField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onSaved;
  final bool isLast;

  PasswordField({
    Key key,
    this.hintText,
    this.icon,
    this.validator,
    this.onSaved,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      autocorrect: false,
      onSaved: onSaved,
      validator: validator,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      obscureText: true,
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
