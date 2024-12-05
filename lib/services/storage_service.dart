import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService{
  final storage = const FlutterSecureStorage();

  Future <void> setCardioParams(var prepareTime, var workTime, var restTime) async {
    await storage.write(key: 'cardio_prepare_time', value: prepareTime);
    await storage.write(key: 'cardio_work_time', value: workTime);
    await storage.write(key: 'cardio_rest_time', value: restTime);
  }

  Future<Map<String, String?>> getCardioParams() async {
    var prepareTime = await storage.read(key: 'cardio_prepare_time');
    var workTime = await storage.read(key: 'cardio_work_time');
    var restTime = await storage.read(key: 'cardio_rest_time');

    var result = {
      'prepare_time' : prepareTime,
      'work_time' : workTime,
      'rest_time' : restTime
    };
    return result;
  }

  Future <void> setPressParams(var prepareTime, var workTime, var restTime) async {
    await storage.write(key: 'press_prepare_time', value: prepareTime);
    await storage.write(key: 'press_work_time', value: workTime);
    await storage.write(key: 'press_rest_time', value: restTime);
  }


  Future<Map<String, String?>> getPressParams() async {
    var prepareTime = await storage.read(key: 'press_prepare_time');
    var workTime = await storage.read(key: 'press_work_time');
    var restTime = await storage.read(key: 'press_rest_time');

    var result = {
      'prepare_time' : prepareTime,
      'work_time' : workTime,
      'rest_time' : restTime
    };
    return result;
  }
}