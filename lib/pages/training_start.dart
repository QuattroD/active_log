import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class TrainingStartPage extends StatefulWidget {
  const TrainingStartPage({
    super.key,
  });

  @override
  State<TrainingStartPage> createState() => _TrainingStartPageState();
}

class _TrainingStartPageState extends State<TrainingStartPage> {
  List<DocumentSnapshot> exercisesSnapshot = [];
  int _currentIndex = 0;
  Timer? _timer;
  double _progress = 0;
  int _currentDuration = 0;
  int _totalDuration = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  void _fetchExercises() async {
    QuerySnapshot exercisesQuerySnapshot = await FirebaseFirestore.instance
        .collection('Workouts')
        .doc('yoga_for_beginners')
        .collection('Exercises')
        .get();

    setState(() {
      exercisesSnapshot = exercisesQuerySnapshot.docs;
    });

    _startExercise();
  }

  void _startExercise() {
    if (exercisesSnapshot.isNotEmpty) {
      final currentExercise =
          exercisesSnapshot[_currentIndex].data() as Map<String, dynamic>;
      _totalDuration = int.parse(currentExercise['time_or_repeats']);
      _currentDuration = 0;
      _progress = 0;

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!_isPaused) {
          setState(() {
            if (_currentDuration < _totalDuration) {
              _currentDuration++;
              _progress = _currentDuration / _totalDuration;
            } else {
              _timer?.cancel();
              _nextExercise();
            }
          });
        }
      });
    }
  }

  void _nextExercise() {
    if (_currentIndex < exercisesSnapshot.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _startExercise();
    } else {
      // Все упражнения выполнены
      print('Workout complete');
    }
  }

  void _previousExercise() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _startExercise();
    }
  }

  void _pauseResumeExercise() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (exercisesSnapshot.isEmpty) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    final currentExercise =
        exercisesSnapshot[_currentIndex].data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise ${_currentIndex + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentExercise['name'], style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            SizedBox(
                child: Image(image: NetworkImage(currentExercise['image']))),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: _progress,
                    strokeWidth: 10.0,
                    backgroundColor: const Color.fromARGB(255, 242, 236, 255),
                  ),
                ),
                Text("${_currentDuration}s / ${_totalDuration}s"),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 225, 213, 250))),
                  width: 60,
                  height: 60,
                  child: TextButton(
                    onPressed: _previousExercise,
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _pauseResumeExercise,
                  child: Text(_isPaused ? 'Продолжить' : 'Пауза'),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 225, 213, 250))),
                  width: 60,
                  height: 60,
                  child: TextButton(
                      onPressed: _nextExercise,
                      child: const RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
