import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result {
  final Duration duration;
  Result(this.duration);
}

class DayCalculate extends StatefulWidget {
  var page;

  @override
  _DayCalculateState createState() {
    page = _DayCalculateState();
    return page;
  }
}

class _DayCalculateState extends State<DayCalculate> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Duration getDifference() {
    DateTime now = DateTime.now();
    return now.difference(selectedDate);
  }

  showMaterialDialog(text) {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("How Long Is My Relationship?"),
              content: new Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text('Again'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "${selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () => _selectDate(context), // Refer step 3
            child: Text(
              'Select date',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
