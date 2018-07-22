
class StatisticsState {

  final double sum;
  final double avg;
  final double max;
  final double min;
  final int count;

  StatisticsState({
    this.sum,
    this.avg,
    this.max,
    this.min,
    this.count
  });

  StatisticsState.initial()
      : sum = 0.0,
        avg = 0.0,
        max = 0.0,
        min = 0.0,
        count = 0;

  static StatisticsState fromJSON(Map<String, dynamic> data) {
    print(data);
    return StatisticsState(
      sum: data["sum"],
      avg: data["avg"],
      max: data["max"],
      min: data["min"],
      count: data["count"]
    );
  }

  @override
  String toString() => '''
    Statistics {
      sum: $sum,
      avg: $avg,
      max: $max,
      min: $min,
      count: $count
    }
  ''';
}
