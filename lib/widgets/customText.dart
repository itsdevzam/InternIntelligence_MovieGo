import 'package:flutter/material.dart';
import 'package:moviego/utils/utils.dart';

class customText extends StatelessWidget {
  String text;
  Color? color;
  double? size;
  bool? isbold;
  bool? iscenter;

  customText(
      {super.key,
      required this.text,
      this.color,
      this.size,
      this.isbold,
      this.iscenter});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? Colors.white,
          fontSize: size??16,
          fontWeight: (isbold != null && isbold == true)
              ? FontWeight.bold
              : FontWeight.normal),
      textAlign: (iscenter != null && iscenter == true)
          ? TextAlign.center
          : TextAlign.start,
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
