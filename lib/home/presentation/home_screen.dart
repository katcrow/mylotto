import 'package:crow_lotto_creator/home/presentation/lotto_result_screen.dart';
import 'package:crow_lotto_creator/home/widget/app_circle_number.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> _isChecked = List.filled(45, false);
  List<int> selectedNumber = List.generate(45, (value) => value + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(top: 40, bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Center(
              child: Text(
                '1등을 기원하며!',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 6,
                children: List.generate(45, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // 토글
                          _isChecked[index] = !_isChecked[index];
                          if (_isChecked[index]) {
                            selectedNumber.remove(index + 1);
                          } else {
                            selectedNumber.add(index + 1);
                          }
                        });
                      },
                      child: AppCircleNumber(
                        value: index + 1,
                        isChecked: _isChecked[index],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // -- 6개 만드는 함수
              var sixNumberList = sixNumber(selectedNumber);
              //-- result page move -> gameCount 매개변수로
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LottoResultScreen(lottoResult: sixNumberList),
                  ));
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _isChecked = List.filled(45, false);
                        selectedNumber = List.generate(45, (value) => value + 1);
                      });
                    },
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width / 2,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          "초기화",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // -- 6개 만드는 함수
                      var sixNumberList = sixNumber(selectedNumber);
                      //-- result page move -> gameCount 매개변수로
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LottoResultScreen(lottoResult: sixNumberList),
                          ));
                    },
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width / 2,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          "생성하기",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 70.0),
        child: FloatingActionButton(
          backgroundColor: Colors.black87,
          onPressed: () {
            setState(() {
              _isChecked = List.filled(45, false);
              selectedNumber = List.generate(45, (index) => index);
            });
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  List<List<int>> sixNumber(List<int> selectedNumber) {
    List<List<int>> gameCount = [];
    int count = 5;

    for (int i = 0; i < count; i++) {
      Set<int> lottoSet = {};
      while (lottoSet.length < 6) {
        var randomNumber = (selectedNumber..shuffle()).first;
        lottoSet.add(randomNumber);
      }
      gameCount.add(lottoSet.toList()..sort());
    }
    return gameCount;
  }
}
