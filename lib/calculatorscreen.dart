import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp()); // Pemanggilan sesuai dengan nama class yang benar
}

class CalculatorApp extends StatelessWidget { // Perbaiki typo di sini
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover, // Agar gambar memenuhi layar
            ),
          ),
          child: CalculatorScreen(), // Panggil CalculatorScreen yang baru dibuat
        ),
      ),
    );
  }
}

// **Tambahkan class CalculatorScreen**
class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Kalkulator",
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
