import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SimpleLoadingWidget extends StatelessWidget {
  const SimpleLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: const SpinKitHourGlass(
        color: Colors.blueAccent,
        size: 32,
      ),
    );
  }
}
