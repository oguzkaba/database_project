import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.press,
      required this.text,
      required this.width,
      this.enabled = true})
      : super(key: key);

  final Function() press;
  final String text;
  final double? width;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: enabled == true ? press : null,
        child: Text(text),
      ),
    );
  }
}
