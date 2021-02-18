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
  @override
  void initState() {
    super.initState();
    data = getData();
    //futureApi = apiCall();
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
          child: Container(
            child: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*
                      Text(snapshot.data["USD"]["Name"]),
                      Text("Buy" + snapshot.data["USD"]["Buying"]),
                      Text("Sell" + snapshot.data["USD"]["Selling"])
                      */
                    ],
                  );
                }),
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

Widget currency_box(w, h) {
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
          Text("Name"),
          Text("Value"),
          Icon(Icons.arrow_right_outlined)
        ],
      ),
    ),
  );
}
