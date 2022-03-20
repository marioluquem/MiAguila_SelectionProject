import 'package:flutter/material.dart';

class RemoveButton extends StatelessWidget {
  final double size;
  final Function onPressed;
  const RemoveButton({Key? key, required this.size, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        onPressed();
      },
      icon: Icon(
        Icons.remove_circle,
        color: Colors.red,
        size: size,
      ),
    );
  }
}
