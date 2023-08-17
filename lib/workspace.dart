import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorkSpace extends StatelessWidget {
  const WorkSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 30.0,
      height: 30.0,
      child: SpinKitThreeInOut(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: index.isEven ? Colors.red : Colors.green,
            ),
          );
        },
        size: 120.0,
      ),
    );
  }
}
