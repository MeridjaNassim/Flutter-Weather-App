import 'package:flutter/material.dart';

import './location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/weather.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin{
 
  dynamic weatherData ;
  void getWeatherData() async{
   
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(data : weatherData);
    }));
   
  }
  
  @override
  void initState() {
    super.initState();
    print('init state called');
    getWeatherData();
    print('weather data == ${this.weatherData}');
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: SpinKitDoubleBounce(
         color: Colors.white,
          size: 50.0,
          controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
       ),
     ),
   );
  }
}
