import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isEmpty ? ModalRoute.of(context)!.settings.arguments as Map : data;
    String image;
    Color textColor;
    Color barColor;
    if (data['isDayTime'] == true){
      image = "day.png";
      textColor = Colors.black;
      barColor = Colors.blue;
    }
    else {
      image = "night.png";
      textColor = Colors.white;
      barColor = Colors.black;
    }
    return Scaffold(
      backgroundColor: barColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$image'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location') as Map;
                    setState(() {
                      data = result;
                    });;
                  },
                  icon: const Icon(Icons.edit_location),
                  label: const Text('Edit location'),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle (
                        fontSize: 28,
                        letterSpacing: 2,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

