import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:training_app/components/components.dart';
import 'package:training_app/domain/controllers/bodyVolume.dart';
import 'package:training_app/services/db.dart';

class RulerScreen extends StatefulWidget {
  const RulerScreen({super.key});

  @override
  State<RulerScreen> createState() => _RulerScreen();
}

class _RulerScreen extends State<RulerScreen> {
  List<String> exerciseList = [];

  final TextEditingController _weightController = TextEditingController();
 final TextEditingController _bicepsController = TextEditingController();
   final TextEditingController _chestController = TextEditingController();
 final TextEditingController _waistController = TextEditingController();
final TextEditingController _hipController = TextEditingController();
   final TextEditingController _calvesController = TextEditingController();


  final FocusNode _focusNode = FocusNode();

  List<Map<String, dynamic>> resultMap = [];


  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    var dataFromDB = await DBProvider.db.selectLastRecord();
    setState(() {
      _weightController.text = dataFromDB?['weight'] ?? '90';
      _bicepsController.text = dataFromDB?['biceps_volume'] ?? '90';
      _chestController.text = dataFromDB?['chest_volume'] ?? '90';
      _waistController.text = dataFromDB?['waist_volume'] ?? '90';
      _hipController.text = dataFromDB?['hip_volume'] ?? '90';
      _calvesController.text = dataFromDB?['calves_volume'] ?? '90';
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const MyAppBar(
        title: "Измерения",
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
                      'Измерение параметров тела',
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

                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        switch (index) {
                          case 0:
                            return inputBodyVolume('Вес', _weightController);
                          case 1:
                            return inputBodyVolume('Бицепс', _bicepsController);
                          case 2:
                            return inputBodyVolume('Грудь', _chestController);
                          case 3:
                            return inputBodyVolume('Талия', _waistController);
                          case 4:
                            return inputBodyVolume('Бедра', _hipController);
                        }
                      },
                    ),
                  ),

                  // ListView(
                  //   children: [
                  //     inputBodyVolume('Вес', _weightController),
                  //
                  //     // бицепс
                  //     inputBodyVolume('Бицепс', _bicepsController),
                  //
                  //     // грудь
                  //     inputBodyVolume('Грудь', _chestController),
                  //
                  //     // талия
                  //     inputBodyVolume('Талия', _waistController),
                  //
                  //     // бедра
                  //     inputBodyVolume('Бедра', _hipController),
                  //
                  //     // икры
                  //     inputBodyVolume('Икры', _calvesController),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),

          // кнопка ввода
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () async {

                DateTime now = DateTime.now();
                String formattedDate = DateFormat('dd-MM-yyyy').format(now);

                var values = {
                  'date': formattedDate,
                  'weight': _weightController.text,
                  'biceps_volume': _bicepsController.text,
                  'chest_volume': _chestController.text,
                  'waist_volume': _waistController.text,
                  'hip_volume': _hipController.text,
                  'calves_volume': _calvesController.text,
                };

                await DBProvider.db.insert('bodyVolume', values);


              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),


                fixedSize: MaterialStateProperty.all(
                  const Size(150, 80),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: const Text(
                'ВВЕСТИ',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),

          // кнопка показа статистики
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextButton(
              onPressed: () async {
                resultMap = await BodyVolumeController.selectAll();
                showHistoryRulerDialog();
              },
              child:  Text('Статистика', style: TextStyle(color: Theme.of(context).buttonColor, fontSize: 20),),
            ),
          ),
        ],
      ),
    );
  }

  // ввод измерений
  Widget inputBodyVolume(String labelName, var controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
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
              // кнопка уменьшения
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

              // ввод
              SizedBox(
                width: 80,
                child: GestureDetector(
                  onTap: () => _focusNode.unfocus(),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 18),
                    controller: controller,
                    //initialValue: controller.text,
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
                  ),
                ),
              ),

              // кнопка увеличения
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

  // диалог истории замеров
  Future <void> showHistoryRulerDialog() async {

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
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListView(
              children: [
                // заголовок
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      'История измерений',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                  ),
                ),
                // отступ
                const SizedBox(height: 10),

                // таблица
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(

                    dataRowHeight: dataRowHeight,
                    columns: [
                      cellName('Дата'),
                      cellName('Вес'),
                      cellName('Бицепс'),
                      cellName('Грудь'),
                      cellName('Талия'),
                      cellName('Бедра'),
                      cellName('Икры'),
                      cellName('Удаление'),
                    ],

                    rows: resultMap.map((entry) {
                      int id= entry['id'];
                      String date = entry['date'];
                      String weight= entry['weight'];
                      String biceps = entry['biceps_volume'];
                      String chest = entry['chest_volume'];
                      String waist = entry['waist_volume'];
                      String hip = entry['hip_volume'];
                      String calves = entry['calves_volume'];

                      return DataRow(
                        cells: [
                          cellData(date),
                          cellData(weight),
                          cellData(biceps),
                          cellData(chest),
                          cellData(waist),
                          cellData(hip),
                          cellData(calves),

                          DataCell(
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: 80,
                                child: SingleChildScrollView(
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () async {
                                        await DBProvider.db.delete('bodyVolume', id);
                                        // int index = resultMap.indexWhere((element) => element['id'] == id);
                                        // setState(() {
                                        //   resultMap.removeAt(index);
                                        // });
                                      },
                                      icon: const Icon(FontAwesomeIcons.trash, size: 30, color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


  // названия колонок
  DataColumn cellName(String labelName) {
    return DataColumn(
      label: Container(
        width: 80,
        alignment: Alignment.center,
        child: Text(labelName),
      ),
    );
  }

  // заполняем колонки
  DataCell cellData(String data) {
    return DataCell(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
          width: 80,
          child: SingleChildScrollView(
            child: Center(
              child: Text(
                data,
                softWrap: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
