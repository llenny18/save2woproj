
abstract class BaseModel { 

  final int cage;
  final DateTime timestamp;
  final String contamination;

  BaseModel({
    required this.cage,
    required this.timestamp,
    required this.contamination
  });

   factory BaseModel.fromJson(Map<String, dynamic> json){
    throw UnimplementedError("fromJson has not been implemented.");
   }
}



