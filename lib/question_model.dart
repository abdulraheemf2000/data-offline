import 'package:hive/hive.dart';
part 'question_model.g.dart';

@HiveType(typeId: 0)
class Question extends HiveObject{
  Question({required this.question, required this.answers});

  @HiveField(0)
  String question;

  @HiveField(1)
  Map answers;
}