import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Temperature Calculator',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TempApp(),
    );
  }
}

class TempApp extends StatefulWidget {
  @override
  TempState createState() => TempState();
}

class TempState extends State<TempApp> {
  double input;
  double output;
  bool fOrC;

  @override
  void initState() {
    super.initState();
    input = 0.0;
    output = 0.0;
    fOrC = true;
  }

  @override
  Widget build(BuildContext context) {
    TextField inputField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          input = double.parse(str);
        } catch (e) {
          input = 0.0;
        }
      },
      decoration: InputDecoration(
          labelText:
              "Input a value in ${fOrC == false ? "Fahrenheit" : "Celsius"}"),
    );

    AppBar appBar = AppBar(
      title: Text("Temperature Calculator"),
    );

    Container tempSwitch = Container(
      child: Row(
        children: <Widget>[
          Text("F"),
          Radio<bool>(
            groupValue: fOrC,
            value: false,
            onChanged: (v) {
              setState(() {
                fOrC = v;
              });
            },
          ),
          Text("C"),
          Radio<bool>(
            groupValue: fOrC,
            value: true,
            onChanged: (v) {
              setState(() {
                fOrC = v;
              });
            },
          ),
        ],
      )
    );

    Container calcBtn = Container(
      child: RaisedButton(
        child: Text("Calculate"),
        onPressed: () {
          setState(() {
            fOrC == false
                  ?
                  output = (input - 32) * (5 / 9)
                  :
                  output = (input * 9 / 5) + 32;          
          });
          AlertDialog dialog = AlertDialog(
            content: fOrC == false
                            ?
                            Text("${input.toStringAsFixed(2)} F : ${output.toStringAsFixed(2)} C")
                            :
                            Text("${input.toStringAsFixed(2)} C : ${output.toStringAsFixed(2)} F")
          );
          showDialog(context: context, child: dialog);
        },
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[inputField, tempSwitch, calcBtn],
        ),
      ),
    );
  }
}