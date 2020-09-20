import 'package:flutter/material.dart';

class SideBarCustomClipper extends CustomClipper<Path> {
  final double startYPosition;
  final double endYPosition;

  SideBarCustomClipper(
      {@required this.startYPosition, @required this.endYPosition});

  @override
  Path getClip(Size size) {
    Path path = Path();

    double width = size.width;
    double height = size.height;
    print("width : $width");
    print("height : $height");
    print("StartYPosition : $startYPosition");
    print("EndYPosition : $endYPosition");

    //Upper Curve
    path.moveTo(0, 0);
    path.quadraticBezierTo(width / 1.5, 5, width / 1.5, 70);

    // Item Curve
    path.lineTo(width / 1.5, startYPosition);
    path.quadraticBezierTo(width / 1.5 + 2, startYPosition + 15,
        width / 1.5 + 10, startYPosition + 25);
    path.quadraticBezierTo(
        width, startYPosition + 45, width, startYPosition + 60);
    path.quadraticBezierTo(
        width, endYPosition - 45, width / 1.5 + 10, endYPosition - 25);
    path.quadraticBezierTo(
        width / 1.5 + 2, endYPosition - 15, width / 1.5, endYPosition);

    // Bottom Curve
    path.lineTo(width / 1.5, height - 70);
    path.quadraticBezierTo(width / 1.5, height - 5, 0, height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
