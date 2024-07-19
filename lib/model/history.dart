


class History {
  //https://save2wo-api.vercel.app/history
  //cage int
  //timestamp
  //water quality
  //->DissolvedOxygen
  //->pH double
  //->NO2 double
  //->temperature double
  //dead_fish int
  //contamination string

  final int cage ;
  final DateTime timestamp ;
  final WaterQuality waterquality;
  final int deadFish;
  final String contamination;

  History({
    required this.cage,
    required this.timestamp,
    required this.waterquality,
    required this.deadFish,
    required this.contamination
  });

  factory History.fromJson(Map<String, dynamic> json){
    final Map<String, dynamic> waterQuality = json['water_quality'];
    final Map<String, dynamic> timestamp = json['timestamp'];
    final int milliseconds = (timestamp['seconds'] * 1000);
     
    return History(
      cage: json['cage'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(milliseconds) ,
      waterquality: WaterQuality(
          dissolvedOxygen: waterQuality["DO"],
          pH: waterQuality["pH"],
          temperature: waterQuality["Temperature"],
          nitrogen: waterQuality["NO2"]
          ),
      deadFish: json['dead_fish'],
      contamination: json['Contamination']
    );
  }
}


class WaterQuality{

  final int dissolvedOxygen;
  final double pH;
  final double nitrogen;
  final int temperature;

  WaterQuality({
    required this.dissolvedOxygen,
    required this.pH,
    required this.nitrogen,
    required this.temperature
  });
}