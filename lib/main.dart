import 'dart:convert';

import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THETA X Stateful',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'THETA X Stateful'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = "camera response";

  void _updateMessage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  height: 80,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.deepPurple, width: 3)),
                    child: const Text(
                      "Info",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: "Panipuri",
                          color: Colors.grey),
                    ),
                    onPressed: () async {
                      print('press button!');
                      var url = Uri.parse('http://192.168.1.1/osc/info');

                      var response = await http.get(url);
                      print(response.body);
                      setState(() {
                        _message = response.body;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 80,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.deepPurple, width: 3)),
                    child: const Text(
                      "State",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: "Panipuri",
                          color: Colors.grey),
                    ),
                    onPressed: () async {
                      print('press button!');
                      var url = Uri.parse('http://192.168.1.1/osc/state');
                      var header = {
                        'Content-Type': 'application/json;charset=utf-8'
                      };
                      var response = await http.post(url, headers: header);
                      print(response.body);
                      setState(() {
                        _message = response.body;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  height: 80,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.teal, width: 3)),
                    child: const Text(
                      "Take Pic",
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: "Panipuri",
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () async {
                      print('press button!');
                      var url =
                          Uri.parse('http://192.168.1.1/osc/commands/execute');
                      var header = {
                        'Content-Type': 'application/json;charset=utf-8'
                      };
                      var bodyMap = {
                        'name': 'camera.takePicture',
                      };
                      var bodyJson = jsonEncode(bodyMap);
                      var response =
                          await http.post(url, headers: header, body: bodyJson);
                      print(response.body);
                      setState(() {
                        _message = response.body;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: SyntaxView(
              code: _message,
              syntax: Syntax.DART,
              syntaxTheme: SyntaxTheme.ayuLight(),
              expanded: true,
            ),
          ),
        ],
      ),
    );
  }
}
