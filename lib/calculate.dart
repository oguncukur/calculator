import 'main.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Result {
  final String result;
  final String percentage;

  Result(this.result, this.percentage);
}

// class CalculatePage extends StatefulWidget {
//   @override
//   _CalculatePageState createState() => _CalculatePageState();
// }

class CalculatePage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController loverController = TextEditingController();

  Future<Result> getData() async {
    var name = nameController.text;
    var loverName = loverController.text;
    http.Response response = await http.get(Uri.encodeFull(""));
    Map<String, dynamic> model = jsonDecode(response.body);
    return Result(model['result'], model['percentage']);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: Colors.white),
        width: 300,
        height: 300,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage("assets/images/love.jpg"),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.accessibility),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.1),
                      contentPadding: EdgeInsets.all(10.0),
                      focusColor: Colors.red,
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'Your Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: loverController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.favorite_border),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.1),
                      contentPadding: EdgeInsets.all(10.0),
                      focusColor: Colors.red,
                      hintText: 'Enter lover name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'Lover Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter lover name';
                      }
                      return null;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final Result result;
  const ResultScreen({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/love2.png"),
                ),
                Text('%${result.percentage}',
                    style: TextStyle(
                        fontFamily: 'Ubuntu', fontSize: 30, color: Colors.red)),
                SizedBox(height: 10),
                Text(
                  '${result.result}',
                  style: TextStyle(
                      fontFamily: 'Ubuntu', fontSize: 30, color: Colors.red),
                ),
                SizedBox(height: 10),
                RaisedButton(
                    child: Text("Again"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(index: 2),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
