import 'package:flutter/material.dart';

FormFieldValidator<String> emptyValidator(String errorString) {
  return (val) {
    if (val.isEmpty) return errorString;
    return null;
  };
}

FormFieldValidator<String> emailValidator() {
  return (val) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(val)) return 'Enter a valid email';
    return null;
  };
}

FormFieldValidator<String> urlValidator() {
  return (val) {
    var urlPattern =
        r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    RegExp match = RegExp(urlPattern, caseSensitive: false);
    match = RegExp(urlPattern, caseSensitive: false);
    if (!match.hasMatch(val)) return 'Enter a valid URL';
    return null;
  };
}

class InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onSaved;
  final bool isLast;

  InputField({
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
