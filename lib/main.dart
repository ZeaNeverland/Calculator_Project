import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";
  List<String> _history = [];

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
      } else if (value == "⌫") {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
          _output = _input.isEmpty ? "0" : _input;
        }
      } else if (value == "=") {
        try {
          _output = _evaluateExpression(_input);
          _history.add("$_input = $_output");
        } catch (e) {
          _output = "Error";
        }
        _input = _output;
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      expression = expression.replaceAll("x", "*"); // Mengganti "x" dengan "*"
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen(_history)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white, width: 3), // Border putih hanya di area kalkulator
            boxShadow: [
              BoxShadow(color: Colors.black45, blurRadius: 15, spreadRadius: 3),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(24),
                child: Text(
                  _output,
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "RobotoMono",
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildButtonGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonGrid() {
    return Column(
      children: [
        _buildButtonRow(["C", "⌫", "(", ")"], [Colors.redAccent, Colors.orange, Colors.grey[800]!, Colors.grey[800]!]),
        _buildButtonRow(["7", "8", "9", "/"], [Colors.grey[900]!, Colors.grey[900]!, Colors.grey[900]!, Colors.deepPurple]),
        _buildButtonRow(["4", "5", "6", "x"], [Colors.grey[900]!, Colors.grey[900]!, Colors.grey[900]!, Colors.deepPurple]),
        _buildButtonRow(["1", "2", "3", "-"], [Colors.grey[900]!, Colors.grey[900]!, Colors.grey[900]!, Colors.deepPurple]),
        _buildButtonRow(["+/-", "0", ".", "+"], [Colors.grey[800]!, Colors.grey[900]!, Colors.grey[800]!, Colors.deepPurple]),
        Row(children: [_buildButton("=", Colors.pinkAccent, flex: 4)]),
      ],
    );
  }

  Widget _buildButtonRow(List<String> labels, List<Color> colors) {
    return Row(
      children: List.generate(labels.length, (index) => _buildButton(labels[index], colors[index])),
    );
  }

  Widget _buildButton(String value, Color color, {double flex = 1}) {
    return Expanded(
      flex: flex.toInt(),
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(value),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.symmetric(vertical: 22),
            elevation: 3,
            backgroundColor: color,
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

/// HISTORY SCREEN
class HistoryScreen extends StatelessWidget {
  final List<String> history;
  HistoryScreen(this.history);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("History")),
      body: history.isEmpty
          ? Center(
              child: Text("No History", style: TextStyle(fontSize: 20, color: Colors.white54)),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2), // Border putih pada History
                  ),
                  child: ListTile(
                    title: Text(
                      history[index],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 18),
                  ),
                );
              },
            ),
    );
  }
}

/// PROFILE SCREEN
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2), // Border putih di Profile
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/Changli.jpg"),
              ),
              SizedBox(height: 20),
              Text("Aghniya Nainawa A", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
              Text("XI RPL 1", style: TextStyle(fontSize: 16, color: Colors.white54)),
              Text("Motivasi", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
              Text("💻 Kode mungkin bisa gagal, tapi semangat untuk belajar tidak boleh error!", style: TextStyle(fontSize: 16, color: Colors.white54)),
              Text("⚡ Setiap bug adalah kesempatan untuk menjadi lebih baik.", style: TextStyle(fontSize: 16, color: Colors.white54)),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: Text("By Niya"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
