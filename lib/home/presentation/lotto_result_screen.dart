import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widget/app_circle_number.dart';

class LottoResultScreen extends StatefulWidget {
  final List<List<int>> lottoResult;

  const LottoResultScreen({Key? key, required this.lottoResult}) : super(key: key);

  @override
  State<LottoResultScreen> createState() => _LottoResultScreenState();
}

class _LottoResultScreenState extends State<LottoResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          "이번주 행운의 번호는?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.lottoResult.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                            6,
                            (i) => resultLottoRow(
                                  resultValue: widget.lottoResult[index][i].toString(),
                                )),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.copy_all),
                            SizedBox(width: 5),
                            Container(
                              child: Text('저장'),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //-- copy to clipboard
          Clipboard.setData(
              // ClipboardData(text: widget.lottoResult.toString())
              ClipboardData(text: widget.lottoResult.toString())).then(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                widget.lottoResult.toString(),
              )));
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget resultLottoRow({required String resultValue}) {
    return AppCircleNumber(index: int.parse(resultValue));
  }
}
