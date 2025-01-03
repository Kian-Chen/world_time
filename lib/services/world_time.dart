import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String ?location; // location name for the UI
  String ?time; // the time in that location
  String ?flag; // url to an asset flag icon
  String ?url; // url for the api endpoint
  bool ?isDaytime; // true if daytime, false otherwise

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
    isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.Hm().format(now);

  }

}