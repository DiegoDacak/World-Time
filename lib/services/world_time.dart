import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String flag;
  String url;
  late bool isDayTime;

  // Constructor
  WorldTime(this.location, this.flag, this.url);

  Future<void> getTime() async {
    try {
      // Make request
      Response response = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Get properties from data
      String datetime = data['datetime'];
      int offSet = int.parse(data['utc_offset'].substring(0, 3));

      // Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: offSet));

      isDayTime = (now.hour > 6 && now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(error) {
      time = 'could not get the time data';
      print(error);
    }
  }
}
