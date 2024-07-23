class Contamination{
  final int cage;
  final DateTime timestamp;
  final WaterQuality waterQuality;
  final String contamination;

  Contamination({
    required this.cage,
    required this.timestamp,
    required this.waterQuality,
    required this.contamination,
  });

  factory Contamination.fromJson(Map<String, dynamic> json) {
    return Contamination(
      contamination: json['contamination'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        json['timestamp']['seconds'] * 1000,
      ),
      waterQuality: WaterQuality.fromJson(json['water_quality']),
      cage: json['cage'] ?? 0,
    );
  }
}

class ThresholdList {
  final DateTime timestamp;
  final String status;
  final int cage;
  final String contamination;

  ThresholdList({
    required this.timestamp,
    required this.status,
    required this.cage,
    required this.contamination,
  });

  factory ThresholdList.fromJson(Map<String, dynamic> json) {
    return ThresholdList(
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        json['timestamp']['seconds'] * 1000,
      ),
      status: json['status'],
      cage: json['cage'],
      contamination: json['contamination'] ?? '',
    );
  }
}




class History {
  final int deadFish;
  final String contamination;
  final DateTime timestamp;
  final WaterQuality waterQuality;
  final int cage;

  History({
    required this.deadFish,
    required this.contamination,
    required this.timestamp,
    required this.waterQuality,
    required this.cage,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      deadFish: json['dead_fish'] ?? 0,
      contamination: json['contamination'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        json['timestamp']['seconds'] * 1000,
      ),
      waterQuality: WaterQuality.fromJson(json['water_quality']),
      cage: json['cage'] ?? 0,
    );
  }
}

class WaterQuality {
  final double no2;
  final double ph;
  final double temperature;
  final double do2;

  WaterQuality({
    required this.no2,
    required this.ph,
    required this.temperature,
    required this.do2,
  });

  factory WaterQuality.fromJson(Map<String, dynamic> json) {
    return WaterQuality(
      no2: json['NO2']?.toDouble() ?? 0.0,
      ph: json['pH']?.toDouble() ?? 0.0,
      temperature: json['Temperature']?.toDouble() ?? 0.0,
      do2: json['DO']?.toDouble() ?? 0.0,
    );
  }
}