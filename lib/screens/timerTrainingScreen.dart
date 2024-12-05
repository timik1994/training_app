import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';

class TimerTrainingScreen extends StatefulWidget {
  final List <String> exerciseList;

 final  prepareTime;

  final  workTime;

  final  restTime;


  TimerTrainingScreen({required this.exerciseList, required this.prepareTime, required this.workTime, required this.restTime});


  @override
  State<TimerTrainingScreen> createState() => _TimerTrainingScreen();
}

class _TimerTrainingScreen extends State<TimerTrainingScreen> {
  late Timer _timer;
  int _currentIndex = 0;
  int _countdown=0;
  var exerciseList=[];
  final _audioPlayer = AudioCache();
  final ScrollController _scrollController = ScrollController();
  var fullTime;
  var leaveTime;
  int currentExercise = 0;
  int exercisesCount =0;
  bool  isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }


  Future<void> loadData() async {

    _countdown = widget.prepareTime;
    exercisesCount = widget.exerciseList.length;


    for (int i = 0; i < widget.exerciseList.length; i++) {
      exerciseList.add(widget.exerciseList[i]); // Добавляем элемент из 'test'
      if(i>0 && i <widget.exerciseList.length) {
        exerciseList.add("Отдых"); // Добавляем "Отдых" между элементами
      }
    }
    int totalTime = calculateTotalTime(exerciseList, widget.prepareTime,
        widget.workTime, widget.restTime);
    fullTime = formatTime(totalTime);
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  String formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds.remainder(60);
    return '$minutesм ${seconds}с';
  }


  int calculateTotalTime(List<dynamic> exerciseList, int prepareTime, int workTime, int restTime) {
    int totalDuration = 0;
    for (String exercise in exerciseList) {
      if (exercise.contains('Подготовка')) {
        totalDuration += prepareTime;
      } else if (exercise.contains('Отдых')) {
        totalDuration += restTime;
      } else {
        totalDuration += workTime;
      }
    }
    return totalDuration;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_countdown > 0) {
          if (_countdown <= 3) {
           // _playSound('audio/timer_go.mp3');
          }
          _countdown--;
        }
        else {
          if (_currentIndex < exerciseList.length - 1) {
            _currentIndex++;
            _countdown = _getCountdownForExercise(exerciseList[_currentIndex]);
            _playSound('audio/timer_end.mp3');
          } else {

          }
        }
      });
    });
  }

  Future<void> _playSound(String fileName) async {
    //final player = AudioCache();
    _audioPlayer.play(fileName);
  }


  // время упражнения в зависимости от типа
  int _getCountdownForExercise(String exercise) {
    if (exercise.contains('Подготовка')) {
      return widget.prepareTime;
    } else if (exercise.contains('Отдых')) {
      return widget.restTime;
    } else {
      return widget.workTime;
    }
  }

  // цвет упражнения в зависимости от типа
  Color _getExerciseTileColor(String exercise) {
    if (exercise.contains('Отдых')) {
      return Colors.blue;
    } else if (exercise.contains('Подготовка')) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  void _onExerciseTap(int index) {
    setState(() {
      _currentIndex = index;
      _countdown = _getCountdownForExercise(exerciseList[_currentIndex]);
      _scrollToExercise(index);
    });
  }

  void _scrollToExercise(int index) {
    //_scrollController.jumpTo(index * 65);
    _scrollController.animateTo(index * 65.0, duration: Duration(milliseconds: 1000), curve: Curves.ease);
  }

  bool _isNumeric(String str) {
    if (str.isEmpty) return false; // Если строка пустая, возвращаем false
    return int.tryParse(str) != null; // Возвращаем true, если удалось преобразовать
  }

  @override
  Widget build(BuildContext context) {

    if(_isNumeric(exerciseList[_currentIndex].split('.')[0])) {
      currentExercise=int.parse(exerciseList[_currentIndex].split('.')[0]);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 230,
              color: _getExerciseTileColor(exerciseList[_currentIndex]),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // название упражнения
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        exerciseList[_currentIndex],
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // обратный отсчет
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '$_countdown',
                        style: const TextStyle(fontSize: 36, color: Colors.white),
                      ),
                    ),

                    // счетчик упражнений
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '$currentExercise из $exercisesCount',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // общее время
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Время: $fullTime',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: exerciseList.length,
                  itemBuilder: (context, index) {
                    String exercise = exerciseList[index];

                    //_scrollController.jumpTo(index*20);
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              color: _getExerciseTileColor(exercise),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(child: Text(exercise, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.white),)),
                        ),
                        onTap: () => _onExerciseTap(index),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.blue),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(
              isTimerRunning ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
              color: Colors.blue,
            ),
            label: ''
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.arrowRight, color: Colors.blue),
            label: ''
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            if (_currentIndex > 0) {
              setState(() {
                _currentIndex--;
                _countdown = _getCountdownForExercise(exerciseList[_currentIndex]);
              });
              _scrollToExercise(_currentIndex);
            }
          } else if (index == 1) {
            setState(() {
              if (_timer.isActive) {
                _timer.cancel();
                isTimerRunning=false;
              } else {
                _startTimer();
                isTimerRunning=true;
              }
            });
          } else if (index == 2) {
            if (_currentIndex < exerciseList.length - 1) {
              setState(() {
                _currentIndex++;
                _countdown = _getCountdownForExercise(exerciseList[_currentIndex]);
              });
              _scrollToExercise(_currentIndex);
            }
          }
        },
      ),
    );
  }
}
