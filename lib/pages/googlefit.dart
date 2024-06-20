import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:active_log/services/util.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:carp_serializable/carp_serializable.dart';

class HealthApp extends StatefulWidget {
  const HealthApp({super.key});

  @override
  _HealthAppState createState() => _HealthAppState();
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTHORIZED,
  AUTH_NOT_GRANTED,
  STEPS_READY,
  HEARTS_READY,
  HEALTH_CONNECT_STATUS,
}

@override
class _HealthAppState extends State<HealthApp> {
  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;
  int _nofSteps = 0;
  int _noHeartRates = 0;

  List<HealthDataType> get types => (Platform.isAndroid)
      ? dataTypesAndroid
      : (Platform.isIOS)
          ? dataTypesIOS
          : [];

  List<HealthDataAccess> get permissions =>
      types.map((e) => HealthDataAccess.READ).toList();

  void initState() {
    Health().configure(useHealthConnectIfAvailable: true);
    authorize();
    super.initState();
  }

  Future<void> authorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    bool? hasPermissions =
        await Health().hasPermissions(types, permissions: permissions);
    hasPermissions = false;

    bool authorized = false;
    if (!hasPermissions) {
      try {
        authorized = await Health()
            .requestAuthorization(types, permissions: permissions);
      } catch (error) {
        debugPrint("Exception in authorize: $error");
      }
    }

    setState(() => _state =
        (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED);
  }

  /// Gets the Health Connect status on Android.
  Future<void> getHealthConnectSdkStatus() async {
    assert(Platform.isAndroid, "This is only available on Android");

    final status = await Health().getHealthConnectSdkStatus();

    setState(() {
      _contentHealthConnectStatus = Text('Health Connect Status: $status');
      _state = AppState.HEALTH_CONNECT_STATUS;
    });
  }

  /// Fetch data points from the health plugin and show them in the app.
  Future<void> fetchData() async {
    setState(() => _state = AppState.FETCHING_DATA);

    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    // Clear old data points
    _healthDataList.clear();

    try {
      // fetch health data
      List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
        types: types,
        startTime: yesterday,
        endTime: now,
      );

      debugPrint('Total number of data points: ${healthData.length}. '
          '${healthData.length > 100 ? 'Only showing the first 100.' : ''}');

      // save all the new data points (only the first 100)
      _healthDataList.addAll(
          (healthData.length < 100) ? healthData : healthData.sublist(0, 100));
    } catch (error) {
      debugPrint("Exception in getHealthDataFromTypes: $error");
    }

    // filter out duplicates
    _healthDataList = Health().removeDuplicates(_healthDataList);

    //_healthDataList.forEach((data) => debugPrint(toJsonString(data)));

    // update the UI to display the results
    setState(() {
      _state = _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
    });
  }

  /// Fetch steps from the health plugin and show them in the app.
  Future<void> fetchStepData() async {
    int? steps;

    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool stepsPermission =
        await Health().hasPermissions([HealthDataType.STEPS]) ?? false;
    if (!stepsPermission) {
      stepsPermission =
          await Health().requestAuthorization([HealthDataType.STEPS]);
    }

    if (stepsPermission) {
      try {
        steps = await Health().getTotalStepsInInterval(midnight, now);
      } catch (error) {
        debugPrint("Exception in getTotalStepsInInterval: $error");
      }

      debugPrint('Total number of steps: $steps');

      setState(() {
        _nofSteps = (steps == null) ? 0 : steps;
        _state = (steps == null) ? AppState.NO_DATA : AppState.STEPS_READY;
      });
    } else {
      debugPrint("Authorization not granted - error in authorization");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Future<void> fetchHeartRateData() async {
    int? heart_rates;

    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool heart_ratesPermission =
        await Health().hasPermissions([HealthDataType.HEART_RATE]) ?? false;
    if (!heart_ratesPermission) {
      heart_ratesPermission =
          await Health().requestAuthorization([HealthDataType.HEART_RATE]);
    }

    if (heart_ratesPermission) {
      try {
        heart_rates = await Health().getTotalStepsInInterval(midnight, now);
      } catch (error) {
        debugPrint("Exception in getTotalHeartRatesInInterval: $error");
      }

      debugPrint('Heart rates: $heart_rates');

      setState(() {
        _noHeartRates = (heart_rates == null) ? 0 : heart_rates;
        _state = (heart_rates == null) ? AppState.NO_DATA : AppState.HEARTS_READY;
      });
    } else {
      debugPrint("Authorization not granted - error in authorization");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  // UI building below

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Health Example'),
        ),
        body: Column(
          children: [
            Wrap(
              spacing: 10,
              children: [
                TextButton(
                    onPressed: authorize,
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    child: const Text("Authenticate",
                        style: TextStyle(color: Colors.white))),
                if (Platform.isAndroid)
                  TextButton(
                      onPressed: getHealthConnectSdkStatus,
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      child: const Text("Check Health Connect Status",
                          style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: fetchData,
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    child: const Text("Fetch Data",
                        style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: fetchStepData,
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    child: const Text("Fetch Step Data",
                        style: TextStyle(color: Colors.white))),
                        TextButton(
                    onPressed: fetchHeartRateData,
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    child: const Text("Fetch Heart Rate Data",
                        style: TextStyle(color: Colors.white))),
              ],
            ),
            const Divider(thickness: 3),
            Expanded(child: Center(child: _content))
          ],
        ),
      ),
    );
  }

  Widget get _contentFetchingData => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(20),
              child: const CircularProgressIndicator(
                strokeWidth: 10,
              )),
          const Text('Fetching data...')
        ],
      );

  Widget get _contentDataReady => ListView.builder(
      itemCount: _healthDataList.length,
      itemBuilder: (_, index) {
        HealthDataPoint p = _healthDataList[index];
        if (p.value is WorkoutHealthValue) {
          return ListTile(
            title: Text(
                "${p.typeString}: ${(p.value as WorkoutHealthValue).totalEnergyBurned} ${(p.value as WorkoutHealthValue).totalEnergyBurnedUnit?.name}"),
            trailing:
                Text((p.value as WorkoutHealthValue).workoutActivityType.name),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
          );
        }
        if (p.value is NutritionHealthValue) {
          return ListTile(
            title: Text(
                "${p.typeString} ${(p.value as NutritionHealthValue).mealType}: ${(p.value as NutritionHealthValue).name}"),
            trailing:
                Text('${(p.value as NutritionHealthValue).calories} kcal'),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
          );
        }
        return ListTile(
          title: Text("${p.typeString}: ${p.value}"),
          trailing: Text(p.unitString),
          subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
        );
      });

  final Widget _contentNoData = const Text('No Data to show');

  final Widget _contentNotFetched =
      const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text("Press 'Auth' to get permissions to access health data."),
    Text("Press 'Fetch Dat' to get health data."),
  ]);

  final Widget _authorized = const Text('Authorization granted!');

  final Widget _authorizationNotGranted = const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Authorization not given.'),
      Text(
          'For Google Fit please check your OAUTH2 client ID is correct in Google Developer Console.'),
      Text(
          'For Google Health Connect please check if you have added the right permissions and services to the manifest file.'),
      Text('For Apple Health check your permissions in Apple Health.'),
    ],
  );

  Widget _contentHealthConnectStatus = const Text(
      'No status, click getHealthConnectSdkStatus to get the status.');

  Widget get _stepsFetched => Text('Total number of steps: $_nofSteps.');
  Widget get _heartsFetched => Text('Heart rate: $_noHeartRates.');

  Widget get _content => switch (_state) {
        AppState.DATA_READY => _contentDataReady,
        AppState.DATA_NOT_FETCHED => _contentNotFetched,
        AppState.FETCHING_DATA => _contentFetchingData,
        AppState.NO_DATA => _contentNoData,
        AppState.AUTHORIZED => _authorized,
        AppState.AUTH_NOT_GRANTED => _authorizationNotGranted,
        AppState.STEPS_READY => _stepsFetched,
        AppState.HEARTS_READY => _heartsFetched,
        AppState.HEALTH_CONNECT_STATUS => _contentHealthConnectStatus,
      };
}
