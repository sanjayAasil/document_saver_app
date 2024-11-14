import 'package:uuid/uuid.dart';

class Document {
  String id;
  String title;
  String filePath;
  DateTime dateTime;

  Document._({
    required this.id,
    required this.title,
    required this.filePath,
    required this.dateTime,
  });

  factory Document.create({required String title, required String filePath}) => Document._(
        id: const Uuid().v4(),
        title: title,
        filePath: filePath,
        dateTime: DateTime.now(),
      );

  factory Document.fromMap(Map<String, dynamic> json) => Document._(
        id: json['id'],
        title: json['title'],
        filePath: json['filePath'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
      );

  Map<String, dynamic> get map => {
        'id': id,
        'title': title,
        'filePath': filePath,
        'dateTime': dateTime.millisecondsSinceEpoch,
      };
}
