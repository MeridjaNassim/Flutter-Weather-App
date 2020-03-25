import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHelper {
  final String url ;

  NetworkHelper(this.url);

  Future<dynamic> getData() async{
    http.Response response = await http.get(url);
    
    if(response.statusCode ==200) {
      return convert.jsonDecode(response.body) ;
    }
    else {
      throw 'Could not get data';
    }
    
  }

}