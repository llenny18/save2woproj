import 'package:save2woproj/model/base.dart';
class Contamination extends BaseModel {
  final WaterQuality waterquality;
  Contamination(
      {required super.cage,
      required super.timestamp,
      required this.waterquality,
      required super.contamination});
  @override
  factory Contamination.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> waterQuality = json['water_quality'];
    final Map<String, dynamic> timestamp = json['timestamp'];
    final int milliseconds = (timestamp['seconds'] * 1000);
    return Contamination(
        cage: json['cage'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(milliseconds),
        waterquality: WaterQuality(
            dissolvedOxygen: waterQuality["DO"],
            pH: waterQuality["pH"],
            temperature: waterQuality["Temperature"],
            nitrogen: waterQuality["NO2"]),
        contamination: json['Contamination']);
  }
}

class Threshold extends BaseModel {
  final String status;
  Threshold(
      {required this.status,
      required super.cage,
      required super.timestamp,
      required super.contamination});
  @override
  factory Threshold.fromJson(Map<String, dynamic> json) {
    return Threshold(
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        json['timestamp']['seconds'] * 1000,
      ),
      status: json['status'],
      cage: json['cage'],
      contamination: json['contamination'] ?? '',
    );
  }
}

class History extends Contamination {
  //https://save2wo-api.vercel.app/history
  final int deadFish;
  History(
      {required super.cage,
      required super.timestamp,
      required super.waterquality,
      required this.deadFish,
      required super.contamination});

  @override
  factory History.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> waterQuality = json['water_quality'];
    final Map<String, dynamic> timestamp = json['timestamp'];
    final int milliseconds = (timestamp['seconds'] * 1000);

    return History(
        cage: json['cage'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(milliseconds),
        waterquality: WaterQuality(
            dissolvedOxygen: waterQuality["DO"],
            pH: waterQuality["pH"],
            temperature: waterQuality["Temperature"],
            nitrogen: waterQuality["NO2"]),
        deadFish: json['dead_fish'],
        contamination: json['Contamination']);
  }
}

class WaterQuality {
  final int dissolvedOxygen;
  final double pH;
  final double nitrogen;
  final int temperature;

  WaterQuality(
      {required this.dissolvedOxygen,
      required this.pH,
      required this.nitrogen,
      required this.temperature});
}
