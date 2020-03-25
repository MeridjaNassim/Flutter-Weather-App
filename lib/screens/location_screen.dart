import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'city_screen.dart';
import '../services/weather.dart' ;
class LocationScreen extends StatefulWidget {
  final data ; 
  final WeatherModel weather= WeatherModel();
  LocationScreen({this.data});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature ; 
  String cityName ; 
  int condition ;
  String weatherIcon ;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.data);
  }
  void updateUI(dynamic newData) {
   
    setState(() {
    if(newData ==null) {
      temperature = 0;
      weatherMessage = "Could not get weather data";
      weatherIcon = '❌';
      cityName="";
      return;

    }
    var temp =newData['main']['temp'];
    temperature = temp.toInt();
    cityName = newData['name'];
    condition =newData['weather'][0]['id'];
    weatherMessage = widget.weather.getMessage(temperature);
    weatherIcon = widget.weather.getWeatherIcon(condition);
    });
 
  }
  void _updateWeather() async{
    var newData = await widget.weather.getLocationWeather();
    updateUI(newData);
  }
  void _updateWeatherForCity(String cityName) async {
    var newData = await widget.weather.getCityWeather(cityName);
    updateUI(newData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: _updateWeather,
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedCity =await Navigator.push(context, MaterialPageRoute(builder: (context)=> CityScreen()));
                      if(typedCity != null) {
                        _updateWeatherForCity(typedCity);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
