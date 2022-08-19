class ApplicationFormModel {
  // user_id: 6, apply_type: 1, apply_sub_type: 3, apply_division: 1, date: 2022-08-10, updated_at: 2022-08-10 14:10:34, created_at: 2022-08-10 14:10:34, id: 1440

  String id = '';
  String userId = '';
  String applyType = '';
  String applySubType = '';
  String applyDivision = '';
  String date = '';
  String updatedAt = '';
  String createdAt = '';

  ApplicationFormModel({
    required this.id,
    required this.userId,
    required this.applyType,
    required this.applySubType,
    required this.applyDivision,
    required this.date,
    required this.updatedAt,
    required this.createdAt,
  });

  ApplicationFormModel.mapToObject(Map map) {
    id = map["id"].toString();
    userId = map["user_id"].toString();
    applyType = map["apply_type"].toString();
    applySubType = map["apply_sub_type"].toString();
    applyDivision = map["apply_division"].toString();
    date = map["date"].toString();
    updatedAt = map["updated_at"].toString();
    createdAt = map["created_at"].toString();
  }
}
