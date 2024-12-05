import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PowerTrainingScreen extends StatefulWidget {
  final List <String> firstExerciseList;
  final List <String>? secondExerciseList;


  PowerTrainingScreen({required this.firstExerciseList, this.secondExerciseList});


  @override
  State<PowerTrainingScreen> createState() => _PowerTrainingScreen();
}

class _PowerTrainingScreen extends State<PowerTrainingScreen> {
  int _currentIndex = 0;
  int firstExerciseLength = 0;
  final ScrollController _scrollController = ScrollController();


  List<String> exercises = [];



  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future <void> loadData() async{
    if(widget.secondExerciseList!=null) {
      exercises = widget.firstExerciseList + widget.secondExerciseList!;
    }
    else {
      exercises = widget.firstExerciseList;
    }
    firstExerciseLength = widget.firstExerciseList.length;
  }


  void _scrollToExercise(int index) {
    _scrollController.animateTo(index * 65.0, duration: const Duration(milliseconds: 1000), curve: Curves.ease);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 230,
              color: _currentIndex <= firstExerciseLength-1 ? Colors.blue : Colors.cyan,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // название упражнения
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Center(
                        child: Text(
                          exercises[_currentIndex],
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),


                    // счетчик упражнений
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        '${_currentIndex+1} из ${exercises.length}',
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
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    String exercise = exercises[index];

                    //_scrollController.jumpTo(index*20);
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              color: index <= firstExerciseLength-1 ? Colors.blue : Colors.cyan,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(child: Text(exercise, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.white),)),
                        ),
                        onTap: () {
                          setState(() {
                            _currentIndex=index;
                          });
                            _scrollToExercise(index);
                        }
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
