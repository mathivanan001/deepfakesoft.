import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> sendAlert() async {
    var response = await http.post(
      Uri.parse("http://127.0.0.1:8000/alert/"),
      headers: {"Content-Type": "application/json"},
      body: '{"alert_type": "Deepfake", "message": "Suspicious video detected!"}',
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Deepfake Detector")),
        body: Center(
          child: ElevatedButton(
            onPressed: sendAlert,
            child: const Text("Send Alert"),
          ),
        ),
      ),
    );
  }
}
