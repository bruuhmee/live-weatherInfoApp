import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'HourlyForecast.dart';
import 'package:http/http.dart' as http;


class WeatherScreen extends StatefulWidget{
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  Future getCurrentWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=0da074843b3497b6bf9637e36f09ecf5&units=metric'),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An Unexpected error occurred.';
      }
      return {
        'temp': (data['list'][0]['main']['temp'] as num).toDouble(),
        'humidity': (data['list'][0]['main']['humidity'] as num).toDouble(),
        'pressure': (data['list'][0]['main']['pressure'] as num).toDouble(),
        'wind_speed': (data['list'][0]['wind']['speed'] as num).toDouble(),
        'time1':(data['list'][1]['dt_txt']),
        'time2':(data['list'][2]['dt_txt']),
        'time3':(data['list'][3]['dt_txt']),
        'time4':(data['list'][4]['dt_txt']),
        'time5':(data['list'][5]['dt_txt']),
        'time6':(data['list'][6]['dt_txt']),
        'temp1':(data['list'][1]['main']['temp']),
        'temp2':(data['list'][2]['main']['temp']),
        'temp3':(data['list'][3]['main']['temp']),
        'temp4':(data['list'][4]['main']['temp']),
        'temp5':(data['list'][5]['main']['temp']),
        'temp6':(data['list'][6]['main']['temp']),
        'main_weather': (data['list'][0]['weather'][0]['main']),
        'icon0': data['list'][0]['weather'][0]['icon']?? '01d',
        'icon1': data['list'][1]['weather'][0]['icon']?? '01d',
        'icon2': data['list'][2]['weather'][0]['icon']?? '01d',
        'icon3': data['list'][3]['weather'][0]['icon']?? '01d',
        'icon4': data['list'][4]['weather'][0]['icon']?? '01d',
        'icon5': data['list'][5]['weather'][0]['icon']?? '01d',
        'icon6': data['list'][6]['weather'][0]['icon']?? '01d',

      };
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Weather App'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
      body:FutureBuilder(
        future: getCurrentWeather(),
        builder: (context,snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No data available.'));
          }

          final data = snapshot.data!;
          double temp = data['temp'] ?? 0.0;
          double humidity = data['humidity'] ?? 0.0;
          double pressure = data['pressure'] ?? 0.0;
          double windSpeed = data['wind_speed'] ?? 0.0;
          String time1=data['time1']??'3:00';
          String time2=data['time2']??'3:00';
          String time3=data['time3']??'3:00';
          String time4=data['time4']??'3:00';
          String time5=data['time5']??'3:00';
          String time6=data['time6']??'3:00';
          double temp1 = data['temp1'] ?? 0.0;
          double temp2 = data['temp2'] ?? 0.0;
          double temp3 = data['temp3'] ?? 0.0;
          double temp4 = data['temp4'] ?? 0.0;
          double temp5 = data['temp5'] ?? 0.0;
          double temp6 = data['temp6'] ?? 0.0;
          String main_weather =data['main_weather']??'Rain';
          String icon0=data['icon0']??Icons.cloud;
          String iconUrl = 'http://openweathermap.org/img/wn/$icon0@2x.png';
          String icon1 = data['icon1'] ?? '01d';
          String icon2 = data['icon2'] ?? '01d';
          String icon3 = data['icon3'] ?? '01d';
          String icon4 = data['icon4'] ?? '01d';
          String icon5 = data['icon5'] ?? '01d';
          String icon6 = data['icon6'] ?? '01d';


          return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '$temp °C',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Image.network(iconUrl),
                          const SizedBox(height: 16),
                          Text(
                            main_weather,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Weather Forecast',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyForecastItem(value: time1,temperature: temp1,icon:icon1),
                    HourlyForecastItem(value: time2,temperature: temp2,icon: icon2,),
                    HourlyForecastItem(value: time3,temperature: temp3,icon: icon3,),
                    HourlyForecastItem(value: time4,temperature: temp4,icon: icon4,),
                    HourlyForecastItem(value: time5,temperature: temp5,icon: icon5,),
                    HourlyForecastItem(value: time6,temperature: temp6,icon: icon6,),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Additional Forecast',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.water_drop, size: 34),
                      const SizedBox(height: 10),
                      const Text(
                        'Humidity',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$humidity',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.air, size: 34),
                      const SizedBox(height: 10),
                      const Text(
                        'Wind Speed',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$windSpeed',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.beach_access, size: 34),
                      const SizedBox(height: 10),
                      const Text(
                        'Pressure',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$pressure',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
              ),
        );
        },
      ),
    );
  }
}

