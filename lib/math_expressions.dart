import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = "";
  String _output = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        _output = "0";
        _input = "";
      } else if (buttonText == "=") {
        try {
          if (_input.isNotEmpty) {
            if (RegExp(r'[\+\-\*/\.]$').hasMatch(_input)) {
              _output = "Error";
            } else {
              Parser p = Parser();
              Expression exp = p.parse(_input);
              ContextModel cm = ContextModel();
              _output = '${exp.evaluate(EvaluationType.REAL, cm)}';
            }
          }
        } catch (e) {
          _output = "Error";
        }
        _input = "";
      } else {
        if (_input.isEmpty && RegExp(r'[\+\*/]').hasMatch(buttonText)) {
          return;
        }
        if (RegExp(r'[\+\-\*/]$').hasMatch(_input) && RegExp(r'[\+\*/]').hasMatch(buttonText)) {
          return;
        }
        if (buttonText == "." && _input.split(RegExp(r'[+\-*/]')).last.contains(".")) {
          return;
        }

        _input += buttonText;
        _output = _input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kalkulator Flutter")),
      body: Column(
        children: [
          Text("Output: $_output"),
          // Tambahkan widget tombol kalkulator di sini
        ],
      ),
    );
  }
}
