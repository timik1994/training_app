import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_app/components/components.dart';
import 'package:training_app/screens/timerTrainingScreen.dart';
import 'package:training_app/services/storage_service.dart';

class CardioScreen extends StatefulWidget {
  const CardioScreen({super.key});

  @override
  State<CardioScreen> createState() => _CardioScreen();
}

class _CardioScreen extends State<CardioScreen> {
  List<String> exerciseList = [];
  final StorageService _storageService = StorageService();

  late final TextEditingController _prepareController = TextEditingController();
  late final TextEditingController _workController = TextEditingController();
  late final TextEditingController _restController = TextEditingController();

  final FocusNode _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    loadExercises();
   loadTimerParams();
  }

  Future<void> loadExercises() async {

    String data = await rootBundle.loadString('assets/cardio_exercises.txt');
    List<String> exercises = data.split('\n');

    // for (int i = 2; i < exercises.length; i += 2) {
    //   exercises.insert(i, "Отдых");
    // }

    for (int i = 0; i < exercises.length; i++) {
      exerciseList.add('${i + 1}. ${exercises[i]}');
    }
  }

  Future<void> loadTimerParams() async {

      var params = await _storageService.getCardioParams();

      if (params['prepare_time']==null) {
        setState(() {
          _prepareController.text = '15';
          _workController.text = '30';
          _restController.text = '30';
        });
      }
      else {
        setState(() {
          _prepareController.text = params['prepare_time']!;
          _workController.text = params['work_time']!;
          _restController.text = params['rest_time']!;
        });
      }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const MyAppBar(
        title: "Кардио",
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
              height: 450,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Настройки таймера',
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

                  // подготовка
                  timerSettings('Подготовка', _prepareController),

                  // работа
                  timerSettings('Работа', _workController),

                  // работа
                  timerSettings('Отдых', _restController),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextButton(
              onPressed: () => showExerciseListDialog(),
              child:  Text('Список упражнений', style: TextStyle(color: Theme.of(context).buttonColor, fontSize: 20),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ElevatedButton(
              onPressed: () async {

                await _storageService.setCardioParams(_prepareController.text,
                    _workController.text, _restController.text);

                if(mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TimerTrainingScreen(
                            exerciseList: exerciseList,
                            prepareTime: int.parse(_prepareController.text),
                            workTime: int.parse(_workController.text),
                            restTime: int.parse(_restController.text),
                          ),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),


                fixedSize: MaterialStateProperty.all(
                  const Size(120, 80),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: const Text(
                'СТАРТ',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timerSettings(String labelName, var controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          // название раздела
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              labelName,
              style: const TextStyle(fontSize: 18),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // кнопка уменьшения времени
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  width: 45,
                  child: FloatingActionButton(
                    heroTag: '$labelName down',
                    onPressed: () {
                      setState(() {
                        int currentValue = int.tryParse(controller.text) ?? 0;
                        controller.text = (--currentValue).toString();
                      });
                    },
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: const Color(0xFFEE8B60),
                    child: const FaIcon(
                      FontAwesomeIcons.minus,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),

              // ввод времени
              SizedBox(
                width: 80,
                child: GestureDetector(
                  onTap: () => _focusNode.unfocus(),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 18),
                    controller: controller,
                    //initialValue: _prepareController.text,
                    keyboardType: TextInputType.none,
                    focusNode: _focusNode,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(
                          color: Theme.of(context).primaryColorDark,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(
                          color: Theme.of(context).primaryColorDark,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:  BorderSide(
                          color: Theme.of(context).primaryColorDark,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:  BorderSide(
                          color: Theme.of(context).primaryColorDark,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    //validator: _model.textController2Validator.asValidator(context),
                  ),
                ),
              ),

              // кнопка увеличения времени
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 45,
                  child: FloatingActionButton(
                    heroTag: '$labelName up',
                    onPressed: () {
                      setState(() {
                        int currentValue = int.tryParse(controller.text) ?? 0;
                        controller.text = (++currentValue).toString();
                      });
                    },
                    shape: CircleBorder(
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1.0,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColorDark,
                    child: const FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  TextEditingController _controller = TextEditingController();

  Future <void> showExerciseListDialog() async {

    double dataRowHeight= 40;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          'Список упражнений',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.bodyLarge?.color),
                        ),
                      ),
                    ),

                    // таблица
                    Expanded(
                      child: ListView.builder(
                        itemCount: exerciseList.length,
                        itemBuilder: (context, index) {
                          final exercise = exerciseList[index];
                          return ListTile(
                            title: Text(exercise),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red,),
                              onPressed: () {
                                setState(() {
                                  exerciseList.removeAt(index);
                                });
                              }
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: 'Добавить упражнение',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.green,),
                            onPressed: () {
                              setState(() {
                                exerciseList.add(_controller.text);
                              });
                              }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }

  void _addExercise(String exercise) {
    setState(() {
      exerciseList.add(exercise);
      //_saveExercises();
    });
  }

  void _removeExercise(int index) {
    setState(() {
      exerciseList.removeAt(index);
      //_saveExercises();
    });
  }
}
