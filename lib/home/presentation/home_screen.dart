import 'dart:math';
import 'package:crow_lotto_creator/home/presentation/lotto_result_screen.dart';
import 'package:crow_lotto_creator/home/widget/app_circle_number.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>with SingleTickerProviderStateMixin {
  List<bool> _isChecked = List.filled(45, false);
  List<int> selectedNumber = List.generate(45, (index) => index + 1);

  //-- 1. animation 선언
  late AnimationController _controller;
  late Animation _animation;

  void callAnimation()  {
    _controller =  AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation =  Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ));

    //-- animation 감시
    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status)  {
      if (status == AnimationStatus.completed) {
        // 종료 시
         _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // 시작 시
      }
    });
  }

  //-- animation 초기화
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // callAnimation();
  }

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
                            selectedNumber.remove(index);
                          } else {
                            selectedNumber.add(index);
                          }
                        });
                      },
                      child: AppCircleNumber(
                        index: index,
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
              child: Container(
                height: 70,
                width: double.infinity,
                color: Colors.red,
                child: Center(
                  child: Text(
                    "생성하기",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
              selectedNumber = List.generate(45, (index) => index + 1);
            });
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  // Set<int> sixNumber(){
  List<List<int>> sixNumber(List<int> selectedNumber) {
    // Set<String> list = Set();
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
    // print("gameCount : ${gameCount}");
    return gameCount;
  }
}
