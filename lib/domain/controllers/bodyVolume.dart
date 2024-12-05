import 'package:training_app/domain/models/bodyVolume.dart';

import '../../services/db.dart';

class BodyVolumeController {
  static const String _tableName = "bodyVolume";
  static Future<dynamic> insert(Map<String, dynamic> json) async {
    ExercisesStatistic bodyVolume = ExercisesStatistic.fromJson(json);
    return await DBProvider.db.insert(_tableName, bodyVolume.toJson());
  }

  static Future<void> deleteAll() async {
    return await DBProvider.db.deleteAll(_tableName);
  }

  static Future<ExercisesStatistic?> selectBodyVolume() async {
    List<Map<String, dynamic>> bodyVolumeFromDb =
    await DBProvider.db.selectAll(_tableName);
    if (bodyVolumeFromDb == null || bodyVolumeFromDb.isEmpty) return null;
    return ExercisesStatistic.fromJson(bodyVolumeFromDb[0]);
  }

  static Future<List<Map<String, dynamic>>> selectAll() async {
    return await DBProvider.db.selectAll(_tableName);
  }
}
