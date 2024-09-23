import 'package:flutter/material.dart';


class ResizableContainer extends StatefulWidget {
  const ResizableContainer({super.key, required this.child});

  final Widget child;


  @override
  _ResizableContainerState createState() => _ResizableContainerState();
}

class _ResizableContainerState extends State<ResizableContainer> {
  double ?containerWidth;
  double ?containerHeight;
  double dragAreaSize = 10.0;



  Offset topLeft = const Offset(100, 100);





  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: topLeft.dx,
          top: topLeft.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              // Movendo o container
              setState(() {
                topLeft = Offset(topLeft.dx + details.delta.dx, topLeft.dy + details.delta.dy);
              });
            },
            child: Container(

              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: widget.child,
                  ),
                  Positioned(
                    right: -1,
                    top: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {


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
    );
  }
}