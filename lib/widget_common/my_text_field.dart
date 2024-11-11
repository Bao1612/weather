import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final ValueChanged<String>? onSubmitted;

  const MyTextField({super.key, this.controller, required this.hintText, this.onSubmitted,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onSubmitted: onSubmitted,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          suffixIcon: const Icon(Icons.lock),
        ),
      ),
    );
  }
}
