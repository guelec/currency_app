import 'dart:convert';

import 'package:http/http.dart';

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    print("$url");
    Response response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}

Future getData() async {
  var data;
  String url = "https://api.genelpara.com/embed/para-birimleri.json";
  Network network = Network(url);
  data = network.fetchData();
  data.then((value) {
    print(value);
  });

  return data;
}
