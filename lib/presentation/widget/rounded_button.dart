import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class RoundedButton extends StatelessWidget {
  final press;
  final double width;
  final double height;
  final Color color;
  final Widget child;
  final String note;
  const RoundedButton(
      {Key? key,
      required this.press,
      required this.color,
      required this.width,
      required this.height,
      required this.note,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 200),
      onPressed:(){ press(note);},
      child: Container(
        decoration: BoxDecoration(
            color: color,
          ),
        width: width,
        height: height,
        child: Center(child: child),
      ),
    );
  }
}
