import 'dart:convert';
import 'package:http/http.dart' as http;

class HealthConnectService {
  final String _baseUrl = 'https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate';

  Future<Map<String, dynamic>> getData(String accessToken, String dataTypeName) async {
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    // Получение текущей даты и времени
    DateTime now = DateTime.now();
    // Установка начала и конца текущего дня
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1)).subtract(Duration(milliseconds: 1));

    final body = json.encode({
      "aggregateBy": [{
        "dataTypeName": dataTypeName
      }],
      "bucketByTime": {
        "durationMillis": 86400000
      },
      "startTimeMillis": startOfDay.millisecondsSinceEpoch,
      "endTimeMillis": endOfDay.millisecondsSinceEpoch,
    });

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Ошибка при получении данных: ${response.statusCode}');
      print('Тело ответа: ${response.body}');
      throw Exception('Failed to fetch data');
    }
  }
}
