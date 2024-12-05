class ExercisesStatistic {
  int id;
  String date;
  String weight;
  String biceps_volume;
  String chest_volume;
  String waist_volume;
  String hip_volume;
  String calves_volume;


  ExercisesStatistic(
      {required this.id,
        required this.date,
        required this.weight,
        required this.biceps_volume,
        required this.chest_volume,
        required this.waist_volume,
        required this.hip_volume,
        required this.calves_volume
      });


  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'weight': weight,
      'biceps_volume': biceps_volume,
      'chest_volume': chest_volume,
      'waist_volume': waist_volume,
      'hip_volume': hip_volume,
      'calves_volume': calves_volume
    };
  }

  factory ExercisesStatistic.fromJson(Map<String, dynamic> json) {
    return  ExercisesStatistic(
      id: json['id'],
      date: json['date'],
      weight: json['weight'],
      biceps_volume: json['biceps_volume'],
      chest_volume: json['chest_volume'],
      waist_volume: json['waist_volume'],
      hip_volume: json['hip_volume'],
        calves_volume: json['calves_volume']
    );
  }


  @override
  String toString() {
    return 'bodyVolume{id: $id, date: $date, weight: $weight, biceps: $biceps_volume, chest^ $chest_volume,'
        'waist: $waist_volume, hip: $hip_volume, calves_volume: $calves_volume}';
  }
}
