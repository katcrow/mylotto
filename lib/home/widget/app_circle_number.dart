import 'package:flutter/material.dart';

class AppCircleNumber extends StatelessWidget {
  final int index;
  final bool isChecked;
  final double height;
  final double width;

  const AppCircleNumber({
    Key? key,
    required this.index,
    this.isChecked = false,
    this.height = 50,
    this.width = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: findBackgroundColor(index, isChecked),
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Color findBackgroundColor(int index, bool isChecked) {
    if (isChecked) {
      return Colors.red;
    }
    if (index < 10) {
      return Colors.amber;
    } else if (index < 20) {
      return Colors.lightBlueAccent;
    } else if (index < 30) {
      return Colors.purpleAccent;
    } else if (index < 40) {
      return Colors.grey;
    } else {
      return Colors.lightGreen;
    }
  }
}
