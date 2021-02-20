import 'dart:async';
import 'package:intl/intl.dart';
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
  bool _visible = true;   // to control Fade Transition Animation
  void _refreshAnimation() {
    _visible = !_visible;
  }

  void getTime() {
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
    const oneSec = const Duration(seconds: 1);  // We animate fade transition every second
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _refreshAnimation();
      });
    });
    const twoSec = const Duration(seconds: 2);  // In every two seconds we get current time,
    new Timer.periodic(twoSec, (Timer t) {      // get data from API and bind our Widget with
      setState(() {                             // updated data.
        getTime();
        getData();
        my_future(_timeString, _visible);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            color: Colors.grey.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  refresh_date(_timeString, width, height),
                  Divider(height: width * 0.3, color: Colors.transparent),
                  my_future(_timeString, _visible),
                ],
              ),
            )));
  }
}

Widget refresh_date(date, w, h) {
  Widget _date_func(date) {
    if (date == null)
      return Visibility(visible: false, child: CircularProgressIndicator());
    else
      return Text(date);
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      width: w * 0.4,
      height: w * 0.2,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.timelapse_rounded), _date_func(date)],
      ),
    ),
  );
}

// Column of three currencies will be shown under this function
FutureBuilder my_future(date, _visible) {
  return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData)
          return Column(
            children: [
              currency_box(context, snapshot, date, "USD", _visible),
              Divider(
                  height: MediaQuery.of(context).size.height * 0.025,
                  color: Colors.transparent),
              currency_box(context, snapshot, date, "EUR", _visible),
              Divider(
                  height: MediaQuery.of(context).size.height * 0.025,
                  color: Colors.transparent),
              currency_box(context, snapshot, date, "GBP", _visible),
            ],
          );
        else
          return CircularProgressIndicator();
      });
}

// Design of the each currency box
Widget currency_box(context, snapshot, _date, String name, _visible) {
  var w = MediaQuery.of(context).size.width;
  var h = MediaQuery.of(context).size.height;
  String rate = snapshot.data[name]["degisim"][0] +
      '.' +
      snapshot.data[name]["degisim"][2] +
      snapshot.data[name]["degisim"][3];
  Color rate_color;
  IconData rate_icon;
  if (double.parse(rate) < 0) {
    rate_color = Colors.red;
    rate_icon = Icons.trending_down_rounded;
  } else if (double.parse(rate) > 0) {
    rate_color = Colors.green;
    rate_icon = Icons.trending_up_rounded;
  } else {
    rate_color = Colors.grey;
    rate_icon = Icons.trending_neutral_rounded;
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green, Colors.white, Colors.white, Colors.white]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      width: w * 0.9,
      height: w * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: w * 0.15,
                  height: w * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset("assets/icons/${name}.png")),
              Text(
                "$name",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Row(
              children: [
                //Text(usd["Name"]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Container(
                            width: w * 0.2,
                            height: w * 0.075,
                            color: Colors.grey.shade200,
                            child: Center(child: Text("Buying")))),
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: Container(
                            width: w * 0.2,
                            height: w * 0.075,
                            color: Colors.grey,
                            child: Center(
                                child: Text(snapshot.data[name]["alis"])))),
                  ],
                ),
                VerticalDivider(width: w * 0.02, color: Colors.transparent),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Container(
                            width: w * 0.2,
                            height: w * 0.075,
                            color: Colors.grey.shade200,
                            child: Center(child: Text("Selling")))),
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: Container(
                            width: w * 0.2,
                            height: w * 0.075,
                            color: Colors.grey,
                            child: Center(
                                child: Text(snapshot.data[name]["satis"])))),
                  ],
                ),
                VerticalDivider(width: w * 0.02, color: Colors.transparent),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: w * 0.15,
                    height: w * 0.15,
                    color: Colors.grey.shade200,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${snapshot.data[name]["degisim"]}%"),
                        Icon(rate_icon),
                      ],
                    )
                        /*
                      Text(
                        snapshot.data[name]["degisim"],
                        style: TextStyle(color: rate_color),
                      ),
                      */
                        ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
