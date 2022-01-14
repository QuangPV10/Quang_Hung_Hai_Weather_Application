import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  late VoidCallback onPressed;

  RefreshButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red, // background
        onPrimary: Colors.white, // foreground
      ),
      onPressed: onPressed,
      child: const Icon(Icons.refresh),
    );
  }
}
