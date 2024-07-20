import 'package:save2woproj/model/base.dart';

/// Represents the contamination data.
class Contamination extends BaseModel {
  final WaterQuality waterQuality;

  /// Constructs a [Contamination] instance.
  Contamination({
    required super.cage,
    required super.timestamp,
    required this.waterQuality,
    required super.contamination,
  });

  /// Creates a [Contamination] object from a JSON map.
  ///
  /// The [json] parameter is a map containing the JSON data.
  /// The [json] map should have the following keys:
  ///   - 'cage': The cage value.
  ///   - 'timestamp': A map containing the timestamp data.
  ///   - 'water_quality': A map containing the water quality data.
  ///   - 'Contamination': The contamination value.
  ///
  /// Returns a [Contamination] object created from the JSON map.
  @override
  factory Contamination.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> waterQuality = json['water_quality'];
    final Map<String, dynamic> timestamp = json['timestamp'];
    final int milliseconds = (timestamp['seconds'] * 1000);

    return Contamination(
      cage: json['cage'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(milliseconds),
      waterQuality: WaterQuality(
        dissolvedOxygen: waterQuality["DO"],
        pH: waterQuality["pH"],
        temperature: waterQuality["Temperature"],
        nitrogen: waterQuality["NO2"],
      ),
      contamination: json['Contamination'],
    );
  }
}

/// Represents the threshold data.
class Threshold extends BaseModel {
  final String status;

  /// Constructs a [Threshold] instance.
  Threshold({
    required this.status,
    required super.cage,
    required super.timestamp,
    required super.contamination,
  });

  /// Creates a [Threshold] object from a JSON map.
  ///
  /// The [json] parameter is a map containing the JSON data.
  /// The [timestamp] is converted from milliseconds since epoch to a [DateTime] object.
  /// The [status], [cage], and [contamination] properties are extracted from the JSON map.
  /// If [contamination] is not present in the JSON map, it defaults to an empty string.
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

/// Represents the history data.
class History extends Contamination {
  //https://save2wo-api.vercel.app/history
  final int deadFish;

  /// Constructs a [History] instance.
  History({
    required super.cage,
    required super.timestamp,
    required super.waterQuality,
    required this.deadFish,
    required super.contamination,
  });

  /// Creates a [History] object from a JSON map.
  ///
  /// The [json] parameter is a map containing the data for the [History] object.
  /// The map should have the following keys:
  ///   - 'cage': The cage identifier (String).
  ///   - 'timestamp': The timestamp of the history entry (Map<String, dynamic>).
  ///   - 'water_quality': The water quality data (Map<String, dynamic>).
  ///   - 'dead_fish': The number of dead fish (int).
  ///   - 'contamination': The contamination level (bool).
  ///
  /// The 'timestamp' map should have the following keys:
  ///   - 'seconds': The number of seconds since the epoch (int).
  ///
  /// The 'water_quality' map should have the following keys:
  ///   - 'DO': The dissolved oxygen level (double).
  ///   - 'pH': The pH level (double).
  ///   - 'Temperature': The water temperature (double).
  ///   - 'NO2': The nitrogen level (double).
  ///
  /// Returns a new [History] object with the data from the JSON map.
  @override
  factory History.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> waterQuality = json['water_quality'];
    final Map<String, dynamic> timestamp = json['timestamp'];
    final int milliseconds = (timestamp['seconds'] * 1000) ?? DateTime.timestamp();

    return History(
      cage: json['cage'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(milliseconds),
      waterQuality: WaterQuality(
        dissolvedOxygen: waterQuality["DO"],
        pH: waterQuality["pH"],
        temperature: waterQuality["Temperature"],
        nitrogen: waterQuality["NO2"],
      ),
      deadFish: json['dead_fish'],
      contamination: json['contamination'],
    );
  }
}

/// Represents the water quality data.
///
/// This class contains information about the water quality, including the
/// dissolved oxygen level, pH level, nitrogen level, and temperature.
class WaterQuality {
  final int dissolvedOxygen;
  final double pH;
  final double nitrogen;
  final int temperature;

  /// Constructs a [WaterQuality] instance.
  ///
  /// The [dissolvedOxygen] parameter represents the dissolved oxygen level in
  /// the water, measured in milligrams per liter (mg/L).
  ///
  /// The [pH] parameter represents the pH level of the water, which indicates
  /// its acidity or alkalinity.
  ///
  /// The [nitrogen] parameter represents the nitrogen level in the water,
  /// measured in parts per million (ppm).
  ///
  /// The [temperature] parameter represents the temperature of the water,
  /// measured in degrees Celsius (°C).
  WaterQuality({
    required this.dissolvedOxygen,
    required this.pH,
    required this.nitrogen,
    required this.temperature,
  });
}
