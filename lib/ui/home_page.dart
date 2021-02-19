import 'dart:async';
import 'package:intl/intl.dart';
import 'package:currency_app/models/currency.dart';
import 'package:currency_app/models/deneme.dart';
import 'package:currency_app/models/network.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Future<USD> futureApi;
  Future data;
  String _timeString;
  void _getTime() {
    final String formattedDateTime =
        DateFormat('yyyy-MM-dd \n kk:mm:ss').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  @override
  void initState() {
    super.initState();
    data = getData();
    //futureApi = apiCall();
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _getTime();
        getData();
        my_future(_timeString);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => debugPrint("Floating Action Button"),
        ),
        body: Center(
          child: Container(child: my_future(_timeString)
              /*
            FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data["USD"]["Name"]),
                      Text("Buy" + snapshot.data["USD"]["Buying"]),
                      Text("Sell" + snapshot.data["USD"]["Selling"])
                    ],
                  );
                }),
                */
              ),
        )
        /*
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40),
              ),
              currency_box(width, height),
              Container(
                width: width * 0.5,
                height: height * 2,
                color: Colors.deepOrange,
              ),
              Container(
                width: width * 0.5,
                height: height * 2,
                color: Colors.limeAccent,
              )
            ],
          ),
        ),
      ),
      */
        );
  }
}

Widget my_future(date) {
  return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData)
          return currency_box(context, snapshot);
        else
          return CircularProgressIndicator();
        /*
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*
            Text(snapshot.data["USD"]["Name"]),
            Text("Buy" + snapshot.data["USD"]["Buying"]),
            Text("Sell" + snapshot.data["USD"]["Selling"]),
            */
            /*
            Text(snapshot.data["RS"].toString()),
            Text(snapshot.data["QAR"].toString()),
            Text(snapshot.data["JPY"].toString()),
            Text(snapshot.data["RON"].toString()),
            Text(snapshot.data["IRR"].toString()),
            Text(snapshot.data["SDR"].toString()),
            Text(snapshot.data["RUB"].toString()),
            Text(snapshot.data["CNY"].toString()),
            Text(snapshot.data["Update_Date"]),
            Text(date.toString())
            */
          ],
        );
        */
      });
}

Widget currency_box(context, snapshot) {
  var w = MediaQuery.of(context).size.width;
  var h = MediaQuery.of(context).size.height;
  var usd = snapshot.data["USD"];
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      width: w * 0.9,
      height: w * 0.3,
      color: Colors.deepPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: w * 0.2,
            height: w * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.green),
            child: Icon(Icons.euro),
          ),
          Text(usd["Name"]),
          //Text(snapshot.data["USD"].toString()),
          //Text(snapshot.data["USD"]["Buying"]),
          //Text(snapshot.data["USD"]["Selling"]),
          Icon(Icons.arrow_right_outlined)
        ],
      ),
    ),
  );
}
