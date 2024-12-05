import 'package:training_app/domain/models/bodyVolume.dart';

import '../../services/db.dart';

class ExercisesStatisticController {
  static const String _tableName = "bodyVolume";
  static Future<dynamic> insert(Map<String, dynamic> json) async {
    ExercisesStatistic exercisesStatistic = ExercisesStatistic.fromJson(json);
    return await DBProvider.db.insert(_tableName, exercisesStatistic.toJson());
  }

  static Future<void> deleteAll() async {
    return await DBProvider.db.deleteAll(_tableName);
  }

  static Future<ExercisesStatistic?> selectExercisesStatistic() async {
    List<Map<String, dynamic>> exercisesStatisticFromDb =
    await DBProvider.db.selectAll(_tableName);
    if (exercisesStatisticFromDb == null || exercisesStatisticFromDb.isEmpty) return null;
    return ExercisesStatistic.fromJson(exercisesStatisticFromDb[0]);
  }

  static Future<List<Map<String, dynamic>>> selectAll() async {
    return await DBProvider.db.selectAll(_tableName);
  }
}
