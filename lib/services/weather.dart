import 'package:flutter_dotenv/flutter_dotenv.dart';

import './location.dart';
import './networking.dart';

const String openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  String apiKey;
  static dynamic _cachedData ;
  WeatherModel(){
    this.apiKey =DotEnv().env['APIKEY'];
  }
  Future<dynamic> getLocationWeather({bool tryUseCachedData}) async{
    tryUseCachedData = tryUseCachedData ?? false;
    if(tryUseCachedData && _cachedData != null) return _cachedData;
     try {
       Location location = new Location();
      // getting the current location of the user 
      await location.getCurrentLocation();
      // getting the weather data of the user's location
      dynamic weatherData = await NetworkHelper("$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric").getData();
      print("weather data : $weatherData");
      _cachedData = weatherData;
      return weatherData;
    }catch(e) {
       print(e);
    }
  }
  Future<dynamic> getCityWeather(String cityName) async{
    String url = '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric';
    
     try {
      // getting the weather data of the user's location
      dynamic weatherData = await NetworkHelper(url).getData();
      print("weather data : $weatherData");
      _cachedData = weatherData;
      return weatherData;
    }catch(e) {
       print(e);
    }
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
