// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  List<PredictionElement>? predictions;

  DataModel({
    this.predictions,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        predictions: json["predictions"] == null
            ? []
            : List<PredictionElement>.from(
                json["predictions"]!.map((x) => PredictionElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "predictions": predictions == null
            ? []
            : List<dynamic>.from(predictions!.map((x) => x.toJson())),
      };
}

class PredictionElement {
  String? id;
  DateTime? timestamp;
  PredictionPrediction? prediction;
  String? highestConfidenceClass;
  double? highestConfidenceScore;
  String? suggestions;
  String? imageUrl;
  String? predictionClass;
  double? confidence;

  PredictionElement({
    this.id,
    this.timestamp,
    this.prediction,
    this.highestConfidenceClass,
    this.highestConfidenceScore,
    this.suggestions,
    this.imageUrl,
    this.predictionClass,
    this.confidence,
  });

  factory PredictionElement.fromJson(Map<String, dynamic> json) =>
      PredictionElement(
        id: json["_id"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        prediction: json["prediction"] == null
            ? null
            : PredictionPrediction.fromJson(json["prediction"]),
        highestConfidenceClass: json["highest_confidence_class"],
        highestConfidenceScore: json["highest_confidence_score"]?.toDouble(),
        suggestions: json["suggestions"],
        imageUrl: json["image_url"],
        predictionClass: json["class"],
        confidence: json["confidence"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "timestamp": timestamp?.toIso8601String(),
        "prediction": prediction?.toJson(),
        "highest_confidence_class": highestConfidenceClass,
        "highest_confidence_score": highestConfidenceScore,
        "suggestions": suggestions,
        "image_url": imageUrl,
        "class": predictionClass,
        "confidence": confidence,
      };
}

class PredictionPrediction {
  List<List<int>>? boxes;
  List<double>? confidences;
  List<String>? classes;

  PredictionPrediction({
    this.boxes,
    this.confidences,
    this.classes,
  });

  factory PredictionPrediction.fromJson(Map<String, dynamic> json) =>
      PredictionPrediction(
        boxes: json["boxes"] == null
            ? []
            : List<List<int>>.from(
                json["boxes"]!.map((x) => List<int>.from(x.map((x) => x)))),
        confidences: json["confidences"] == null
            ? []
            : List<double>.from(json["confidences"]!.map((x) => x?.toDouble())),
        classes: json["classes"] == null
            ? []
            : List<String>.from(json["classes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "boxes": boxes == null
            ? []
            : List<dynamic>.from(
                boxes!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "confidences": confidences == null
            ? []
            : List<dynamic>.from(confidences!.map((x) => x)),
        "classes":
            classes == null ? [] : List<dynamic>.from(classes!.map((x) => x)),
      };
}
