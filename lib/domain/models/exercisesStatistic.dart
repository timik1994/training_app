class ExercisesStatistic {
  int id;
  String date;
  int cardio;
  int press;
  int power;


  ExercisesStatistic(
      {required this.id,
        required this.date,
        required this.cardio,
        required this.press,
        required this.power,
      });


  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'cardio': cardio,
      'press': press,
      'power': power,
    };
  }

  factory ExercisesStatistic.fromJson(Map<String, dynamic> json) {
    return  ExercisesStatistic(
      id: json['id'],
      date: json['date'],
      cardio: json['cardio'],
      press: json['press'],
      power: json['power'],
    );
  }


  @override
  String toString() {
    return 'exercisesStatistic{id: $id, date: $date, cardio: $cardio, press: $press, power: $power}';
  }
}
