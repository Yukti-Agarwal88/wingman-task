import 'package:hive/hive.dart';
import 'package:wingman_task/models/hive_models.dart';

class Boxes {
  static Box<HiveModels> getData() => Hive.box<HiveModels>('hiveBox');
}
