import 'package:flutter/material.dart';

class AppCircleNumber extends StatefulWidget {
  final int value;
  final bool isChecked;
  final double height;
  final double width;

  const AppCircleNumber({
    Key? key,
    required this.value,
    this.isChecked = false,
    this.height = 45,
    this.width = 45,
  }) : super(key: key);

  @override
  State<AppCircleNumber> createState() => _AppCircleNumberState();
}

class _AppCircleNumberState extends State<AppCircleNumber>
    with SingleTickerProviderStateMixin {
  //-- 컨트롤러 선언
  late final AnimationController _animationController;
  late final Animation _animation;

  //-- 애니메이션 초기화
  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut));

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 종료 시
        _animationController.reverse();
      // } else if (status == AnimationStatus.dismissed) {
      //   _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation.value,
      // scale: _animation.value == 0 ? 1 : _animation.value,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: findBackgroundColor(widget.value, widget.isChecked),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            '${widget.value}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Color findBackgroundColor(int index, bool isChecked) {
    if (isChecked) {
      _animationController.forward().then((value) {
        _animationController.reverse();
      });
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
