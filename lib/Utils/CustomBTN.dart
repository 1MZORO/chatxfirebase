import 'package:flutter/material.dart';

class CustomBTN extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomBTN({super.key, required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            padding: EdgeInsets.symmetric(horizontal: 12),
            minimumSize: Size(360, 50),
          ),
          onPressed: onPressed,
          child: Text(text,style: TextStyle(
            color: Colors.black54
          ),)),
    );
  }
}
