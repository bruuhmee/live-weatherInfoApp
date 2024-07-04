import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget{
  final String value;
  final double temperature;
  final String icon;


  HourlyForecastItem({
    super.key,
    required this.icon,
    required this.value,
    required this.temperature,
  });

  String extractTime(String dateTime) {
    List<String> parts = dateTime.split(' ');
    String time=parts.length > 1 ? parts[1] : '';
    return time;
  }


  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(8.0),

        child: Column(
          children: [
            Text('${extractTime(value)}',style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(height: 8),
            Image.network('http://openweathermap.org/img/wn/$icon@2x.png'),
            const SizedBox(height: 8),
            const Text('Temp:',style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            Text('$temperature'),
          ],
        ),
      ),
    );
  }
}