import "package:flutter/material.dart";
import 'package:math_expressions/math_expressions.dart';
import './colors.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
 
  //-----------------------------------------( variables )---------------------------------------------
 
  var input = '';
  var output = '';
  var operator = '';
  var hideInput = false;
  var outputSize = 30.0;

  onButtonClick(value) {

    //clear all the contents 
    if (value == 'C') {
      input = '';
      output = '';

      // clear the last element
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {

        // userInput is used to replace the "x" element by "*" 
        
        var userInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);

        // After the value has been Parsed, and sent to expression for calculation, the later is sent to 
        // cm and evaluated to finalValue

        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();

        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }

        // whenever " = " operatior is used to vanish the input section hideInput is changed to true...

        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {

      // if new value is inputed, it is sent to the input section...

      input = input + value;
      hideInput = false;
      outputSize = 30.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [

        //------------------------------( input & output section )-----------------------------------

        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideInput ? "" : input,
                  style: const TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  output,
                  style: TextStyle(
                    fontSize: outputSize,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),

        //-----------------------------( buttons )--------------------------------------
        Row(
          children: [

            //----------------( button() function call )-------------------------

            button(text: "C", textColor: orangeColor),
            button(text: "<", textColor: orangeColor),
            button(text: "%", textColor: orangeColor),
            button(text: "/", textColor: orangeColor)
          ],
        ),
        Row(
          children: [
            button(text: "7"),
            button(text: "8"),
            button(text: "9"),
            button(text: "x", textColor: orangeColor)
          ],
        ),
        Row(
          children: [
            button(text: "4"),
            button(text: "5"),
            button(text: "6"),
            button(text: "-", textColor: orangeColor)
          ],
        ),
        Row(
          children: [
            button(text: "1"),
            button(text: "2"),
            button(text: "3"),
            button(text: "+", textColor: orangeColor)
          ],
        ),
        Row(
          children: [
            button(text: ""),
            button(text: "0"),
            button(text: "."),
            button(text: "=", buttonBackgrColor: orangeColor)
          ],
        )
      ]),
    );
  }

  // -----------------------------button function------------------------------
   
  Widget button({text, textColor = Colors.white, buttonBackgrColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            backgroundColor: buttonBackgrColor,
            padding: const EdgeInsets.all(20),
          ),

          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 28,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
