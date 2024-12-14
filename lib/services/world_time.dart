import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  String ?location; // location name for the UI
  String ?time; // the time in that location
  String ?flag; // url to an asset flag icon
  String ?url; // url for the api endpoint

  WorldTime({ this.location, this.flag, this.url});

  Future<void> getTime() async {

    // make the request
    var uri = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
    Response response = await get(uri);
    Map data = jsonDecode(response.body);
    // print(data);

    // get the properties from the data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(0,3);
    // print(datetime);
    // print(offset);

    // create Datetime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));
    // print(now);

    // set the time property
    time = now.toString();

  }

}