class ApplicationFormModel {
  // user_id: 6, apply_type: 1, apply_sub_type: 3, apply_division: 1, date: 2022-08-10, updated_at: 2022-08-10 14:10:34, created_at: 2022-08-10 14:10:34, id: 1440

  String id;
  String user_id;
  String apply_type;
  String apply_sub_type;
  String apply_division;
  String is_religion;
  String serial_code;
  String fullname;
  String nrc;
  String applied_phone;
  String job_type;
  String position;
  String department;
  String salary;
  String applied_building_type;
  String applied_home_no;
  String applied_building;
  String applied_lane;
  String applied_street;
  String applied_quarter;
  String applied_town;
  String township_id;
  String district_id;
  String div_state_id;
  String date;
  String business_name;
  String is_light;
  String apply_tsf_type;
  String pole_type;
  String created_at;
  String updated_at;

  ApplicationFormModel({
    required this.id,
    required this.user_id,
    required this.apply_type,
    required this.apply_sub_type,
    required this.apply_division,
    required this.is_religion,
    required this.serial_code,
    required this.fullname,
    required this.nrc,
    required this.applied_phone,
    required this.job_type,
    required this.position,
    required this.department,
    required this.salary,
    required this.applied_building_type,
    required this.applied_home_no,
    required this.applied_building,
    required this.applied_lane,
    required this.applied_street,
    required this.applied_quarter,
    required this.applied_town,
    required this.township_id,
    required this.district_id,
    required this.div_state_id,
    required this.date,
    required this.business_name,
    required this.is_light,
    required this.apply_tsf_type,
    required this.pole_type,
    required this.created_at,
    required this.updated_at,
  });

  // ApplicationFormModel.mapToObject(Map map) {
  //   id = map["id"].toString();
  //   userId = map["user_id"].toString();
  //   applyType = map["apply_type"].toString();
  //   applySubType = map["apply_sub_type"].toString();
  //   applyDivision = map["apply_division"].toString();
  //   date = map["date"].toString();
  //   updatedAt = map["updated_at"].toString();
  //   createdAt = map["created_at"].toString();
  // }
}
