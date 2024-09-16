import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';

  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
    });
  }
  int findLeftIndex(int startIndex){
    int leftIndex=startIndex;
    while(leftIndex>0 && (leftIndex-1==0 || (_expression[leftIndex-1]!='+' && _expression[leftIndex-1]!='-' && _expression[leftIndex-1]!='*' && _expression[leftIndex-1]!='/')) || (_expression[leftIndex]=='-' && leftIndex-1==0)){
      leftIndex--;
    }
    return leftIndex;
  }
  int findRightIndex(int startIndex){
    int rightIndex=startIndex;
    while(rightIndex<_expression.length-1 && _expression[rightIndex+1]!='+' && _expression[rightIndex+1]!='-' && _expression[rightIndex+1]!='*' && _expression[rightIndex+1]!='/'){
      rightIndex++;
    }
    return rightIndex;
  }

  String eval(){
    for (int i=0;i<_expression.length;i++){
      if(_expression[i]=='*'){
        int leftIndex=findLeftIndex(i);
        int rightIndex;
        if(_expression[i+1]=='-'){
           rightIndex=findRightIndex(i+1);
        
        }else{
         rightIndex=findRightIndex(i);
        }
        double leftValue=double.parse(_expression.substring(leftIndex,i));
        double rightValue=double.parse(_expression.substring(i+1,rightIndex+1));
        double temp=leftValue*rightValue;
        _expression=_expression.replaceRange(leftIndex,rightIndex+1,temp.toString());
        
         i=0;
      
      }else if(_expression[i]=='/'){
        
        int leftIndex=findLeftIndex(i);
        int rightIndex;
        if(_expression[i+1]=='-'){
           rightIndex=findRightIndex(i+1);
        
        }else{
         rightIndex=findRightIndex(i);
        }
        double leftValue=double.parse(_expression.substring(leftIndex,i));
        double rightValue=double.parse(_expression.substring(i+1,rightIndex+1));
        double temp=leftValue/rightValue;
        _expression=_expression.replaceRange(leftIndex,rightIndex+1,temp.toString());
        
         i=0;
      }
    }
    //evaluate addition and subtraction
    for (int i=0;i<_expression.length;i++){
      if(_expression[i]=='+'){
        int leftIndex=findLeftIndex(i);
        int rightIndex;
        if(_expression[i+1]=='-'){
           rightIndex=findRightIndex(i+1);
        
        }else{
         rightIndex=findRightIndex(i);
        }
        double leftValue=double.parse(_expression.substring(leftIndex,i));
        double rightValue=double.parse(_expression.substring(i+1,rightIndex+1));
        double temp=leftValue+rightValue;
        _expression=_expression.replaceRange(leftIndex,rightIndex+1,temp.toString());
        
         i =0;
      }else if(_expression[i]=='-'&& i!=0){
        int leftIndex=findLeftIndex(i);
        int rightIndex;
        if(_expression[i+1]=='-'){
           rightIndex=findRightIndex(i+1);
        
        }else{
         rightIndex=findRightIndex(i);
        }
        double leftValue=double.parse(_expression.substring(leftIndex,i));
        double rightValue=double.parse(_expression.substring(i+1,rightIndex+1));
        double temp=leftValue-rightValue;
        _expression=_expression.replaceRange(leftIndex,rightIndex+1,temp.toString());
        
         i=0;
      }
    }
      return _expression;
  }

  void _evaluateExpression() {
    setState(() {
      //evaluate multiplication and division
      _expression=eval();
      
    });
    
    
    //evaluate multiplication and division

    
  }
  
  
    

    // Implement the logic to evaluate the expression here
    // You can use a library like math_expressions to parse and evaluate the expression
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jack Nystroms Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _clearExpression,
                  child: Text('Clear'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (value == '=') {
            _evaluateExpression();
          } else {
            _addToExpression(value);
          }
        },
        child: Text(value),
      ),
    );
  }
}