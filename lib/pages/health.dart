import 'package:flutter/material.dart';
import 'package:active_log/services/google_sign_in_helper.dart';
import 'package:active_log/services/health_connect_service.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  final GoogleSignInHelper _googleSignInHelper = GoogleSignInHelper();
  final HealthConnectService _healthConnectService = HealthConnectService();
  String _steps = 'Loading...';
  String _heartRate = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final account = await _googleSignInHelper.signIn();
    if (account != null) {
      final accessToken = await _googleSignInHelper.getAccessToken(account);

      if (accessToken != null) {
        try {
          final stepsData = await _healthConnectService.getData(accessToken, 'com.google.step_count.delta');
          final heartRateData = await _healthConnectService.getData(accessToken, 'com.google.heart_rate.bpm');

          setState(() {
            _steps = stepsData['bucket'][0]['dataset'][0]['point'][0]['value'][0]['intVal'].toString();
            _heartRate = heartRateData['bucket'][0]['dataset'][0]['point'][0]['value'][0]['fpVal'].toString();
          });
        } catch (error) {
          print('Ошибка при получении данных: $error');
        }
      } else {
        print('Не удалось получить токен доступа');
      }
    } else {
      print('Не удалось войти в аккаунт');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Connect Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Steps: $_steps'),
            Text('Heart Rate: $_heartRate'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Обновить данные'),
            ),
          ],
        ),
      ),
    );
  }
}
