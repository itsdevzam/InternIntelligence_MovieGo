import 'package:flutter/material.dart';
import 'package:moviego/widgets/customText.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class Blurtext extends StatelessWidget {
  customText custom_text;
  Blurtext({super.key,required this.custom_text});

  @override
  Widget build(BuildContext context) {
    return SoftEdgeBlur(
      edges: [
        EdgeBlur(
          type: EdgeType.topEdge,
          size: 100,
          sigma: 30,
          controlPoints: [
            ControlPoint(
              position: 0.5,
              type: ControlPointType.visible,
            ),
            ControlPoint(
              position: 1,
              type: ControlPointType.transparent,
            )
          ],
        )
      ],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: custom_text,
      ),
    );
  }
}
