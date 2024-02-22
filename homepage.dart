import 'package:flutter/material.dart';
import 'package:real_time_chart/real_time_chart.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:firebase_database/firebase_database.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final dbRef = FirebaseDatabase.instance.reference();
  List<double> inputData = []; // 입력 데이터
  int _index = 0; // 현재 입력 데이터의 인덱스

  @override
  void initState() {
    super.initState();
    dbRef.child('gas_data_test/gas_value').onValue.listen((event) {
      double value = double.parse(event.snapshot.value.toString());
      setState(() {
        inputData.add(value);
      });
    });
  }

  Stream<double> inputDataStream() {
    return Stream.periodic(const Duration(milliseconds: 200), (_) {
      if (inputData.isEmpty) {
        return 0.0;  // inputData가 비어있을 때는 0.0을 반환합니다.
      }
      double result = inputData[_index];
      _index = (_index + 1) % inputData.length;
      return result;
    }).asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {

    final stream = inputDataStream();

    return Scaffold(
        backgroundColor: Color(0xff3A6440),
        appBar: AppBar(
            backgroundColor: Color(0xff1d4531),
            title: Text('Hydrogen Detector',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NanumGodic'
                ))
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RealTimeGraph(
                      stream: stream,
                    ),
                  ),
                ),
              ]
          ),
        ),
        bottomNavigationBar: Container (
          color: Color(0xff1d4531),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: GNav(
                backgroundColor: Color(0xff1d4531),
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Color(0xff6C926D),
                gap:8,
                onTabChange: (index) {
                  print(index);
                },
                padding: EdgeInsets.all(10),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',),
                  GButton(icon: Icons.favorite_border,
                    text: 'Likes',),
                ]
            ),
          ),
        )
    );

  }
}
