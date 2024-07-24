
/// The base model class for the application.
///
/// This class provides common properties and methods that other models can inherit from.
abstract class BaseModel { 

  final int cage;
  final DateTime timestamp;
  final String contamination;

  /// Constructs a new instance of the [BaseModel] class.
  ///
  /// The [cage] parameter represents the cage number.
  /// The [timestamp] parameter represents the date and time of the model.
  /// The [contamination] parameter represents the contamination level.
  BaseModel({
    required this.cage,
    required this.timestamp,
    required this.contamination
  });

  /// Creates a new instance of the [BaseModel] class from a JSON object.
  ///
  /// The [json] parameter represents the JSON object to deserialize.
  factory BaseModel.fromJson(Map<String, dynamic> json){
    throw UnimplementedError("fromJson has not been implemented.");
  }
}



