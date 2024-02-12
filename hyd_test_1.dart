import 'dart:convert';
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

class _HydrogenDetectorState extends State<HydrogenDetector> {
  int hydrogenLevel = 0;
  double threshold = 50.0;

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

  @override
  void initState() {
    super.initState();
    //fetchHydrogenData();
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
              'Hydrogen Level: $hydrogenLevel',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Threshold: $threshold',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Slider(
              value: threshold,
              min: 0.0,
              max: 100.0,
              divisions: 100,
              label: threshold.round().toString(),
              onChanged: (double value) {
                setThreshold(value);
              },
            ),
            ElevatedButton(
              onPressed: () {
                // 기준치 설정 버튼을 눌렀을 때의 동작 추가 가능
              },
              child: Text('Save Threshold'),
            ),
          ],
        ),
      ),
    );
  }
}
