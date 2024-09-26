import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../app.dart';


class ResizableContainer extends StatefulWidget {
   ResizableContainer({super.key, required this.child,required this.context});

  final Widget child;
  BuildContext context;


  @override
  _ResizableContainerState createState() => _ResizableContainerState();
}

class _ResizableContainerState extends State<ResizableContainer> {
  late double containerWidth;
  late double containerHeight;
  double dragAreaSize = 10.0;



  Offset topLeft = const Offset(100, 100);
@override
  initState(){

    super.initState();


}


  @override
  Widget build(BuildContext context) {
    return Container(

      child: Stack(
        children: [
          Positioned(
            left: topLeft.dx,
            top: topLeft.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  topLeft = Offset(topLeft.dx + details.delta.dx, topLeft.dy + details.delta.dy);
                });
              },
              child: Container(
                width: containerWidth,
                height: containerHeight,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: widget.child,
                    ),
                    Positioned(
                      left: -1,
                      top: 0,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            containerWidth += details.delta.dx;
                            containerHeight += details.delta.dy;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Theme.of(context).primaryColor)),
                          width: dragAreaSize,
                          height: dragAreaSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}