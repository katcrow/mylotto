import 'package:flutter/material.dart';

class LottoBox extends StatefulWidget {
  final bool isChecked;
  final int index;

  const LottoBox({
    Key? key,
    required this.isChecked,
    required this.index,
  }) : super(key: key);

  @override
  State<LottoBox> createState() => _LottoBoxState();
}

class _LottoBoxState extends State<LottoBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: widget.isChecked ? Colors.red : Colors.green,
            // color: widget.isChecked ? Colors.red : Colors.green,
            border: Border.all(
              color: Colors.black,
            )),
        child: Center(
          child: Text('${widget.index + 1}'),
        ),
      ),
    );
  }
}
