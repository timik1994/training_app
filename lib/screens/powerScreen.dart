import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_app/components/components.dart';
import 'package:training_app/screens/powerTrainingScreen.dart';
import 'package:training_app/screens/timerTrainingScreen.dart';
import 'package:training_app/services/storage_service.dart';

class PowerScreen extends StatefulWidget {
  const PowerScreen({super.key});

  @override
  State<PowerScreen> createState() => _PowerScreen();
}

class _PowerScreen extends State<PowerScreen> {
  //List<String> exerciseList = [];
  final StorageService _storageService = StorageService();

  List <String> backExercises=[];
  List <String> bicepsExercises=[];
  List <String> chestExercises=[];
  List <String> tricepsExercises=[];
  List <String> legsExercises=[];
  List <String> shoulderExercises=[];
  List <String> fullbodyExercises=[];

  final FocusNode _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    loadExercises();
  }

  // Future<void> loadExercises() async {
  //
  //   String data = await rootBundle.loadString('assets/back_exercises.txt');
  //   List<String> exercises = data.split('\n');
  //
  //   for (int i = 0; i < exercises.length; i++) {
  //     backExercises.add('${i + 1}. ${exercises[i]}');
  //   }
  // }

  Future<void> loadExercises() async {
    List<String> fileNames = ['back_exercises.txt', 'biceps_exercises.txt', 'chest_exercises.txt',
      'triceps_exercises.txt', 'legs_exercises.txt', 'shoulders_exercises.txt', 'fullbody_exercises.txt'];

    for (var fileName in fileNames) {
      String data = await rootBundle.loadString('assets/$fileName');
      List<String> exercises = data.split('\n');
      List<String> formattedExercises = exercises.map((exercise) => '${exercises.indexOf(exercise) + 1}. $exercise').toList();
      switch (fileName) {
        case 'back_exercises.txt':
          backExercises.addAll(formattedExercises);
          break;
        case 'biceps_exercises.txt':
          bicepsExercises.addAll(formattedExercises);
          break;
        case 'chest_exercises.txt':
          chestExercises.addAll(formattedExercises);
          break;
        case 'triceps_exercises.txt':
          tricepsExercises.addAll(formattedExercises);
          break;
        case 'legs_exercises.txt':
          legsExercises.addAll(formattedExercises);
          break;
        case 'shoulders_exercises.txt':
          shoulderExercises.addAll(formattedExercises);
          break;
        case 'fullbody_exercises.txt':
          fullbodyExercises.addAll(formattedExercises);
          break;
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const MyAppBar(
        title: "Силовые",
      ),
      body: Column(
        children: [
          Material(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 550,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Выбор программы',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),

                  // разделитель
                  Divider(
                    indent: 50,
                    endIndent: 50,
                    thickness: 2,
                    color: Theme.of(context).primaryColorDark,
                  ),

                  // спина+бицепс
                  selectTraining('Спина + бицепс', Colors.blue[200]!, backExercises, secondExerciseList:bicepsExercises),

                  // грудь+трицепс
                  selectTraining('Грудь + трицепс', Colors.blue[300]!, chestExercises, secondExerciseList:tricepsExercises),

                  // ноги+плечи
                  selectTraining('Ноги + плечи', Colors.blue[400]!, legsExercises, secondExerciseList:shoulderExercises),

                  // фуллбоди
                  selectTraining('Full-body', Colors.blue[500]!, fullbodyExercises),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // в зависимости от Типа тренинга передает различные листы упражнений
  Widget selectTraining(String buttonLabel, Color buttonColor, var firstExerciseList, {var secondExerciseList}) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PowerTrainingScreen(
                firstExerciseList: firstExerciseList,
                secondExerciseList: secondExerciseList,
              ),
            ),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),


          fixedSize: MaterialStateProperty.all(
            const Size(250, 80),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: Text(
          buttonLabel,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
