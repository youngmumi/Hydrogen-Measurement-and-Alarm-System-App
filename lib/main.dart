import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firebase Realtime Database'),
        ),
        body: RealtimeDatabase(),
      ),
    );
  }
}

class RealtimeDatabase extends StatefulWidget {
  @override
  _RealtimeDatabaseState createState() => _RealtimeDatabaseState();
}

class _RealtimeDatabaseState extends State<RealtimeDatabase> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.child('gas_data_test/gas_data_test/gas_value').onValue,
      builder: (context, snap) {
        if (snap.hasData && !snap.hasError && snap.data?.snapshot?.value != null) {
          return Text('Value: ${snap.data?.snapshot?.value.toString()}');
        } else {
          return Text('Waiting for data...');
        }
      },
    );
  }
}