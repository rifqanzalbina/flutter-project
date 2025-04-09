class TimeData {
  final String date;
  final String time;
  final String timeZone;

  TimeData({required this.date, required this.time, required this.timeZone});

  factory TimeData.fromJson(Map<String, dynamic> json) {
    return TimeData(
      date: json['date'],
      time: json['time'],
      timeZone: json['timeZone'],
    );
  }
}
