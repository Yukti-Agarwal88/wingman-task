import 'package:hive/hive.dart';

part 'hive_models.g.dart';

@HiveType(typeId: 0)
class HiveModels extends HiveObject {
  @HiveField(0)
  String? requestId;
  String? jwt;

  HiveModels({
    this.requestId,
    this.jwt,
  });

  HiveModels.fromJson(Map<String, dynamic> json) {
    // requestId = "0987654321";
    requestId = json['request_id'];
    jwt = json['jwt'];
  }
}
