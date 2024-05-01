
import 'package:flutter/material.dart';
import 'package:prueba_app/env/app_theme.dart';

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget({
    super.key,
    this.onPressed,
    this.color = Colors.lightBlue,
    required this.text,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = 25,
  });

  final void Function()? onPressed;
  final Color? color;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(width!, height!)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(color),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style:TextStyle(
          color: AppTheme.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
