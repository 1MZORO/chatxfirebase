import 'package:flutter/material.dart';

class CustomTF extends StatelessWidget {
  final String text;
  final TextEditingController clt;
  final bool obscure;
  const CustomTF({super.key, required this.text, required this.obscure, required this.clt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: clt,
        obscureText: obscure,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: text,
        ),
      ),
    );
  }
}
