import 'package:flutter/material.dart';

class RozpocznijButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  const RozpocznijButton({super.key, required this.title, required this.onPressed});

  @override
  State<RozpocznijButton> createState() => _RozpocznijButtonState();
}

class _RozpocznijButtonState extends State<RozpocznijButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FilledButton(
        onPressed: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
            widget.title,
          ),
        ),
      ),
    );
  }
}