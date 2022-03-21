import 'package:flutter/material.dart';

class RemoveButton extends StatefulWidget {
  final double size;
  final Function onPressed;
  const RemoveButton({Key? key, required this.size, required this.onPressed})
      : super(key: key);

  @override
  State<RemoveButton> createState() => _RemoveButtonState();
}

class _RemoveButtonState extends State<RemoveButton> {
  double _opacityIcon = 0;
  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 100),
        () => setState(() {
              _opacityIcon = 1;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacityIcon,
      duration: Duration(seconds: 1),
      child: IconButton(
        onPressed: () async {
          widget.onPressed();
        },
        icon: Icon(
          Icons.remove_circle,
          color: Colors.red,
          size: widget.size,
        ),
      ),
    );
  }
}
