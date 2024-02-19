import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hydrogen Detector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HydrogenDetector(),
    );
  }
}

class HydrogenDetector extends StatefulWidget {
  @override
  _HydrogenDetectorState createState() => _HydrogenDetectorState();
}

  //mariaDB 넣을 곳
class _HydrogenDetectorState extends State<HydrogenDetector> {
  int hydrogenLevel = 0;
  double threshold = 50.0;
  TextEditingController thresholdController = TextEditingController(); // 수정된 부분

  /*
  Future<void> fetchHydrogenData() async {
    try {
     //final response = await http.get(Uri.parse('http://your_raspberry_pi_ip/hydrogen_data'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          hydrogenLevel = data['hydrogen_level'];
        });
      } else {
        throw Exception('Failed to load hydrogen data');
      }
    } catch (e) {
      print('Error fetching hydrogen data: $e');
    }
  }
  */

  Future<void> setThreshold(double value) async {
    setState(() {
      threshold = value;
    });
  }

  //mariaDB 넣을 곳


  @override
  void initState() {
    super.initState();
    //fetchHydrogenData(); -> 이상한 곳
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hydrogen Detector'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hydrogen Level: $hydrogenLevel', //실시간 수소 데이터 출력
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Threshold: $threshold', //설정한 기준치 보여 주는 텍스트
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: thresholdController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Threshold', //기준치 입력
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton( //기준치 입력 확인 버튼
              onPressed: () {
                setState(() {
                  threshold = double.parse(thresholdController.text);
                });
              },
              child: Text('기준치 설정'),
            ),
          ],
        ),
      ),
    );
  }
}
