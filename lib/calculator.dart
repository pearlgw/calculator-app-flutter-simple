// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    'C','(',')','/',
    '7','8','9','*',
    '4','5','6','+',
    '1','2','3','-',
    'AC','0','.','=',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(35, 37, 46, 1),
        body: Column(
          children: [
            Flexible(child: resultWidget(), flex: 1,),
            Flexible(child: buttonWidget(), flex: 2,)
          ],
        ),
      ),
    );
  }
  
  Widget resultWidget(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          child: Text(
            userInput,
            style: TextStyle(
              fontSize: 32,
              color: Color.fromRGBO(228, 236, 234, 1)
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomRight,
          child: Text(
            result,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(156, 168, 185, 1)
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonWidget(){
    return GridView.builder(
      itemCount: buttonList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (BuildContext context, int index){
        return button(buttonList[index]);
      },
    );
  }

  Widget button(String text){
    return Container(
      margin: EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: (){
          setState(() {
            handleButtonPress(text);
          });
        },
        color: getcolor(text),
        textColor: Color.fromRGBO(35, 37, 46, 1),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 25
          ),
        ),
        shape: const CircleBorder(),
      ),
    );
  }

  handleButtonPress(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }
    if(text == "C"){
      userInput = userInput.substring(0, userInput.length-1);
      return;
    }
    if(text == "="){
      result = calculate();
      if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
      }
      return;
    }

    userInput = userInput + text;
  }

  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }catch(e){
      return "Error";
    }
  }

  getcolor(String text){
    if(text == "/" || text == "*" || text == "+" || text == "-" || text == "="  || text == "C" || text == "AC" || text == "(" || text == ")" || text == "."){
      return Color.fromRGBO(216, 95, 27, 1);
    }
    return Color.fromRGBO(174, 193, 173, 1);
  }
}